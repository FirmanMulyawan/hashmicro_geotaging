part of setting_lib;

class SettingController extends GetxController {
  final StorageUtil _storageUtil = Get.find();
  final UserRepository _userRepository;

  UserResponse? getUserData;
  UserProfileResponse? userProfile;
  bool isLoading = true;

  SettingController(this._userRepository);

  List<Map<String, dynamic>> get menuSetting => [
        {
          'icon': AssetsSvg.userCircle,
          'title': 'general_info'.tr,
          'subtitle': 'get_more_detail_information'.tr
        },
        {
          'icon': AssetsSvg.globe,
          'title': 'language'.tr,
          'subtitle': 'change_language'.tr
        },
        {'icon': AssetsSvg.signout, 'title': 'logout'.tr, 'subtitle': ''}
      ];

  @override
  void onInit() {
    getUserData = AppPreference().getUserData();

    setData();
    super.onInit();
  }

  Future<void> setData() async {
    isLoading = true;
    update();

    try {
      final response = await _userRepository.getUser(getUserData?.id ?? 1);
      if (response.status == StatusResponse.success) {
        userProfile = response.result;

        update();
      }
    } catch (_) {
    } finally {
      isLoading = false;
      update();
    }
  }

  void selectMenu(int index) {
    switch (index) {
      case 0:
        openDetailUser();
        break;
      case 1:
        Get.toNamed(Routes.CHANGE_LANGUAGE);
        break;
      case 2:
        logoutDialog();
        break;
    }
  }

  void openDetailUser() {
    CustomBottomSheet.show(child: const ShowDetailUser());
  }

  void logoutDialog() async {
    await AlertModel.showAlert(
        title: 'logout'.tr,
        message: 'logout_confirmation'.tr,
        mainColor: AppStyle.progressBarBottomBlue,
        hoverColor: AppStyle.progressBarTopBlue,
        buttonText: 'yes'.tr,
        onPressed: () {
          Get.back();
          _storageUtil.removeLogin();
          Get.offAllNamed(Routes.LOGIN);
        });
  }
}
