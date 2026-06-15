import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomBottomSheet {
  static void show(
      {required Widget child,
      Function()? onCompleted,
      Duration? enterBottomSheetDuration,
      Duration? exitBottomSheetDuration}) {
    Get.bottomSheet(child,
            enterBottomSheetDuration:
                enterBottomSheetDuration ?? 250.milliseconds,
            exitBottomSheetDuration:
                exitBottomSheetDuration ?? 250.milliseconds,
            isScrollControlled: true)
        .whenComplete(() {
      onCompleted?.call();
    });
  }
}
