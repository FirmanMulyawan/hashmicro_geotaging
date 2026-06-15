part of main_lib;

class MainControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(
      MainPagesController(),
    );
    Get.put(
      HomeController(),
    );

    Get.put(
      SettingController(SettingRepositoryImpl()),
    );
  }
}
