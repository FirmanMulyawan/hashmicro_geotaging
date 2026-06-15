import 'package:flutter_screenutil/flutter_screenutil.dart';

class AdaptiveSize {
  const AdaptiveSize();

  static get(dynamic value) {
    return (value / 800) * ScreenUtil().screenHeight;
  }
}
