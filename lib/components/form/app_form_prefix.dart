import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hashmicro/utils/extension/responsive_size.dart';

import '../../infrastructure/theme/app_style.dart';
import '../../utils/assets/assets_svg.dart';

class AppFormPrefix extends StatefulWidget {
  const AppFormPrefix({
    super.key,
    required this.controller,
    this.icon,
    this.isError = false,
    this.errorMessage,
    this.hintText,
    this.isPAssword = false,
    this.samePassword = false,
    this.onChanged,
    this.withErrorValidation = false,
    this.errorMessages,
  });

  const AppFormPrefix.password({
    super.key,
    required this.controller,
    this.icon,
    this.isError = false,
    this.errorMessage,
    this.hintText,
    this.isPAssword = true,
    this.samePassword = false,
    this.onChanged,
    this.withErrorValidation = false,
    this.errorMessages,
  });

  final TextEditingController controller;
  final String? icon;
  final bool isError;
  final String? errorMessage;
  final String? hintText;
  final bool isPAssword;
  final bool samePassword;
  final Function(String)? onChanged;
  final bool withErrorValidation;
  final List<String>? errorMessages;

  @override
  State<AppFormPrefix> createState() => _AppFormPrefixState();
}

class _AppFormPrefixState extends State<AppFormPrefix> {
  bool showPassword = true;
  setShowPassword() {
    setState(() {
      showPassword = !showPassword;
    });
  }

  @override
  void initState() {
    super.initState();
    showPassword = widget.isPAssword;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 40.hr,
          width: Get.width.w,
          child: TextFormField(
              obscureText: showPassword,
              controller: widget.controller,
              cursorColor: AppStyle.kPrimaryColor,
              style: AppStyle.normal(
                fontSize: 14.hr,
                color: AppStyle.kBlack,
              ),
              onChanged: widget.onChanged,
              decoration: InputDecoration(
                  hintText: widget.hintText,
                  hintStyle: AppStyle.regular(
                    fontSize: 11.hr,
                    color: const Color(0xffA0A3BD),
                  ),
                  border: border,
                  errorText: widget.isError ? widget.errorMessage : null,
                  errorStyle: AppStyle.regular(
                    fontSize: 12.hr,
                    color: AppStyle.kSecondaryColor,
                  ),
                  enabledBorder: (widget.errorMessages?.isNotEmpty ?? false)
                      ? errorBorder
                      : widget.samePassword
                          ? sucessBorder
                          : border,
                  focusedBorder: (widget.errorMessages?.isNotEmpty ?? false)
                      ? errorBorder
                      : widget.samePassword
                          ? sucessBorder
                          : border,
                  prefixIcon: SvgPicture.asset(
                    widget.icon ?? AssetsSvg.user,
                    height: 16.r,
                    width: 16.r,
                  ),
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.w),
                  prefixIconConstraints:
                      BoxConstraints(maxHeight: 24.hr, minWidth: 42.wr),
                  suffixIconConstraints:
                      BoxConstraints(maxHeight: 30.hr, minWidth: 42.wr),
                  suffixIcon: widget.samePassword
                      ? Icon(Icons.check_circle,
                          size: 20.r, color: AppStyle.kSuccessColor)
                      : widget.isPAssword
                          ? IconButton(
                              onPressed: () => setShowPassword(),
                              icon: Icon(
                                showPassword
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                size: 20.r,
                                color: Colors.grey.shade400,
                              ))
                          : null)),
        ),
        Visibility(
          visible: (widget.errorMessages?.isNotEmpty ?? false),
          child: Padding(
            padding: EdgeInsets.only(top: 8.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(
                  widget.errorMessages?.length ?? 0,
                  (index) => Padding(
                      padding: EdgeInsets.only(bottom: 4.h, left: 8.w),
                      child: Text(
                        widget.errorMessages?[index] ?? '',
                        style: AppStyle.regular(
                          fontSize: 9.hr,
                          color: AppStyle.kErrorColor,
                        ),
                      ))),
            ),
          ),
        )
      ],
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
        borderSide: BorderSide(color: AppStyle.kSecondaryColor, width: 1.1.w));
  }

  OutlineInputBorder get sucessBorder {
    return OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.r),
        borderSide: BorderSide(color: AppStyle.kSuccessColor, width: 1.1.w));
  }
}
