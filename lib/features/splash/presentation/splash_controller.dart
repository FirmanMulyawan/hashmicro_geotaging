part of splash_lib;

class SplashController extends GetxController {
  double progress = 0.0;
  bool _isRequestingPermission = false;

  StorageUtil storage = Get.find();

  SplashController();

  @override
  void onInit() {
    progressBar();
    super.onInit();
  }

  void progressBar() async {
    await Future.delayed(const Duration(milliseconds: 600));
    progress = 0.5;
    update();
    await Future.delayed(const Duration(milliseconds: 600));
    progress = 1;
    update();
    await Future.delayed(const Duration(milliseconds: 300));
    getStarted();
  }

  Future<bool> checkAndRequestLocationPermission() async {
    var status = await Permission.location.status;

    if (status.isDenied) {
      status = await Permission.location.request();
    }

    if (status.isPermanentlyDenied) {
      await openAppSettings();
      return false;
    }

    return status.isGranted;
  }

  Future<void> getStarted() async {
    if (_isRequestingPermission) return;

    _isRequestingPermission = true;

    try {
      final granted = await checkAndRequestLocationPermission();

      if (granted) {
        _userLoggedIn();
      }
    } finally {
      _isRequestingPermission = false;
    }
  }

  Future _userLoggedIn() async {
    final token = await storage.getToken();
    if (token != null) {
      Get.offNamed(Routes.MAIN_PAGES);
    } else {
      Get.offNamed(Routes.LOGIN);
    }
  }
}
