part of login_library;

class LoginControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(
      () => LoginController(
        LoginRepositoryImpl(),
      ),
    );
  }
}
