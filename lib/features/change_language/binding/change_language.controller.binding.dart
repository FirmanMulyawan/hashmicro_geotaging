part of change_language_lib;

class ChangeLanguageControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChangeLanguageController>(
      () => ChangeLanguageController(),
    );
  }
}
