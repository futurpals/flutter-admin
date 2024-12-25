import 'package:logger/logger.dart';

class Log {
  static final Logger _logger = Logger(
    printer: PrettyPrinter(),
  );

  static void t(
    dynamic message, {
    DateTime? time,
    Object? error,
    StackTrace? stackTrace,
  }) {
    _logger.t(message, time: time, error: error, stackTrace: stackTrace);
  }

  static void d(
      dynamic message, {
        DateTime? time,
        Object? error,
        StackTrace? stackTrace,
      }) {
    _logger.d(message, time: time, error: error, stackTrace: stackTrace);
  }

  static void i(
      dynamic message, {
        DateTime? time,
        Object? error,
        StackTrace? stackTrace,
      }) {
    _logger.i(message, time: time, error: error, stackTrace: stackTrace);
  }

  static void w(
      dynamic message, {
        DateTime? time,
        Object? error,
        StackTrace? stackTrace,
      }) {
    _logger.w(message, time: time, error: error, stackTrace: stackTrace);
  }

  static void e(
      dynamic message, {
        DateTime? time,
        Object? error,
        StackTrace? stackTrace,
      }) {
    _logger.e(message, time: time, error: error, stackTrace: stackTrace);
  }


  static void wtf(
    dynamic message, {
    DateTime? time,
    Object? error,
    StackTrace? stackTrace,
  }) {
    _logger.f(message, time: time, error: error, stackTrace: stackTrace);
  }
}
