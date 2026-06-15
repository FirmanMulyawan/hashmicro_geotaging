import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';

import '../../infrastructure/theme/app_style.dart';

class AppForm extends StatelessWidget {
  const AppForm({
    super.key,
    required this.controller,
    this.focusNode,
    this.stringIcon,
    this.isError = false,
    this.isReadOnly = false,
    this.enabled = true,
    this.hintText,
    this.textAlign,
    this.keyboardType,
    this.onChanged,
    this.onEditingComplete,
    this.prefixIcon,
    this.validator,
    this.inputFormatters,
    this.maxLines,
    this.textStyle,
  });

  final TextEditingController controller;
  final FocusNode? focusNode;
  final String? stringIcon;
  final bool isError;
  final bool isReadOnly;
  final String? hintText;
  final TextAlign? textAlign;
  final TextInputType? keyboardType;
  final Function(String)? onChanged;
  final Function()? onEditingComplete;
  final Function(String?)? validator;
  final bool enabled;
  final IconData? prefixIcon;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLines;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: (maxLines ?? 1) > 1 ? null : 50.h,
      width: Get.width,
      child: TextFormField(
          controller: controller,
          inputFormatters: inputFormatters,
          cursorColor: AppStyle.kPrimaryColor,
          focusNode: focusNode,
          style: textStyle ??
              AppStyle.semibold(
                fontSize: 16,
              ),
          maxLines: maxLines ?? 1,
          textAlign: textAlign ?? TextAlign.left,
          keyboardType: keyboardType,
          readOnly: isReadOnly,
          onChanged: onChanged,
          enabled: enabled,
          validator: (value) => validator?.call(value),
          onEditingComplete: onEditingComplete,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: AppStyle.normal(
              color: AppStyle.kPrimaryColor2,
            ),
            prefix: (stringIcon != null)
                ? Container(
                    margin: const EdgeInsets.only(right: 8),
                    decoration: BoxDecoration(
                      border: Border(
                        right: BorderSide(
                          color: Colors.grey.shade300,
                          width: 1.0,
                        ),
                      ),
                    ),
                    padding: const EdgeInsets.fromLTRB(0, 1, 8, 1),
                    child: SvgPicture.asset(
                      stringIcon!,
                      height: 12.r,
                      width: 12.r,
                    ),
                  )
                : null,
            fillColor: enabled ? Colors.white : Colors.grey.shade200,
            filled: true,
            border: border,
            enabledBorder: isError ? errorBorder : border,
            focusedBorder: isError ? errorBorder : border,
            contentPadding:
                EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.w),
          )),
    );
  }

  OutlineInputBorder get border {
    return OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.r),
        borderSide: BorderSide(color: Colors.grey.shade300));
  }

  OutlineInputBorder get errorBorder {
    return OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.r),
        borderSide: BorderSide(color: AppStyle.kSecondaryColor, width: 1.1));
  }
}
