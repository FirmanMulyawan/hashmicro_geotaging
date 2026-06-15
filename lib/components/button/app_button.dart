import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hashmicro/utils/extension/responsive_size.dart';

import '../../infrastructure/theme/app_style.dart';
import '../../utils/assets/assets_svg.dart';
import '../../utils/network/action_status.dart';
import '../../utils/style/adaptive_size.dart';

enum AppButtonType {
  primary,
  primarySmall,
  primaryBig,
  primaryIcon,
  primaryBigIcon,
  secondary,
  secondarySmall,
  secondaryBig,
  secondaryIcon
}

enum AppButtonIconPosition { left, right }

class AppButton extends StatelessWidget {
  const AppButton._({
    Key? key,
    required this.onPressed,
    required this.buttonType,
    required this.iconPosition,
    required this.actionStatus,
    this.text,
    this.icon,
  }) : super(key: key);

  final Function()? onPressed;
  final AppButtonType buttonType;
  final AppButtonIconPosition iconPosition;
  final ActionStatus actionStatus;
  final String? text;
  final String? icon;

  factory AppButton.primary({
    Key? key,
    Function()? onPressed,
    ActionStatus actionStatus = ActionStatus.initalize,
    String? text,
  }) =>
      AppButton._(
        key: key,
        onPressed: onPressed,
        buttonType: AppButtonType.primary,
        iconPosition: AppButtonIconPosition.left,
        actionStatus: actionStatus,
        text: text,
      );

  factory AppButton.primaryBig({
    Key? key,
    Function()? onPressed,
    ActionStatus actionStatus = ActionStatus.initalize,
    String? text,
  }) =>
      AppButton._(
        key: key,
        onPressed: onPressed,
        buttonType: AppButtonType.primaryBig,
        iconPosition: AppButtonIconPosition.left,
        actionStatus: actionStatus,
        text: text,
      );
  factory AppButton.primaryBigIcon(
          {Key? key,
          Function()? onPressed,
          ActionStatus actionStatus = ActionStatus.initalize,
          String? text,
          String? icon}) =>
      AppButton._(
        key: key,
        onPressed: onPressed,
        buttonType: AppButtonType.primaryBigIcon,
        iconPosition: AppButtonIconPosition.left,
        actionStatus: actionStatus,
        text: text,
        icon: icon,
      );
  factory AppButton.primarySmall({
    Key? key,
    Function()? onPressed,
    ActionStatus actionStatus = ActionStatus.initalize,
    String? text,
  }) =>
      AppButton._(
        key: key,
        onPressed: onPressed,
        buttonType: AppButtonType.primarySmall,
        iconPosition: AppButtonIconPosition.left,
        actionStatus: actionStatus,
        text: text,
      );

  factory AppButton.primaryIcon({
    Key? key,
    Function()? onPressed,
    ActionStatus actionStatus = ActionStatus.initalize,
    String? text,
  }) =>
      AppButton._(
        key: key,
        onPressed: onPressed,
        buttonType: AppButtonType.primaryIcon,
        iconPosition: AppButtonIconPosition.left,
        actionStatus: actionStatus,
        text: text,
      );
  factory AppButton.secondary({
    Key? key,
    Function()? onPressed,
    ActionStatus actionStatus = ActionStatus.initalize,
    String? text,
  }) =>
      AppButton._(
        key: key,
        onPressed: onPressed,
        buttonType: AppButtonType.secondary,
        iconPosition: AppButtonIconPosition.left,
        actionStatus: actionStatus,
        text: text,
      );

  factory AppButton.secondarySmall({
    Key? key,
    Function()? onPressed,
    ActionStatus actionStatus = ActionStatus.initalize,
    String? text,
  }) =>
      AppButton._(
        key: key,
        onPressed: onPressed,
        buttonType: AppButtonType.secondarySmall,
        iconPosition: AppButtonIconPosition.left,
        actionStatus: actionStatus,
        text: text,
      );

  factory AppButton.secondaryBig({
    Key? key,
    Function()? onPressed,
    ActionStatus actionStatus = ActionStatus.initalize,
    String? text,
  }) =>
      AppButton._(
        key: key,
        onPressed: onPressed,
        buttonType: AppButtonType.secondaryBig,
        iconPosition: AppButtonIconPosition.left,
        actionStatus: actionStatus,
        text: text,
      );

