import '../base/resp_body.dart';
import '../utils/http_util.dart';

class FileApi {
  static Future<ResponseBodyApi> upload(data) async {
    return await HttpUtil().post('/login', data: data);
  }
}
