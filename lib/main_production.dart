import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'main.dart';
import 'utils/path/environment.dart';

Future<void> main() async {
  await dotenv.load(fileName: environmentPath.production).then((value) {
    kAppEnvironment = dotenv.env['NAME']!;
    kBaseUrl = dotenv.env['BASE_URL']!;
    kBulkUrl = dotenv.env['BULK_URL']!;
    kIsDevelopment = false;
    debugPrint("RUNNING ENVIRONMENT => $kAppEnvironment");
    debugPrint("BASE URL : $kBaseUrl");
    start();
  });
}
