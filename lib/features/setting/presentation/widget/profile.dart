part of setting_lib;

class ProfileCard extends StatelessWidget {
  const ProfileCard({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SettingController>(builder: (ctrl) {
      final isLoading = ctrl.isLoading;

      return Container(
          width: Get.width,
          height: Get.height / 3.8,
          color: AppStyle.kPrimaryColor,
          child: Stack(children: [
            Positioned(
              right: -62,
              top: -72,
              child: Transform.scale(
                  scale: 1.2, child: Image.asset(AssetsImage.polygonTopReight)),
            ),
            Center(
              child: Column(children: [
                const Gap(16),
                CardImage.circle(
                  size: 54,
                  image: ctrl.getUserData?.image,
                ),
                const Gap(16),
                Skeletonizer(
                  enabled: isLoading,
                  child: Text(
                    isLoading == true
                        ? 'loading'.tr
                        : "${ctrl.getUserData?.firstName ?? ''} ${ctrl.getUserData?.lastName ?? ''}",
                    style: AppStyle.semibold(
                      fontSize: 15,
                      color: AppStyle.kWhite,
                    ),
                  ),
                ),
                Skeletonizer(
                  enabled: isLoading,
                  child: Text(
                    isLoading == true
                        ? 'loading'.tr
                        : '${ctrl.userProfile?.phone}',
                    style: AppStyle.regular(
                      fontSize: 11,
                      color: AppStyle.kWhite.withOpacity(.7),
                    ),
                  ),
                )
              ]),
            )
          ]));
    });
  }
}
