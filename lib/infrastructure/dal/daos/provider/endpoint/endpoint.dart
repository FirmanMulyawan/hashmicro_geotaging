import '../../../../../utils/path/environment.dart';

class Endpoint {
  static String get baseUrl => kBaseUrl;
  static String get bulkUrl => kBulkUrl;

  static String postLogin = 'auth/login';
  static String getUser = 'users';
}
