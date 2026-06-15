part of setting_lib;

class AppBarSetting extends StatelessWidget implements PreferredSizeWidget {
  const AppBarSetting({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        'profile'.tr,
        style: AppStyle.semibold(
          fontSize: 13,
          color: AppStyle.kWhite,
        ),
      ),
      centerTitle: true,
      backgroundColor: AppStyle.kPrimaryColor,
      elevation: 0,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kTextTabBarHeight);
}
