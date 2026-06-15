import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../infrastructure/theme/app_style.dart';

class LoadingPages extends StatelessWidget {
  const LoadingPages({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height,
      width: Get.width,
      color: Colors.white,
      child: Center(
          child: CircularProgressIndicator(
        color: AppStyle.kSecondaryColor,
      )),
    );
  }
}
