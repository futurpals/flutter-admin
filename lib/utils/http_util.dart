import 'package:dio/dio.dart';

import '../base/resp_body.dart';
import 'logger.dart';

class HttpUtil {
  final dio = createDio();
  String _token = "";
  String _apiKey = "";

  HttpUtil._internal();

  static final _singleton = HttpUtil._internal();

  factory HttpUtil() => _singleton;

  static Dio createDio() {
    var dio = Dio(BaseOptions(
      baseUrl: "", //For example : https:www.example.com
      connectTimeout: const Duration(seconds: 30),
      //30 secs
      receiveTimeout: const Duration(seconds: 30),
      //30 secs
      sendTimeout: const Duration(seconds: 30),
      //20secs
    ));
    dio.interceptors.addAll({ErrorInterceptor(dio)});
    return dio;
  }

  String get token => _token;

  set token(String? value) {
    if (value != null && value.isNotEmpty) {
      _token = value;
    }
  }

  String get apiKey => _apiKey;

  set apiKey(String? value) {
    if (value != null && value.isNotEmpty) {
      _apiKey = value;
    }
  }

  clearKeyToken() {
    _token = "";
    _apiKey = "";
  }

  ///[GET] We will use this method inorder to process get requests
  Future<ResponseBodyApi> get(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    void Function(int, int)? onReceiveProgress,
    bool addRequestInterceptor = true,
  }) async {
    Log.i("GETTING API FROM : ${dio.options.baseUrl + path}");
    if (addRequestInterceptor) {
      dio.interceptors
          .add(RequestInterceptor(dio, apiKey: apiKey, token: token));
    }
    Log.i("QUERY PARAMS=>$queryParameters");
    ResponseBodyApi responseBodyApi;
    try {
      Response res = await dio.get(dio.options.baseUrl + path,
          onReceiveProgress: onReceiveProgress,
          cancelToken: cancelToken,
          options: options,
          queryParameters: queryParameters);
      responseBodyApi = ResponseBodyApi.fromMap(res.data);
    } catch (e) {
      responseBodyApi = ResponseBodyApi(success: false, message: '请求出错了：$e');
    }
    return responseBodyApi;
  }

  ///[POST] We will use this method inorder to process post requests
  Future<ResponseBodyApi> post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    void Function(int, int)? onSendProgress,
    void Function(int, int)? onReceiveProgress,
    bool addRequestInterceptor = true,
  }) async {
    Log.i("URL : ${dio.options.baseUrl + path}");
    Log.i("Request body : $data");
    if (addRequestInterceptor) {
      dio.interceptors
          .add(RequestInterceptor(dio, apiKey: apiKey, token: token));
    }
    ResponseBodyApi responseBodyApi;
    try {
      Response res = await dio.post(dio.options.baseUrl + path,
          data: FormData.fromMap(data),
          queryParameters: queryParameters,
          options: options,
          cancelToken: cancelToken,
          onReceiveProgress: onReceiveProgress,
          onSendProgress: onSendProgress);
      responseBodyApi = ResponseBodyApi.fromMap(res.data);
    } catch (e) {
      responseBodyApi = ResponseBodyApi(success: false, message: '请求出错了：$e');
    }
    return responseBodyApi;
  }
}

class ErrorInterceptor extends Interceptor {
  final Dio dio;

  ErrorInterceptor(this.dio);

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    switch (err.type) {
      case DioExceptionType.connectionTimeout:
        throw ConnectionTimeOutException(err.requestOptions);
      case DioExceptionType.sendTimeout:
        throw SendTimeOutException(err.requestOptions);
      case DioExceptionType.receiveTimeout:
        throw ReceiveTimeOutException(err.requestOptions);
      case DioExceptionType.badResponse:
        Log.i("STATUS CODE : ${err.response?.statusCode}");
        Log.i("${err.response?.data}");
        switch (err.response?.statusCode) {
          case 400:
            throw BadRequestException(err.requestOptions);
          case 401:
            throw UnauthorizedException(err.requestOptions);
          case 404:
            throw NotFoundException(err.requestOptions);
          case 409:
            throw ConflictException(err.requestOptions);
          case 500:
            throw InternalServerErrorException(err.requestOptions);
        }
        break;
      case DioExceptionType.cancel:
        // TODO: Handle this case.
        break;
      case DioExceptionType.unknown:
        Log.i(err.message);
        throw NoInternetConnectionException(err.requestOptions);
      case DioExceptionType.badCertificate:
        // TODO: Handle this case.
        throw UnimplementedError();
      case DioExceptionType.connectionError:
        // TODO: Handle this case.
        throw UnimplementedError();
    }
    return handler.next(err);
  }
}

class RequestInterceptor extends Interceptor {
  final Dio dio;
  final String apiKey;
  final String token;

  RequestInterceptor(this.dio, {required this.token, required this.apiKey});

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    options.headers = {'apiKey': apiKey, 'token': token};
    return handler.next(options);
  }
}

class ConnectionTimeOutException extends DioException {
  ConnectionTimeOutException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'Connection Timed out, Please try again';
  }
}

class SendTimeOutException extends DioException {
  SendTimeOutException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'Send Timed out, Please try again';
  }
}

class ReceiveTimeOutException extends DioException {
  ReceiveTimeOutException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'Receive Timed out, Please try again';
  }
}

//**********-----STATUS CODE ERROR HANDLERS--------**********

class BadRequestException extends DioException {
  BadRequestException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'Invalid request';
  }
}

class InternalServerErrorException extends DioException {
  InternalServerErrorException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'Internal server error occurred, please try again later.';
  }
}

class ConflictException extends DioException {
  ConflictException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'Conflict occurred';
  }
}

class UnauthorizedException extends DioException {
  UnauthorizedException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'Access denied';
  }
}

class NotFoundException extends DioException {
  NotFoundException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'The requested information could not be found';
  }
}

class NoInternetConnectionException extends DioException {
  NoInternetConnectionException(RequestOptions r) : super(requestOptions: r);

  @override
  String toString() {
    return 'No internet connection detected, please try again.';
  }
}
