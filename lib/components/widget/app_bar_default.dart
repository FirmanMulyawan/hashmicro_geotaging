import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../infrastructure/theme/app_style.dart';
import '../../utils/assets/assets_svg.dart';

class AppBarDefault extends StatelessWidget implements PreferredSizeWidget {
  const AppBarDefault({
    super.key,
    required this.onPressed,
    required this.title,
  });

  final void Function()? onPressed;
  final String title;

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppStyle.kPrimaryColor,
      elevation: 0,
      leading: IconButton(
          onPressed: onPressed,
          icon: SvgPicture.asset(
            AssetsSvg.arrowLeft,
          )),
      title: Text(title,
          style: AppStyle.bold(
            fontSize: 18,
            color: Colors.white,
          )),
      centerTitle: true,
    );
  }
}
