part of setting_lib;

class SettingRepositoryImpl implements UserRepository {
  @override
  Future<DataState<UserProfileResponse>> getUser(int userId) async {
    try {
      final response =
          await RemoteProvider.get(path: '${Endpoint.getUser}/$userId');
      return DataState<UserProfileResponse>(
          status: StatusCodeResponse.cek(response: response),
          result: UserProfileResponse.fromJson(response.data));
    } on DioException catch (e) {
      return (e.response?.data != null)
          ? DataState<UserProfileResponse>(
              status: StatusResponse.failed,
              result: UserProfileResponse.fromJson(e.response?.data),
            )
          : CustomException<UserProfileResponse>().dio(e);
    }
  }
}
