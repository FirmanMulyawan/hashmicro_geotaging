part of login_library;

class LoginController extends GetxController {
  final LoginRepository _loginRepository;
  // Text Editing Controller
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String? versionApp;

  // Variable
  var actionStatus = ActionStatus.initalize;
  String? dateNow;
  var isUsernameValidated = false.obs;
  var isPasswordValidated = false.obs;

  List<String> errorMessagesEmail = [];
  List<String> errorMessagesPassword = [];
  StorageUtil storage = Get.find();

  LoginController(this._loginRepository);

  @override
  void onInit() {
    setDate();
    checkVersion();
    super.onInit();
  }

  Future<void> login() async {
    errorMessagesEmail.clear();
    errorMessagesPassword.clear();

    actionStatus = ActionStatus.loading;
    update();

    var param = LoginRequest(
      username: usernameController.text,
      password: passwordController.text,
    );

    final response = await _loginRepository.postLogin(param);
    if (response.status == StatusResponse.success) {
      update();
      await storage.setToken(response.result?.accessToken ?? '');
      await storage.setRefreshToken(response.result?.refreshToken ?? '');
      AppPreference().saveUserData(
          userData: UserResponse(
        username: response.result?.username,
        email: response.result?.email,
        firstName: response.result?.firstName,
        lastName: response.result?.lastName,
        gender: response.result?.gender,
        id: response.result?.id,
        image: response.result?.image,
      ));
      actionStatus = ActionStatus.success;
      Get.offNamed(Routes.MAIN_PAGES);
    } else {
      actionStatus = ActionStatus.failed;
      update();
      await AlertModel.showConfirmation(
        title: 'error'.tr,
        message: response.result?.message ?? '',
        confirmText: 'yes'.tr,
        hoverColor: AppStyle.progressBarTopBlue,
        mainColor: AppStyle.progressBarBottomBlue,
      );
    }
  }

  void setDate() {
    DateTime now = DateTime.now();
    dateNow = DateFormat('EEEE, dd MMMM yyyy').format(now);
  }

  void listenUsernameForm(String value) {
    if (value.isNotEmpty) {
      isUsernameValidated(true);
    } else {
      isUsernameValidated(false);
    }
  }

  void listenPasswordForm(String value) {
    if (value.length > 4) {
      isPasswordValidated(true);
    } else {
      isPasswordValidated(false);
    }
  }

  checkVersion() async {
    final packageInfo = await PackageInfo.fromPlatform();
    versionApp = "Version ${packageInfo.version}";
    update();
  }
}
