part of change_language_lib;

class ChangeLanguageScreen extends GetView<ChangeLanguageController> {
  const ChangeLanguageScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarDefault(
          onPressed: () => Get.back(result: true),
          title: 'change_language'.tr,
        ),
        body: ListView.separated(
            padding: EdgeInsets.all(16.hr),
            itemBuilder: (_, index) {
              final language = controller.languages[index];
              return Obx(() {
                final isSelected =
                    controller.selectedLanguage.value == language['code'];
                return ListTile(
                    onTap: () => controller.changeLanguage(language['code']!),
                    contentPadding: EdgeInsets.zero,
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(4),
                      child: CachedNetworkImage(
                        imageUrl: language['flag']!,
                        height: 20.hr,
                        width: 30.hr,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Container(
                          height: 20.hr,
                          width: 30.hr,
                          color: Colors.grey.shade200,
                        ),
                        errorWidget: (context, url, error) => Container(
                          height: 20.hr,
                          width: 30.hr,
                          color: Colors.grey.shade200,
                          child: const Icon(Icons.flag, size: 16),
                        ),
                      ),
                    ),
                    title: Text(
                      language['nativeName']!,
                      style: AppStyle.medium(
                        fontSize: 13.hr,
                        color: AppStyle.kBlack,
                      ),
                    ),
                    subtitle: Text(language['name']!,
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: Colors.grey.shade600,
                        )),
                    trailing: Transform.scale(
                        scale: .7,
                        child: Radio<bool>(
                            activeColor: AppStyle.kSecondaryColor,
                            fillColor: WidgetStateProperty.all(
                              isSelected
                                  ? AppStyle.kSecondaryColor
                                  : Colors.grey,
                            ),
                            focusColor: AppStyle.kSecondaryColor,
                            value: true,
                            groupValue: isSelected,
                            onChanged: (value) =>
                                controller.changeLanguage(language['code']!))));
              });
            },
            separatorBuilder: (_, i) => Padding(
                padding: EdgeInsets.symmetric(vertical: 8.h),
                child: Divider(
                  height: 0,
                  thickness: 1,
                  color: Colors.grey.shade300,
                )),
            itemCount: controller.languages.length));
  }
}
