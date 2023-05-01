import 'package:logger/logger.dart';

final logger = _CustomLogger();

final _log = Logger(
  printer: PrettyPrinter(
    methodCount: 2,
    errorMethodCount: 8,
    lineLength: 50,
    colors: true,
    printEmojis: true,
    printTime: true,
  ),
);

class _CustomLogger {
  void printInfo(dynamic message, [dynamic extra, StackTrace? stackTrace]) {
    _log.i(message, extra, stackTrace);
  }

  void printVerbose(dynamic message, [dynamic extra, StackTrace? stackTrace]) {
    _log.v(message, extra, stackTrace);
  }

  void printWtf(dynamic message, [dynamic extra, StackTrace? stackTrace]) {
    _log.wtf(message, extra, stackTrace);
  }

  void printDebug(dynamic message, [dynamic extra, StackTrace? stackTrace]) {
    _log.d(message, extra, stackTrace);
  }

  void printWarning(dynamic message, [dynamic extra, StackTrace? stackTrace]) {
    _log.w(message);
  }

  void printError(dynamic message, [dynamic extra, StackTrace? stackTrace]) {
    _log.e(message);
  }
}
