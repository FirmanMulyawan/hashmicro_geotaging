part of main_lib;

class AddOutletScreen extends StatelessWidget {
  const AddOutletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainPagesController>(builder: (ctrl) {
      final nameOutlet = ctrl.addNameController.text.trim();
      final latitude = ctrl.latitude;
      final longitude = ctrl.longitude;
      final isLoading = ctrl.isLoading;

      final isValid =
          nameOutlet.isNotEmpty && latitude != 0.0 && longitude != 0.0;

      return GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: AppBottomSheet(
            title: '',
            actionStatus: ctrl.actionStatus,
            textButton: 'submit'.tr,
            onPressed: isValid ? ctrl.submitAddOutlet : null,
            child: SizedBox(
              width: Get.width,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'add_outlet'.tr,
                      style: AppStyle.semibold(
                        fontSize: 15,
                        color: AppStyle.kBlack,
                      ),
                    ),
                    const Gap(18),
                    Padding(
                        padding: const EdgeInsets.only(top: 18),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'outlet_name'.tr,
                              style: AppStyle.regular(
                                fontSize: 11,
                                color: AppStyle.kBlack,
                              ),
                            ),
                            const Gap(4),
                            AppForm(
                              controller: ctrl.addNameController,
                              hintText: 'outlet_name'.tr,
                              onChanged: ctrl.onChangeNameOutlet,
                            ),
                          ],
                        )),
                    const Gap(16),
                    SizedBox(
                      height: 360,
                      width: Get.width,
                      child: const GoogleMapsTracking(
                        showCircle: true,
                      ),
                    ),
                    const Gap(16),
                    ListTile(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        tileColor: const Color(0xffF2F6FE),
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 12),
                        title: Skeletonizer(
                          enabled: isLoading,
                          child: Text(
                            isLoading ? 'loading'.tr : ctrl.address,
                            style: AppStyle.regular(
                              fontSize: 16,
                              color: AppStyle.kBlack1,
                            ),
                          ),
                        ),
                        subtitle: Skeletonizer(
                          enabled: isLoading,
                          child: Text(
                            isLoading ? 'loading'.tr : ctrl.label,
                            style: AppStyle.regular(
                              fontSize: 14,
                              color: AppStyle.kBlack1,
                            ),
                          ),
                        )),
                  ]),
            )),
      );
    });
  }
}
