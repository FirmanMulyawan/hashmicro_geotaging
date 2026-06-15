part of home_lib;

class HeaderHomeSection extends StatelessWidget {
  const HeaderHomeSection({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(builder: (context, constrain, isTablet) {
      return Container(
          color: AppStyle.kWhite,
          child: Column(
            children: [
              SizedBox(height: 24.hr),
              _profileDetail(),
            ],
          ));
    });
  }

  Widget _profileDetail() {
    return GetBuilder<HomeController>(builder: (ctrl) {
      final getUserData = ctrl.getUserData;

      return Card(
        color: AppStyle.kPrimaryColor2,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
        child: ListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 9.h),
          leading: CardImage.circle(
            size: 22.r,
            image: getUserData?.image,
          ),
          title: Text(
            "${getUserData?.firstName ?? '-'} ${getUserData?.lastName ?? '-'}",
            style: AppStyle.semibold(
              color: AppStyle.kWhite,
            ),
          ),
          subtitle: Text(
            getUserData?.email ?? '-',
            style: AppStyle.regular(
              fontSize: 10.hr,
              color: AppStyle.blue40,
            ),
          ),
        ),
      );
    });
  }
}
