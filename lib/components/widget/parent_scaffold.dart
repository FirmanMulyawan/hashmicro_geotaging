import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../infrastructure/theme/app_style.dart';
import '../../utils/network/screen_status.dart';

class ParentScaffold extends StatelessWidget {
  const ParentScaffold(
      {super.key,
      required this.onLoading,
      required this.onError,
      required this.onSuccess,
      required this.status,
      this.onTimeout});

  final ScreenStatus status;
  final Widget onLoading;
  final Widget onError;
  final Widget onSuccess;
  final Widget? onTimeout;

  @override
  Widget build(BuildContext context) {
    if (status == ScreenStatus.loading) {
      return onLoading;
    } else if (status == ScreenStatus.failed) {
      return onError;
    } else if (status == ScreenStatus.success) {
      return onSuccess;
    } else if (status == ScreenStatus.timeout) {
      return onTimeout ??
          Container(
            height: Get.height,
            width: Get.width,
            color: Colors.white,
            child: Center(
                child: Text(
              "Timeout",
              style: AppStyle.bold(
                fontSize: 18,
                color: Colors.black,
              ),
            )),
          );
    } else {
      return const SizedBox();
    }
  }
}
