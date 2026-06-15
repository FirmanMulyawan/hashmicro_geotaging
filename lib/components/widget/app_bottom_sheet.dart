import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../infrastructure/theme/app_style.dart';
import '../../utils/network/action_status.dart';
import '../button/app_button.dart';

class AppBottomSheet extends StatelessWidget {
  const AppBottomSheet({
    super.key,
    required this.title,
    required this.textButton,
    required this.child,
    this.isFooter = true,
    this.gapBottom,
    this.actionStatus = ActionStatus.initalize,
    this.onPressed,
    this.colorButton,
    this.isButton = true,
    this.childFooter,
    this.paddingAppBottom,
  });
  const AppBottomSheet.witoutFooter(
      {super.key,
      required this.title,
      this.textButton = "",
      required this.child,
      this.isFooter = false,
      this.gapBottom,
      this.actionStatus = ActionStatus.initalize,
      this.onPressed,
      this.colorButton,
      this.isButton = true,
      this.childFooter,
      this.paddingAppBottom});

  final String title;
  final String textButton;
  final Widget child;
  final bool isFooter;
  final double? gapBottom;
  final ActionStatus actionStatus;
  final Function()? onPressed;
  final Color? colorButton;
  final bool isButton;
  final Widget? childFooter;
  final double? paddingAppBottom;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10.r), topRight: Radius.circular(10.r))),
      child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: Get.height * 0.9,
            minHeight: Get.height * 0.1,
          ),
          child: Material(
              color: Colors.transparent,
              child: Stack(
                children: [
                  SizedBox(
                      child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(height: 16.w),
                        Padding(
                          padding: EdgeInsets.all(paddingAppBottom ?? 16.r),
                          child: SizedBox(child: child),
                        ),
                        SizedBox(height: isFooter ? gapBottom ?? 100.w : 32.w),
                      ],
                    ),
                  )),
                  Positioned(
                      top: 0,
                      right: 0,
                      left: 0,
                      child: Column(children: [
                        Container(
                          width: Get.width,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10.r),
                                  topRight: Radius.circular(10.r))),
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 16.r, vertical: 12.r),
                            child: Center(
                              child: Container(
                                height: 6.h,
                                width: 100.w,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(18.r),
                                    color: const Color(0xffE8EFFA)),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 16.h),
                      ])),
                  if (isFooter && isButton)
                    Positioned(
                        left: 0,
                        right: 0,
                        bottom: 0,
                        child: SizedBox(
                            width: Get.width,
                            child: Container(
                              height: 72.h,
                              padding: EdgeInsets.all(16.r),
                              decoration: BoxDecoration(
                                  color:
                                      colorButton ?? AppStyle.kSecondaryColor2),
                              child: AppButton.primaryBig(
                                  actionStatus: actionStatus,
                                  text: textButton,
                                  onPressed: onPressed),
                            ))),
                  if (isFooter && !isButton) childFooter ?? const SizedBox()
                ],
              ))),
    );
  }
}
