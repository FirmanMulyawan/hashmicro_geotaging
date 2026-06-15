part of splash_lib;

class SplashScreen extends GetView<SplashController> {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppStyle.kPrimaryColor,
        body: Stack(
          children: [
            Positioned(
                top: -70,
                left: -130,
                child: Image.asset(
                  AssetsImage.polygonTopLeft,
                  height: 360,
                  width: 360,
                  fit: BoxFit.fitHeight,
                )),
            Positioned(
                left: 0,
                right: 0,
                bottom: 120,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 8),
                    GetBuilder<SplashController>(
                      builder: (ctx) {
                        return Container(
                          width: 215,
                          decoration: BoxDecoration(
                            color: AppStyle.whiteColor,
                            borderRadius: BorderRadius.circular(11),
                          ),
                          child: Row(
                            children: [
                              AnimatedContainer(
                                duration:
                                    const Duration(milliseconds: 300),
                                width: 215 * controller.progress,
                                height: 22,
                                clipBehavior: Clip.hardEdge,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(11),
                                ),
                                child: Column(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color:
                                              AppStyle.progressBarTopBlue,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: AppStyle
                                              .progressBarBottomBlue,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const Spacer(),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                )),
            Positioned(
                bottom: -20,
                right: -90,
                child: Image.asset(
                  AssetsImage.polygonBottomReight,
                  height: 340,
                  width: 340,
                  fit: BoxFit.fitHeight,
                )),
          ],
        ));
  }
}
