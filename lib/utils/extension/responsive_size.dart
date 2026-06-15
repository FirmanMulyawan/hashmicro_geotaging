import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

extension AdaptiveSizeExtension on num {
  double get hr {
    return (this / 800) * ScreenUtil().screenHeight;
  }

  double get wr {
    return (this / 360) * ScreenUtil().screenWidth;
  }
}

extension ResponsiveSize on num {
  /// Mengembalikan ukuran tinggi widget yang disesuaikan dengan ukuran layar perangkat
  double get height => MediaQuery.of(Get.context!).size.height * this;

  /// Mengembalikan ukuran lebar widget yang disesuaikan dengan ukuran layar perangkat
  double get width => MediaQuery.of(Get.context!).size.width * this;

  /// Mengembalikan ukuran radius widget yang disesuaikan dengan ukuran layar perangkat
  double get rounded => MediaQuery.of(Get.context!).size.width * this / 30;

  /// Mengembalikan ukuran font widget yang disesuaikan dengan ukuran layar perangkat
  double get fontSize => MediaQuery.of(Get.context!).size.width * this / 100;
}

class LayoutPlatform {
  static bool isMobile(BuildContext context) {
    return MediaQuery.of(context).size.width <= 360;
  }
}
