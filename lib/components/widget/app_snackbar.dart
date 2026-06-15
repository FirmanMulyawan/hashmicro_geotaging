import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../infrastructure/theme/app_style.dart';
import '../../utils/assets/assets_svg.dart';

enum SnackType { success, error }

extension SnackTypeExtension on SnackType {
  String get asset {
    switch (this) {
      case SnackType.success:
        return AssetsSvg.checkCircleWhite;
      case SnackType.error:
        return AssetsSvg.xCircle;
    }
  }

  Color get color {
    switch (this) {
      case SnackType.success:
        return AppStyle.kSuccessColor;
      case SnackType.error:
        return AppStyle.kErrorColor;
    }
  }
}

class AppSnackbar {
  static void show(
      {String? message,
      SnackType type = SnackType.success,
      bool onTop = false}) {
    Get.showSnackbar(GetSnackBar(
      backgroundColor: type == SnackType.success
          ? AppStyle.kSuccessColor
          : AppStyle.kErrorColor,
      messageText: Text(message ?? '',
          style: AppStyle.regular(
            fontSize: 11,
            color: AppStyle.kWhite,
          )),
      duration: 2.seconds,
      animationDuration: const Duration(milliseconds: 250),
      icon: SvgPicture.asset(
        type.asset,
        width: 18.r,
        height: 18.r,
      ),
      margin: EdgeInsets.all(16.r),
      borderRadius: 8.r,
      snackPosition: onTop ? SnackPosition.TOP : SnackPosition.BOTTOM,
    ));
  }
}