  factory AppButton.secondaryIcon({
    Key? key,
    Function()? onPressed,
    ActionStatus actionStatus = ActionStatus.initalize,
    String? text,
  }) =>
      AppButton._(
        key: key,
        onPressed: onPressed,
        buttonType: AppButtonType.secondaryIcon,
        iconPosition: AppButtonIconPosition.left,
        actionStatus: actionStatus,
        text: text,
      );

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(2 / 800 * ScreenUtil().screenHeight),
      height: _getHeight(),
      child: ElevatedButton(
        style: _getButtonStyle(),
        onPressed: actionStatus == ActionStatus.loading ? null : onPressed,
        child: actionStatus == ActionStatus.loading
            ? _onLoading(isPrimaryButton)
            : _buildButtonContent(),
      ),
    );
  }

  bool get isPrimaryButton =>
      buttonType == AppButtonType.primary ||
      buttonType == AppButtonType.primaryBig ||
      buttonType == AppButtonType.primaryBigIcon ||
      buttonType == AppButtonType.primaryIcon ||
      buttonType == AppButtonType.primarySmall;

  double _getHeight() {
    switch (buttonType) {
      case AppButtonType.primary:
        return AdaptiveSize.get(40);
      case AppButtonType.primarySmall:
        return AdaptiveSize.get(40);
      case AppButtonType.primaryBig:
        return AdaptiveSize.get(48);
      case AppButtonType.primaryBigIcon:
        return AdaptiveSize.get(48);
      case AppButtonType.primaryIcon:
        return AdaptiveSize.get(40);
      case AppButtonType.secondary:
        return AdaptiveSize.get(40);
      case AppButtonType.secondarySmall:
        return AdaptiveSize.get(40);
      case AppButtonType.secondaryBig:
        return AdaptiveSize.get(48);
      case AppButtonType.secondaryIcon:
        return AdaptiveSize.get(40);
    }
  }

  ButtonStyle _getButtonStyle() {
    switch (buttonType) {
      case AppButtonType.primary ||
            AppButtonType.primaryBig ||
            AppButtonType.primaryBigIcon ||
            AppButtonType.primaryIcon ||
            AppButtonType.primarySmall:
        return ElevatedButton.styleFrom(
          backgroundColor: AppStyle.kSecondaryColor,
          elevation: 0,
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.r),
          ),
        );
      case AppButtonType.secondary ||
            AppButtonType.secondarySmall ||
            AppButtonType.secondaryBig ||
            AppButtonType.secondaryIcon:
        return ElevatedButton.styleFrom(
          backgroundColor: Colors.white,
          elevation: 0,
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.r),
              side: BorderSide(
                  color: onPressed != null
                      ? AppStyle.kSecondaryColor
                      : Colors.transparent)),
        );
    }
  }

  Widget _onLoading(bool isPrimary) {
    return Center(
      child: CircularProgressIndicator(
        color: isPrimary ? Colors.white : AppStyle.kSecondaryColor,
      ),
    );
  }

  Widget _buildButtonContent() {
    switch (buttonType) {
      case AppButtonType.primary:
        return _textPrimary(text ?? "Button");
      case AppButtonType.primarySmall:
        return _textPrimarySmall(text ?? "Button");
      case AppButtonType.primaryBig:
        return _textPrimary(text ?? "Button");
      case AppButtonType.primaryBigIcon:
        return _textIconPrimary(text ?? "Button");
      case AppButtonType.primaryIcon:
        return _textIconPrimary(text ?? "Button");
      case AppButtonType.secondary:
        return _textSecondary(text ?? "Button");
      case AppButtonType.secondarySmall:
        return _textSecondarySmall(text ?? "Button");
      case AppButtonType.secondaryBig:
        return _textSecondary(text ?? "Button");
      case AppButtonType.secondaryIcon:
        return _textIconSecondary(text ?? "Button");
    }
  }

  Widget _textPrimary(String text) {
    return Center(
        child: Text(
      text,
      style: AppStyle.semibold(
        fontSize: 13.hr,
        color: AppStyle.kWhite,
      ),
    ));
  }

  Widget _textPrimarySmall(String text) {
    return Center(
        child: Text(text,
            style: AppStyle.semibold(
              fontSize: 11.hr,
              color: AppStyle.kWhite,
            )));
  }

  Widget _textSecondary(String text) {
    return Center(
        child: Text(
      text,
      style: AppStyle.semibold(
        fontSize: 14.hr,
        color: AppStyle.kErrorColor,
      ),
    ));
  }

  Widget _textSecondarySmall(String text) {
    return Center(
        child: Text(
      text,
      style: AppStyle.semibold(
        fontSize: 11.hr,
        color:
            onPressed != null ? AppStyle.kSecondaryColor : AppStyle.kSoftBlack,
      ),
    ));
  }

  Widget _textIconPrimary(String text) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: iconPosition == AppButtonIconPosition.right
          ? [
              Text(
                text,
                style: AppStyle.semibold(
                  fontSize: 14.hr,
                  color: Colors.white,
                ),
              ),
              SizedBox(width: 8.w),
              SvgPicture.asset(
                icon ?? AssetsSvg.arrowRight,
                colorFilter: ColorFilter.mode(AppStyle.kWhite, BlendMode.srcIn),
                height: 12.r,
              ),
            ]
          : [
              SvgPicture.asset(
                icon ?? AssetsSvg.arrowRight,
                colorFilter: ColorFilter.mode(AppStyle.kWhite, BlendMode.srcIn),
                height: 12.r,
              ),
              SizedBox(width: 8.w),
              Text(
                text,
                style: AppStyle.semibold(
                  fontSize: 14.hr,
                  color: Colors.white,
                ),
              ),
            ],
    );
  }

  Widget _textIconSecondary(String text) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          text,
          style: AppStyle.semibold(
            fontSize: 14.hr,
            color: AppStyle.kErrorColor,
          ),
        ),
        SizedBox(width: 8.w),
        SvgPicture.asset(AssetsSvg.arrowRight),
      ],
    );
  }
}
