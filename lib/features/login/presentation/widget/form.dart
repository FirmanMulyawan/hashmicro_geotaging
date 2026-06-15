part of login_library;

class FormLoginSection extends StatelessWidget {
  const FormLoginSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
        child: Padding(
      padding: EdgeInsets.all(24.r),
      child: GetBuilder<LoginController>(builder: (controller) {
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 180),
                child: Text(
                  'login'.tr,
                  style: AppStyle.semibold(
                    fontSize: 28,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                controller.dateNow ?? '',
                style: AppStyle.regular(
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 22),
              const Gap(16),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 16),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8.r)),
                child: Column(
                  children: [
                    AppFormPrefix(
                      controller: controller.usernameController,
                      hintText: 'emilys',
                      errorMessages: controller.errorMessagesEmail,
                      onChanged: (value) =>
                          controller.listenUsernameForm(value),
                    ),
                    const Gap(16),
                    AppFormPrefix.password(
                      controller: controller.passwordController,
                      icon: AssetsSvg.lock,
                      hintText: 'emilyspass',
                      errorMessages: controller.errorMessagesPassword,
                      onChanged: (value) =>
                          controller.listenPasswordForm(value),
                    ),
                    const SizedBox(height: 12),
                    Obx(() {
                      return AppButton.primaryBig(
                        actionStatus: controller.actionStatus,
                        text: 'login'.tr,
                        onPressed: controller.isUsernameValidated.value &&
                                controller.isPasswordValidated.value
                            ? () => controller.login()
                            : null,
                      );
                    }),
                  ],
                ),
              )
            ],
          ),
        );
      }),
    ));
  }
}
