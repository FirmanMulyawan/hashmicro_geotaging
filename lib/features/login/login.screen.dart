part of login_library;

class LoginScreen extends GetView<LoginController> {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppStyle.kPrimaryColor,
      resizeToAvoidBottomInset: false,
      body: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: SizedBox(
          height: Get.height,
          width: Get.width,
          child: Stack(
            children: [
              SizedBox(
                width: Get.width,
                height: Get.height * 0.6,
                child: CustomPaint(
                  painter: CembungPainter(isPrimary: true),
                ),
              ),
              const FormLoginSection(),
              const Polygon(),
              Positioned(
                bottom: 29,
                left: 0,
                right: 0,
                child: Column(
                  children: [
                    Gap(12.h),
                    GetBuilder<LoginController>(builder: (controller) {
                      return Text(
                        controller.versionApp ?? '',
                        style: AppStyle.regular(
                          fontSize: 9,
                          color: AppStyle.kWhite,
                        ),
                      );
                    }),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
