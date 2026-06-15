// ignore_for_file: constant_identifier_names

class Routes {
  static Future<String> get initialRoute async {
    return SPLASH_SCREEN;
  }

  static const HOME = '/home';
  static const SPLASH_SCREEN = '/splash-screen';
  static const LOGIN = '/login';
  static const MAIN_PAGES = '/main-pages';
  static const CHANGE_LANGUAGE = '/change-language';
}
