import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../infrastructure/dal/daos/provider/remote/remote_provider.dart';
import '../utils/app_preference/app_preferences.dart';
import '../utils/local_storage/objectbox.dart';

class AppConfig {
  static Future<void> init() async {
    WidgetsFlutterBinding.ensureInitialized();
    await LocalStorage().init();
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    await AppPreference.init();
    await RemoteProvider.init();
  }
}
