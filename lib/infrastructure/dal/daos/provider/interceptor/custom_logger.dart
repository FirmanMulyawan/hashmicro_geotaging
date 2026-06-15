import 'dart:developer';

import 'package:dio/dio.dart';

import '../../../../../utils/path/environment.dart';

class CustomLogger {
  static onResponseLogger(
      {required Response<dynamic> response,
      bool? logRequest,
      bool? queryParams,
      bool? header}) {
    void logError(String msg) {
      log('\x1B[31m$msg\x1B[0m');
    }

    String server = kIsDevelopment == true ? "Staging" : "Production";
    String getport = response.requestOptions.uri.port.toString();
    String port = getport == "3001" ? "Slave" : "Master";
    String urlWithoutQuery = response.requestOptions.uri.queryParameters.isEmpty
        ? response.requestOptions.uri.toString()
        : response.requestOptions.uri.replace(queryParameters: {}).toString();

    if (response.statusCode == 200 || response.statusCode == 201) {
      if (response.requestOptions.method != "GET") {
        final dynamic data = response.requestOptions.data;
        if (data != null) {
          if (data is Map) {
            _logSuccess(response, queryParams, port, server, urlWithoutQuery,
                logRequest, data, false, header);
          }
          if (data is FormData) {
            _logSuccess(response, queryParams, port, server, urlWithoutQuery,
                logRequest, data.fields, false, header);
          }
        }
      } else {
        // Handle GET request - safely access response data
        dynamic responseData;
        if (response.data != null &&
            response.data is Map &&
            response.data.containsKey('data')) {
          responseData = response.data['data'];
        } else {
          responseData = response.data;
        }
        _logSuccess(response, queryParams, port, server, urlWithoutQuery,
            logRequest, responseData, true, header);
      }
    } else {
      logError("${response.requestOptions.method} | $port  | $urlWithoutQuery");
    }
  }

  static void _logSuccess(
      Response<dynamic> response,
      bool? queryParams,
      String port,
      String server,
      String url,
      bool? requestBody,
      dynamic data,
      bool isGetMethode,
      bool? isHeader) {
    String divider =
        "=============================================================================================";
    String bodyTitle = response.requestOptions.method == "GET"
        ? "🎁 Response Body :"
        : "📥 Request Data :";
    String message =
        "${response.requestOptions.method} ${response.statusCode} | $url";

    _baseLogs(response, queryParams, message, server, port);
    if (isHeader == null) {
      _logHeader(response, queryParams, message, server, port);
    }
    if (requestBody == true) {
      if (isGetMethode == true) {
        if (data is List) {
          _logDataList(bodyTitle, data);
        } else {
          _logDataMap(bodyTitle, data);
        }
      } else {
        _logPostRequest(bodyTitle, data, response);
      }
    }

    log('\x1B[32m${"🐲 $divider 🐲"}\x1B[0m');
    log("\n");
  }
  // Log Header

  static void _baseLogs(Response<dynamic> response, bool? queryParams,
      String msg, String server, String port) {
    log('\x1B[32m${"🌐 $server | $port"}\x1B[0m');
    log('\x1B[32m${"✅ $msg"}\x1B[0m');
    if (response.requestOptions.queryParameters.isNotEmpty &&
        queryParams == true) {
      String formattedParams = response.requestOptions.queryParameters.entries
          .map((entry) => '${entry.key}: ${entry.value}')
          .join(' - ');
      log('\x1B[32m${"🔍 Query Parameters: "}\x1B[0m\x1B[33m$formattedParams\x1B[0m');
    }
    log('\x1B[32m${"😁 Message : Success"}\x1B[0m');
  }

  // Log Header

  static void _logHeader(Response<dynamic> response, bool? queryParams,
      String msg, String server, String port) {
    Headers header = response.headers;
    log('\x1B[32m${"📇 Headers :"}\x1B[0m');
    log('\x1B[38;2;205;133;63m${"   1. Authorization : ${header['Authorization'] ?? 'null'}"}\x1B[0m');
    log('\x1B[38;2;205;133;63m${"   2. Content-Type : ${header['Content-Type'] ?? 'null'}"}\x1B[0m');
  }

  // Log Data List

  static void _logDataList(String bodyTitle, dynamic data) {
    log('\x1B[32m$bodyTitle\x1B[0m');
    for (int i = 0; i < data.length; i++) {
      if (data[i] is Map<String, dynamic>) {
        log('\x1B[35m${"   ${i + 1}. Item :"}\x1B[0m');
        data[i].forEach((key, value) {
          log('\x1B[35m${'       - $key : ${value ?? "null"}'}\x1B[0m');
        });
      } else {
        log('\x1B[35m${'   ${i + 1}. ${data[i] ?? "null"}'}\x1B[0m');
      }
    }
  }

  // Log Data Mapping

  static void _logDataMap(String bodyTitle, dynamic data) {
    log('\x1B[32m$bodyTitle\x1B[0m');

    if (data is! Map<String, dynamic>) {
      // Handle FormData fields which are List<MapEntry<String, String>>
      if (data is List && data.isNotEmpty && data.first is MapEntry) {
        log('\x1B[35mFormData Fields:\x1B[0m');
        int index = 1;
        for (final entry in data) {
          if (entry is MapEntry) {
            log('\x1B[35m${"   $index. ${entry.key} : ${entry.value}"}\x1B[0m');
            index++;
          }
        }
        return;
      }
      log('\x1B[31mInvalid data: Expected a Map<String, dynamic>, but got ${data.runtimeType}\x1B[0m');
      return;
    }

    int index = 1;
    data.forEach((key, value) {
      log('\x1B[35m${"   $index. $key : ${value ?? "null"}"}\x1B[0m');
      index++;
    });
  }

  // Log Post Request

  static void _logPostRequest(
      String bodyTitle, dynamic dataRequest, Response<dynamic> response) {
    _logDataMap(bodyTitle, dataRequest);
    log('\x1B[32m${"🎁   Response Body :"}\x1B[0m');
    int index = 1;

    if (response.data is Map && response.data.containsKey('data')) {
      final responseData = response.data['data'];
      if (responseData is Map<String, dynamic>) {
        responseData.forEach((key, value) {
          log('\x1B[35m${"   $index. $key : ${value ?? "null"}"}\x1B[0m');
          index++;
        });
      } else if (responseData != null) {
        log('\x1B[35m   1. Data : $responseData\x1B[0m');
      }
    } else if (response.data != null) {
      if (response.data is Map<String, dynamic>) {
        response.data.forEach((key, value) {
          log('\x1B[35m${"   $index. $key : ${value ?? "null"}"}\x1B[0m');
          index++;
        });
      } else {
        log('\x1B[35m   1. Body : ${response.data}\x1B[0m');
      }
    }
  }
}
