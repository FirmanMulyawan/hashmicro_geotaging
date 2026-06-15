import '../../../utils/network/data_state.dart';
import '../model/model_requrest/login_request.dart';
import '../model/model_response/login_response.dart';

abstract class LoginRepository {
  Future<DataState<LoginResponse>> postLogin(LoginRequest body);
}
