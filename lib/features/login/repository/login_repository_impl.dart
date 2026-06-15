// ignore_for_file: empty_catches

import 'package:dio/dio.dart';

import '../../../domain/core/interfaces/login_repository.dart';
import '../../../domain/core/model/model_requrest/login_request.dart';
import '../../../domain/core/model/model_response/login_response.dart';
import '../../../infrastructure/dal/daos/provider/endpoint/endpoint.dart';
import '../../../infrastructure/dal/daos/provider/remote/remote_provider.dart';
import '../../../utils/network/code_response.dart';
import '../../../utils/network/custom_exception.dart';
import '../../../utils/network/data_state.dart';
import '../../../utils/network/status_response.dart';

class LoginRepositoryImpl implements LoginRepository {
  @override
  Future<DataState<LoginResponse>> postLogin(LoginRequest body) async {
    try {
      final response = await RemoteProvider.post(
          path: Endpoint.postLogin, data: body.toMap());

      return DataState<LoginResponse>(
        status: StatusCodeResponse.cek(response: response),
        result: LoginResponse.fromJson(response.data),
      );
    } on DioException catch (e) {
      return (e.response?.data != null)
          ? DataState<LoginResponse>(
              status: StatusResponse.failed,
              result: LoginResponse.fromJson(e.response?.data),
            )
          : CustomException<LoginResponse>().dio(e);
    }
  }
}
