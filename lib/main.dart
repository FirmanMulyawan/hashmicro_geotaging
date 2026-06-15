// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'config/app_config.dart';
import 'infrastructure/translations/app_translations.dart';
import 'infrastructure/navigation/navigation.dart';
import 'infrastructure/navigation/routes.dart';
import 'features/dev_tools/dev_tools_fab.dart';
import 'utils/app_preference/app_preferences.dart';
import 'utils/app_preference/secure_storage.dart';

Future<void> start() async {
  await AppPreference.init();

  var initialRoute = await Routes.initialRoute;

  await AppConfig.init();
  await _dependencyInjection();
  // Load saved language
  final prefs = await SharedPreferences.getInstance();
  final savedLanguage = prefs.getString('selected_language') ?? 'en_US';
  final parts = savedLanguage.split('_');
  final savedLocale = Locale(parts[0], parts.length > 1 ? parts[1] : '');

  initializeDateFormatting('id_ID', null).then((_) {
    runApp(Main(initialRoute, savedLocale));
  });
}

Future _dependencyInjection() async {
  final storage = StorageUtil(SecureStorage());
  Get.lazyPut(() => storage, fenix: true);
  // final dataSource = LoginDatasource(Network.dioClient());
  // Get.lazyPut(() => dataSource, fenix: true);
  // final repository = LoginRepository(Get.find());
  // Get.lazyPut(() => repository, fenix: true);
  // Get.put(AppService(storage));
}

class Main extends StatelessWidget {
  final String initialRoute;
  final Locale savedLocale;
  const Main(this.initialRoute, this.savedLocale, {super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: const Size(360, 800),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, widgets) {
          return MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
            child: GetMaterialApp(
              initialRoute: initialRoute,
              debugShowCheckedModeBanner: false,
              useInheritedMediaQuery: true,
              getPages: Nav.routes,
              translations: AppTranslations(),
              locale: savedLocale,
              fallbackLocale: const Locale('en', 'US'),
              builder: (context, child) {
                return Stack(
                  children: [
                    child ?? const SizedBox.shrink(),
                    const DevToolsFab(),
                  ],
                );
              },
            ),
          );
        });
  }
}
