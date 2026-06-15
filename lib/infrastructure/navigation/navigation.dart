import 'package:get/get.dart';

import '../../features/change_language/change_language_lib.dart';
import '../../features/login/login_lib.dart';
import '../../features/main/main_lib.dart';
import '../../features/splash/splash_lib.dart';
import 'routes.dart';

class Nav {
  static List<GetPage> routes = [
    GetPage(
      name: Routes.SPLASH_SCREEN,
      page: () => const SplashScreen(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: Routes.LOGIN,
      page: () => const LoginScreen(),
      binding: LoginControllerBinding(),
    ),
    GetPage(
      name: Routes.MAIN_PAGES,
      page: () => const MainScreen(),
      binding: MainControllerBinding(),
    ),
    GetPage(
      name: Routes.CHANGE_LANGUAGE,
      page: () => const ChangeLanguageScreen(),
      binding: ChangeLanguageControllerBinding(),
    ),
  ];
}
