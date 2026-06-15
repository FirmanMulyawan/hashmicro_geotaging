import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../components/widget/popup_button.dart';
import '../../infrastructure/theme/app_style.dart';

class AlertModel {
  static Future<bool?> showAlert(
      {required String title,
      required String message,
      required Color mainColor,
      required Color hoverColor,
      String? buttonText,
      bool? barrierDismissible,
      void Function()? onPressed}) async {
    final result = await Get.dialog<bool>(
      Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: SizedBox(
          width: double.maxFinite,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                clipBehavior: Clip.hardEdge,
                width: double.maxFinite,
                decoration: BoxDecoration(
                  color: mainColor,
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(8),
                    topLeft: Radius.circular(8),
                  ),
                ),
                padding: const EdgeInsets.symmetric(
                  vertical: 16,
                ),
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: AppStyle.bold(
                    fontSize: 16,
                    color: AppStyle.whiteColor,
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                child: Text(
                  message,
                  textAlign: TextAlign.center,
                  style: AppStyle.bold(
                    fontSize: 14,
                    color: AppStyle.textColor,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  bottom: 16,
                  left: 16,
                  right: 16,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: PopupButton(
                        onPressed: () {
                          Get.back(result: false);
                        },
                        size: 40,
                        color: AppStyle.mainRed,
                        shadowColor: AppStyle.hoverRed,
                        child: Text(
                          'no'.tr,
                          style: AppStyle.bold(
                            fontSize: 13,
                            color: AppStyle.whiteColor,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: PopupButton(
                        onPressed: onPressed,
                        size: 40,
                        color: mainColor,
                        shadowColor: hoverColor,
                        child: Text(
                          buttonText ?? 'Ok',
                          style: AppStyle.bold(
                            fontSize: 13,
                            color: AppStyle.whiteColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      barrierDismissible: barrierDismissible ?? true,
      // barrierColor: AppStyle.dialogBgColor,
    );
    return result;
  }

  static Future<bool?> showConfirmation({
    required String title,
    required String message,
    required Color mainColor,
    required Color hoverColor,
    String? confirmText,
    String? cancelText,
    bool? barrierDismissible,
  }) async {
    final result = await Get.dialog<bool>(
      Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        child: SizedBox(
          width: double.maxFinite,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                clipBehavior: Clip.hardEdge,
                width: double.maxFinite,
                decoration: BoxDecoration(
                  color: mainColor,
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(8),
                    topLeft: Radius.circular(8),
                  ),
                ),
                padding: const EdgeInsets.symmetric(
                  vertical: 16,
                ),
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: AppStyle.bold(
                    fontSize: 16,
                    color: AppStyle.whiteColor,
                  ),
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(
                    maxHeight: 200,
                  ),
                  child: Scrollbar(
                    thumbVisibility: true,
                    radius: const Radius.circular(8),
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Text(
                          message,
                          textAlign: TextAlign.center,
                          style: AppStyle.medium(
                            fontSize: 14,
                            color: AppStyle.textColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  bottom: 16,
                  left: 16,
                  right: 16,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: PopupButton(
                        onPressed: () {
                          Get.back(result: true);
                        },
                        size: 40,
                        color: mainColor,
                        shadowColor: hoverColor,
                        child: Text(
                          confirmText ?? 'Done',
                          textAlign: TextAlign.center,
                          style: AppStyle.bold(
                            fontSize: 13,
                            color: AppStyle.whiteColor,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      barrierDismissible: barrierDismissible ?? true,
      // barrierColor: AppStyle.dialogBgColor,
    );
    return result;
  }

  final String title;
  final String message;

  AlertModel({this.title = "", this.message = ""});
}
