import 'package:flutter/material.dart';

class AppStyle {
  static Color hintColor = const Color(0xffD7E3DF);
  static Color textColor = const Color(0xff424242);
  static Color buttonDisabledColor = const Color(0xffCCDBD6);
  static Color buttonDisabledShadowColor = const Color(0xff99A3A0);
  static Color green = const Color(0xff418E83);
  static Color pressedGreen = const Color(0xff40807E);
  static Color mainBlue = const Color(0xff25C7E8);
  static Color hoverBlue = const Color(0xff17AEC4);
  static Color borderYellow = const Color(0xffFED380);
  static Color mainRed = const Color(0xffFF5252);
  static Color hoverRed = const Color(0xffE31A37);
  static Color whiteColor = Colors.white;

  static Color searchBorderColor = const Color(0xffD9E5E5);
  static Color searchHintColor = const Color(0xffE0E0E0);
  static Color kBlack = const Color(0xFF2E3237);
  static Color kBlack1 = const Color(0xFF353535);
  static Color kSoftGrey = const Color(0xFFC5C5C5);
  static Color kWhite = const Color(0xFFFFFFFF);
  static Color kPrimaryColor = const Color(0xff0a46a0);
  static Color kPrimaryColor1 = const Color(0xff091629);
  static Color kPrimaryColor2 = const Color(0xff0E203D);
  static Color kSecondaryColor = const Color(0xffED4C4D);
  static Color kErrorColor = const Color(0xffED4C4D);
  static Color kSuccessColor = const Color(0xff27AE60);
  static Color neutral80 = const Color(0xff808080);
  static Color dialogBgColor = const Color(0xff014F34);

  static Color progressBarTopBlue = const Color(0xFF5EA8FF);
  static Color progressBarBottomBlue = const Color(0xFF2D7DF5);

  static Color neutral30 = const Color(0xFFBABABA);
  static Color kSecondaryColor2 = const Color(0xffFFF5F5);
  static Color kSoftBlack = const Color(0xFF7B7B7B);
  static Color blue40 = const Color(0xFFA9B7CE);

  static TextStyle light({
    Color? color,
    double fontSize = 14,
    fontStyle = FontStyle.normal,
  }) {
    return TextStyle(
      fontSize: fontSize,
      color: color ?? kBlack1,
      letterSpacing: 0,
      fontFamily: 'BloggerSans',
      fontWeight: FontWeight.w300,
      fontStyle: fontStyle,
    );
  }

  static TextStyle regular({
    Color? color,
    double fontSize = 14,
    fontStyle = FontStyle.normal,
    double? height,
  }) {
    return TextStyle(
      fontSize: fontSize,
      color: color ?? kBlack1,
      letterSpacing: 0,
      height: height,
      fontFamily: 'BloggerSans',
      fontWeight: FontWeight.w400,
      fontStyle: fontStyle,
    );
  }

  static TextStyle normal({
    Color? color,
    double fontSize = 14,
    fontStyle = FontStyle.normal,
    double? height,
  }) {
    return TextStyle(
      fontSize: fontSize,
      color: color ?? kBlack1,
      letterSpacing: 0,
      height: height,
      fontFamily: 'BloggerSans',
      fontWeight: FontWeight.normal,
      fontStyle: fontStyle,
    );
  }

  static TextStyle medium({
    Color? color,
    double fontSize = 14,
    double? height,
    fontStyle = FontStyle.normal,
  }) {
    return TextStyle(
      fontSize: fontSize,
      color: color ?? kBlack1,
      letterSpacing: 0,
      height: height ?? 1.2,
      fontFamily: 'BloggerSans',
      fontWeight: FontWeight.w500,
      fontStyle: fontStyle,
    );
  }

  static TextStyle semibold({
    Color? color,
    double fontSize = 14,
    fontStyle = FontStyle.normal,
  }) {
    return TextStyle(
      fontSize: fontSize,
      color: color ?? kBlack1,
      letterSpacing: 0,
      fontFamily: 'BloggerSans',
      fontWeight: FontWeight.w600,
      fontStyle: fontStyle,
    );
  }

  static TextStyle bold({
    Color? color,
    double fontSize = 14,
    FontStyle fontStyle = FontStyle.normal,
  }) {
    return TextStyle(
      fontSize: fontSize,
      color: color ?? kBlack1,
      letterSpacing: 0,
      fontFamily: 'BloggerSans',
      fontWeight: FontWeight.w700,
      fontStyle: fontStyle,
    );
  }

  static TextStyle boldv2({
    Color? color,
    double fontSize = 14,
    FontStyle fontStyle = FontStyle.normal,
  }) {
    return TextStyle(
      fontSize: fontSize,
      color: color ?? kBlack1,
      letterSpacing: 0,
      fontFamily: 'BloggerSans',
      fontWeight: FontWeight.bold,
      fontStyle: fontStyle,
    );
  }
}
