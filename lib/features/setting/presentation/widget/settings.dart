part of setting_lib;

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SettingController>(builder: (ctrl) {
      final isLoading = ctrl.isLoading;
      final userProfile = ctrl.userProfile;

      return Stack(children: [
        Positioned(
          right: 0,
          left: 0,
          top: 0,
          child: Container(
            height: Get.height / 5,
            color: AppStyle.kPrimaryColor,
          ),
        ),
        Container(
            padding: EdgeInsets.all(12.r),
            decoration: BoxDecoration(
                color: AppStyle.kWhite,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24.r),
                    topRight: Radius.circular(24.r))),
            child: Column(children: [
              Container(
                width: Get.width,
                height: 102.h,
                padding: EdgeInsets.all(12.r),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(22.r),
                    color: AppStyle.kSecondaryColor),
                child: Stack(children: [
                  Positioned(
                      right: 0,
                      bottom: 0,
                      child: Image.asset(AssetsImage.star1, height: 74)),
                  Positioned(
                      right: 66,
                      top: 0,
                      child: Image.asset(AssetsImage.star2, height: 54)),
                  Positioned.fill(
                      child: Row(children: [
                    Container(
                      height: 82.r,
                      width: 82.r,
                      decoration: BoxDecoration(
                          color: AppStyle.kWhite,
                          borderRadius: BorderRadius.circular(18.r)),
                      child: Center(
                          child: Transform.scale(
                              scale: 1.4,
                              child: SvgPicture.asset(AssetsSvg.king))),
                    ),
                    Gap(12.w),
                    Expanded(
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Skeletonizer(
                              enabled: isLoading,
                              child: Text(
                                isLoading
                                    ? 'loading'.tr
                                    : userProfile?.email ?? '',
                                style: AppStyle.light(
                                  fontSize: 13,
                                  color: AppStyle.kWhite,
                                ),
                              ),
                            ),
                            Skeletonizer(
                              enabled: isLoading,
                              child: Text(
                                isLoading
                                    ? 'loading'.tr
                                    : userProfile?.university ?? '',
                                style: AppStyle.light(
                                  fontSize: 13,
                                  color: AppStyle.kWhite,
                                ),
                              ),
                            ),
                            Skeletonizer(
                              enabled: isLoading,
                              child: Text(
                                isLoading
                                    ? 'loading'.tr
                                    : userProfile?.role ?? '',
                                style: AppStyle.light(
                                  fontSize: 13,
                                  color: AppStyle.kWhite,
                                ),
                              ),
                            ),
                          ]),
                    )
                  ]))
                ]),
              ),
              Gap(12.h),
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: ctrl.menuSetting.length,
                itemBuilder: (context, index) => ListTile(
                    onTap: () => ctrl.selectMenu(index),
                    leading: CircleAvatar(
                        radius: 18.r,
                        backgroundColor: const Color(0xffF2F6FE),
                        child: SvgPicture.asset(
                            "${ctrl.menuSetting[index]['icon']}",
                            height: 20.r)),
                    title: Text("${ctrl.menuSetting[index]['title']}",
                        style: AppStyle.semibold(
                          fontSize: 13,
                          color: AppStyle.kBlack,
                        )),
                    subtitle: Text(
                      "${ctrl.menuSetting[index]['subtitle']}",
                      style: AppStyle.regular(
                        fontSize: 13,
                        color: Colors.grey.shade500,
                      ),
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: Colors.grey.shade400,
                      size: 18.r,
                    )),
                separatorBuilder: (context, index) => Padding(
                    padding: EdgeInsets.only(left: 16.w),
                    child: Divider(height: 0, color: Colors.grey.shade200)),
              ),
              Gap(32.h),
            ]))
      ]);
    });
  }
}
