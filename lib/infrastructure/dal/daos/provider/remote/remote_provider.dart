import 'package:dio/dio.dart';
import '../../../../../features/dev_tools/http_activity_interceptor.dart';
import '../../../../../utils/path/environment.dart';
import '../interceptor/header_interceptors.dart';

class RemoteProvider {
  static final Dio _dioInstance = Dio();
  static late BaseOptions _baseOptionBulkUrl;
  static late BaseOptions _baseOptionBaseUrl;

  static init() {
    _baseOptionBulkUrl = BaseOptions(baseUrl: kBaseUrl);
    _baseOptionBaseUrl = BaseOptions(baseUrl: kBaseUrl);
    _dioInstance.interceptors.add(headerInterceptor(logs: kIsDevelopment));
    // Add HTTP Activity Interceptor for development only
    if (kIsDevelopment) {
      _dioInstance.interceptors.add(HttpActivityInterceptor());
    }
  }

  static Future<Response> post(
      {required String path, Object? data, Options? options}) async {
    _dioInstance.options = _baseOptionBulkUrl;
    return await _dioInstance.post(path, data: data, options: options);
  }

  static Future<Response> fileUpload(
      {required String path,
      required String filePath,
      required String folder,
      required String acceptLanguage}) async {
    FormData formData = FormData.fromMap({
      'file': await MultipartFile.fromFile(filePath),
      'folder': folder,
    });

    Options options = Options(
      headers: {
        'Accept-Language': acceptLanguage,
        ..._baseOptionBulkUrl.headers,
      },
      method: _baseOptionBulkUrl.method,
      contentType: _baseOptionBulkUrl.contentType,
      responseType: _baseOptionBulkUrl.responseType,
      extra: _baseOptionBulkUrl.extra,
      followRedirects: _baseOptionBulkUrl.followRedirects,
      maxRedirects: _baseOptionBulkUrl.maxRedirects,
      receiveDataWhenStatusError: _baseOptionBulkUrl.receiveDataWhenStatusError,
      requestEncoder: _baseOptionBulkUrl.requestEncoder,
      responseDecoder: _baseOptionBulkUrl.responseDecoder,
      sendTimeout: _baseOptionBulkUrl.sendTimeout,
      receiveTimeout: _baseOptionBulkUrl.receiveTimeout,
    );
    return await _dioInstance.post(path, data: formData, options: options);
  }

  static Future<Response> put({required String path, Object? data}) async {
    _dioInstance.options = _baseOptionBulkUrl;
    return await _dioInstance.put(path, data: data);
  }

  static Future<Response> patch({required String path, Object? data}) async {
    _dioInstance.options = _baseOptionBulkUrl;
    return await _dioInstance.patch(path, data: data);
  }

  static Future<Response> get(
      {required String path,
      Map<String, dynamic>? queryParameters,
      bool? showLogs}) async {
    _dioInstance.options = _baseOptionBaseUrl;
    return await _dioInstance.get(path, queryParameters: queryParameters);
  }

  static Future<Response> delete({required String path}) async {
    _dioInstance.options = _baseOptionBaseUrl;
    return await _dioInstance.delete(path);
  }

  static Future<Response> postFormData({
    required String path,
    required FormData formData,
  }) async {
    _dioInstance.options = _baseOptionBulkUrl;
    return await _dioInstance.post(
      path,
      data: formData,
      options: Options(contentType: 'multipart/form-data'),
    );
  }

  static Future<Response> putFormData({
    required String path,
    required FormData formData,
  }) async {
    _dioInstance.options = _baseOptionBulkUrl;
    return await _dioInstance.put(
      path,
      data: formData,
      options: Options(contentType: 'multipart/form-data'),
    );
  }

  static Future<Response> patchFormData({
    required String path,
    required FormData formData,
  }) async {
    _dioInstance.options = _baseOptionBulkUrl;
    return await _dioInstance.patch(
      path,
      data: formData,
      options: Options(contentType: 'multipart/form-data'),
    );
  }
}
