part of home_lib;

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return AppLoading(
        isLoading: controller.isLoading.value,
        child: ParentScaffold(
            onLoading: const LoadingPages(),
            onError: const SizedBox(),
            onSuccess: sucessData(),
            status: controller.screenStatus.value),
      );
    });
  }

  Widget sucessData() {
    return Scaffold(
        backgroundColor: AppStyle.kPrimaryColor1,
        body: SafeArea(
            child: Container(
          color: AppStyle.kWhite,
          child: RefreshIndicator(
              onRefresh: controller.refreshData,
              child: ListView(children: const [
                HeaderHomeSection(),
                ListOutletSection(),
              ])),
        )));
  }
}
