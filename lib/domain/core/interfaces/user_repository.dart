import '../../../utils/network/data_state.dart';
import '../model/model_response/user_profile_response.dart';

abstract class UserRepository {
  Future<DataState<UserProfileResponse>> getUser(int userId);
}
