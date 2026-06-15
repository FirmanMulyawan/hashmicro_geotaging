import 'package:dio/dio.dart';

import '../../infrastructure/dal/daos/provider/interceptor/custom_logger.dart';
import '../path/environment.dart';
import 'status_response.dart';

class StatusCodeResponse {
  static StatusResponse cek(
      {required Response<dynamic> response,
      bool? showLogs,
      bool? queryParams}) {
    if (response.statusCode == 200 || response.statusCode == 201) {
      if (showAllLogs == false) {
        CustomLogger.onResponseLogger(
            response: response, logRequest: showLogs, queryParams: queryParams);
      }
      return StatusResponse.success;
    } else {
      return StatusResponse.failed;
    }
  }
}
