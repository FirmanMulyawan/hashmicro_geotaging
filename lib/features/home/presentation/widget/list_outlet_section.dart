part of home_lib;

class ListOutletSection extends GetView<HomeController> {
  const ListOutletSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        final localOutlet = controller.localOutlet;

        if (localOutlet.isEmpty) {
          return _isEmpty();
        }

        return Column(
          children: localOutlet.asMap().entries.map((entry) {
            final orderIndex = entry.key;
            final outletEntry = entry.value;
            final clockIn = outletEntry.clockIn;
            final clockOut = outletEntry.clockOut;

            final isFirst = orderIndex == 0;
            return Padding(
              padding: EdgeInsets.only(
                top: isFirst ? 12.h : 8.h,
                bottom: 8.h,
              ),
              child: _cardOutlet(
                  address: "${outletEntry.address}",
                  nameOutlet: outletEntry.nameOutlet ?? '-',
                  imageUrl: outletEntry.imageUrl ?? '',
                  clockIn:
                      clockIn != null ? clockIn.extractLocalTime : '-- : --',
                  clockOut:
                      clockOut != null ? clockOut.extractLocalTime : '-- : --',
                  onPressed: clockIn != null && clockOut != null
                      ? null
                      : () async {
                          final isSuccess = await controller.attendance(
                              outletEntry: outletEntry);

                          if (isSuccess == true) {
                            controller.refreshData();
                          }
                        }),
            );
          }).toList(),
        );
      },
    );
  }

  Widget _cardOutlet(
      {required String nameOutlet,
      required String address,
      void Function()? onPressed,
      required String clockIn,
      required String clockOut,
      required String imageUrl}) {
    return Card(
      elevation: 2,
      shadowColor: Colors.black12,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Padding(
        padding: EdgeInsets.all(16.r),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  width: 52.r,
                  height: 52.r,
                  decoration: BoxDecoration(
                    color: AppStyle.kPrimaryColor.withOpacity(.1),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: buildOutletImage(imageUrl),
                ),
                Gap(12.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        nameOutlet,
                        style: AppStyle.semibold(
                          fontSize: 15,
                          color: AppStyle.kBlack,
                        ),
                      ),
                      Gap(4.h),
                      Text(
                        address,
                        style: AppStyle.regular(
                          fontSize: 12,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Gap(12.w),
            SizedBox(
              width: double.infinity,
              child: PopupButton(
                onPressed: onPressed,
                size: 40,
                color: AppStyle.progressBarTopBlue,
                shadowColor: AppStyle.progressBarBottomBlue,
                child: Text(
                  'attendance'.tr,
                  style: AppStyle.bold(
                    fontSize: 13,
                    color: AppStyle.whiteColor,
                  ),
                ),
              ),
            ),
            Gap(12.w),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Text(
                      "Clock In",
                      style: AppStyle.regular(
                        fontSize: 12,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    Text(
                      clockIn,
                      style: AppStyle.regular(
                        fontSize: 12,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      "Clock out",
                      style: AppStyle.regular(
                        fontSize: 12,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    Text(
                      clockOut,
                      style: AppStyle.regular(
                        fontSize: 12,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget buildOutletImage(String? imageUrl) {
    if (imageUrl == null || imageUrl.isEmpty) {
      return Icon(
        Icons.store_rounded,
        color: AppStyle.kPrimaryColor,
        size: 28.r,
      );
    }

    return Image.file(
      File(imageUrl),
      fit: BoxFit.cover,
      errorBuilder: (_, __, ___) => Icon(
        Icons.store_rounded,
        color: AppStyle.kPrimaryColor,
        size: 28.r,
      ),
    );
  }

  Widget _isEmpty() {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: 24.w,
        vertical: 48.h,
      ),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.store_mall_directory_outlined,
              size: 80.r,
              color: Colors.grey.shade400,
            ),
            Gap(16.h),
            Text(
              'Belum Ada Outlet',
              style: AppStyle.semibold(
                fontSize: 18,
                color: AppStyle.kBlack,
              ),
            ),
            Gap(8.h),
            Text(
              'Tambahkan outlet terlebih dahulu untuk melakukan absensi.',
              textAlign: TextAlign.center,
              style: AppStyle.regular(
                fontSize: 13,
                color: Colors.grey.shade600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
