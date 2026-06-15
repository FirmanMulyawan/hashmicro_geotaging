import 'dart:io';

import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../../../../../utils/path/environment.dart';
import '../../../../navigation/routes.dart';
import 'custom_logger.dart';

InterceptorsWrapper headerInterceptor({required bool logs}) {
  showAllLogs = logs;
  return InterceptorsWrapper(
    onRequest: (options, handler) {
      options.connectTimeout = 15.seconds;
      options.receiveTimeout = 15.seconds;
      options.sendTimeout = 15.seconds;

      options.headers[HttpHeaders.contentTypeHeader] = 'application/json';

      return handler.next(options);
    },
    onResponse: (response, handler) {
      if (showAllLogs == true) {
        CustomLogger.onResponseLogger(response: response, logRequest: logs);
      }

      return handler.next(response);
    },
    onError: (err, handler) {
      if (err.response?.statusCode == 401) {
        Get.offAllNamed(Routes.SPLASH_SCREEN);
      }
      return handler.next(err);
    },
  );
}
