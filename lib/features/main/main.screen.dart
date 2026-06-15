part of main_lib;

class MainScreen extends GetView<MainPagesController> {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainPagesController>(builder: (controller) {
      return PopScope(
        canPop: false,
        onPopInvoked: (didPop) async {
          if (didPop) return;

          // Only show exit dialog when on home screen (index 0)
          if (controller.selectedIndex == 0) {
            final shouldExit = await controller.showExitDialog();
            if (shouldExit) {
              // Exit the app
              SystemNavigator.pop();
            }
          } else {
            // If not on home screen, go back to home
            controller.changeTabIndex(0);
          }
        },
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: AppStyle.kWhite,
          body: IndexedStack(
            index: controller.selectedIndex,
            children: controller.listPages,
          ),
          bottomNavigationBar: BottomNavigationBar(
              currentIndex: controller.selectedIndex,
              onTap: controller.changeTabIndex,
              backgroundColor: AppStyle.kWhite,
              selectedLabelStyle: AppStyle.regular(
                fontSize: 12,
                color: AppStyle.kSecondaryColor,
              ),
              unselectedLabelStyle: AppStyle.regular(
                fontSize: 12,
                color: AppStyle.neutral30,
              ),
              selectedItemColor: AppStyle.kSecondaryColor,
              unselectedItemColor: AppStyle.kSoftGrey,
              type: BottomNavigationBarType.fixed,
              items: [
                _itemButtom(icon: AssetsSvg.home, label: 'home'.tr, index: 0),
                _itemButtom(icon: AssetsSvg.other, label: "", index: 1),
                _itemButtom(
                    icon: AssetsSvg.setting, label: 'setting'.tr, index: 2),
              ]),
          floatingActionButton: _floatingButton(index: 1),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
        ),
      );
    });
  }

  BottomNavigationBarItem _itemButtom(
      {required String icon, String? label, required int index}) {
    return BottomNavigationBarItem(
        icon: index == 1
            ? const Icon(Icons.home, color: Colors.transparent)
            : SvgPicture.asset(
                icon,
                colorFilter: ColorFilter.mode(
                    controller.selectedIndex == index
                        ? AppStyle.kSecondaryColor
                        : AppStyle.kSoftGrey,
                    BlendMode.srcIn),
              ),
        label: label);
  }

  Widget _floatingButton({required int index}) {
    return FloatingActionButton(
      backgroundColor: AppStyle.kSecondaryColor,
      onPressed: () => controller.changeTabIndex(index),
      child: const Icon(
        Icons.add,
        color: Colors.white,
      ),
    );
  }
}
