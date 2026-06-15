import 'dart:developer';

import 'package:dio/dio.dart';
import '../../infrastructure/dal/daos/provider/custom_error/timeout_error.dart';
import '../path/environment.dart';
import 'data_state.dart';
import 'status_response.dart';

class CustomException<T> {
  DataState<T> dio(DioException e, [String? errorMessageDefault]) {
    bool isTimeout = TimeOutError.check(e);
    String server = kIsDevelopment == true ? "Staging" : "Production";
    if (isTimeout) {
      return DataState<T>(
        status: StatusResponse.timeout,
        message: "Request Timeout",
      );
    } else {
      String getport = e.response?.requestOptions.uri.port.toString() ?? '';
      String port = getport == "3001" ? "Slave" : "Master";
      String methode = "No Methode";
      String path = "Path - Notfound";
      String errorMessage = "Unknown error occurred";
      String divider =
          "=============================================================================================";

      dynamic errors;
      if (errorMessageDefault != null) {
        errorMessage = errorMessageDefault;
      } else {
        if (e.response?.data is Map &&
            e.response!.data['data'] is Map &&
            e.response!.data['data']['message'] != null) {
          methode = e.response?.requestOptions.method ?? 'No Methode';
          errorMessage = e.response?.data['data']['message'];
          errors = e.response?.data['data']['errors'];
          path = e.response?.requestOptions.uri.toString() ?? '';
        } else if (e.response?.data is Map<String, dynamic>) {
          final data = e.response!.data as Map<String, dynamic>;
          if (data['message'] != null) {
            errorMessage = data['message'];
          } else {
            errorMessage = e.message.toString();
          }
          errors = data['errors'];
          methode = e.response?.requestOptions.method ?? 'No Methode';
          path = e.response?.requestOptions.uri.toString() ?? '';
        } else {
          methode = e.response?.requestOptions.method ?? 'No Methode';

          // errorMessage = e.message.toString();
          errorMessage =
              "The error has not been handled on the server side yet.";

          path = e.response?.requestOptions.uri.toString() ?? '';
        }
      }
      log("\n");
      log('\x1B[31m${"🌐 $server | $port"}\x1B[0m');
      log('\x1B[31m${"🚨 $methode ${e.response?.statusCode} | $path"}\x1B[0m');
      log('\x1B[31m${"🤯 Message : $errorMessage"}\x1B[0m');
      log('\x1B[31m${"👹 $divider 👹"}\x1B[0m');
      log("\n");

      return DataState<T>(
        path: path,
        status: StatusResponse.failed,
        message: errorMessage,
        errors: errors,
      );
    }
  }
}
