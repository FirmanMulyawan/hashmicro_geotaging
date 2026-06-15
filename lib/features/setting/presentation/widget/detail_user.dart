part of setting_lib;

class ShowDetailUser extends StatelessWidget {
  const ShowDetailUser({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBottomSheet.witoutFooter(title: "", child: _content);
  }

  Widget get _content {
    return GetBuilder<SettingController>(builder: (ctrl) {
      final isLoading = ctrl.isLoading;
      final userProfile = ctrl.userProfile;
      final address = ctrl.userProfile?.address;
      final company = ctrl.userProfile?.company;

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r),
              ),
              tileColor: const Color(0xffF2F6FE),
              contentPadding: EdgeInsets.symmetric(horizontal: 12.w),
              title: Skeletonizer(
                enabled: isLoading,
                child: Text(
                  isLoading
                      ? 'loading'.tr
                      : "${userProfile?.firstName ?? '-'} ${userProfile?.lastName ?? '-'}",
                  style: AppStyle.semibold(
                    fontSize: 16,
                    color: AppStyle.kBlack1,
                  ),
                ),
              ),
              subtitle: Skeletonizer(
                enabled: isLoading,
                child: Text(
                  isLoading ? 'loading'.tr : '${userProfile?.email}',
                  style: AppStyle.regular(
                    fontSize: 14,
                    color: AppStyle.kBlack1,
                  ),
                ),
              )),
          SizedBox(height: 12.h),
          _card(
            isLoading: isLoading,
            title: 'blood_group'.tr,
            value: userProfile?.bloodGroup ?? '-',
          ),
          SizedBox(height: 12.h),
          _card(
            isLoading: isLoading,
            title: 'birth_date'.tr,
            value: formatDateIndonesia(userProfile?.birthDate),
          ),
          SizedBox(height: 12.h),
          _card(
            isLoading: isLoading,
            title: 'address'.tr,
            value:
                "${address?.address ?? '-'} ${address?.city ?? '-'} ${address?.state ?? '-'} ${address?.country ?? '-'}",
          ),
          SizedBox(height: 12.h),
          _card(
            isLoading: isLoading,
            title: 'company'.tr,
            value: company?.name ?? '-',
          ),
        ],
      );
    });
  }

  Widget _card(
      {required bool isLoading, required String title, required String value}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Text(
            title,
            style: AppStyle.regular(
              fontSize: 14,
              color: AppStyle.kBlack1,
            ),
          ),
        ),
        Text(
          ": ",
          style: AppStyle.regular(
            fontSize: 14,
            color: AppStyle.kBlack1,
          ),
        ),
        Expanded(
          child: Skeletonizer(
            enabled: isLoading,
            child: Text(
              isLoading == true ? 'loading'.tr : value,
              style: AppStyle.regular(
                fontSize: 14,
                color: AppStyle.kBlack1,
              ),
            ),
          ),
        ),
      ],
    );
  }

  String formatDateIndonesia(String? dateString) {
    if (dateString == null || dateString.isEmpty) {
      return '-';
    }

    try {
      final date = DateFormat('yyyy-M-d').tryParse(dateString);
      return DateFormat('dd MMMM yyyy', 'id_ID').format(date ?? DateTime.now());
    } catch (e) {
      return '-';
    }
  }
}
