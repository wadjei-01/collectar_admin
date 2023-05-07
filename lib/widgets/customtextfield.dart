import 'package:collectar_admin/theme/fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../theme/appcolors.dart';

TextFormField textField(TextEditingController textController,
    {String? hint,
    TextInputType? textInputType,
    TextStyle? style,
    int? maxLines,
    Widget? icon,
    Widget? suffix,
    TextAlign? textAlign,
    bool? enabled,
    String? errorText}) {
  return TextFormField(
    keyboardType: textInputType ?? TextInputType.name,
    style: style ?? RegularHeaderStyle(),
    textAlign: textAlign ?? TextAlign.start,
    controller: textController,
    enabled: enabled,
    cursorColor: AppColors.primary,
    maxLines: maxLines ?? 1,
    decoration: InputDecoration(
      label: icon,
      errorText: errorText,
      errorStyle: MediumHeaderStyle(color: Colors.red),
      suffix: suffix,
      fillColor: enabled == true || enabled == null
          ? Colors.white
          : AppColors.background,
      filled: true,
      disabledBorder: OutlineInputBorder(
          borderSide:
              const BorderSide(color: Color.fromARGB(255, 213, 213, 213))),
      enabledBorder: OutlineInputBorder(
          borderSide:
              const BorderSide(color: Color.fromARGB(255, 213, 213, 213)),
          borderRadius: BorderRadius.circular(20.r)),
      focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.primary, width: 2),
          borderRadius: BorderRadius.circular(20.r)),
      hintText: hint,
      contentPadding: EdgeInsets.all(40.w),
      border: InputBorder.none,
    ),
  );
}

TextFormField textNumField(TextEditingController textController,
    {String? hint,
    TextInputType? textInputType,
    int? maxLines,
    Widget? icon,
    Widget? suffix,
    TextAlign? textAlign,
    bool? enabled,
    String? errorText}) {
  return TextFormField(
    keyboardType: textInputType,
    textAlign: textAlign ?? TextAlign.start,
    style: MediumHeaderStyle(color: AppColors.secondary),
    controller: textController,
    enabled: enabled,
    cursorColor: AppColors.primary,
    maxLines: maxLines ?? 1,
    inputFormatters:
        textInputType == TextInputType.numberWithOptions(decimal: true)
            ? [FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}'))]
            : [
                FilteringTextInputFormatter.allow(
                    RegExp(r'^(0?[1-9]|[1-9][0-9])$')),
              ],
    decoration: InputDecoration(
      label: icon,
      errorText: errorText,
      errorStyle: MediumHeaderStyle(color: Colors.red),
      suffix: suffix,
      fillColor: enabled == true || enabled == null
          ? Colors.white
          : AppColors.background,
      filled: true,
      disabledBorder: OutlineInputBorder(
          borderSide:
              const BorderSide(color: Color.fromARGB(255, 213, 213, 213))),
      enabledBorder: OutlineInputBorder(
          borderSide:
              const BorderSide(color: Color.fromARGB(255, 213, 213, 213)),
          borderRadius: BorderRadius.circular(20.r)),
      focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.primary, width: 2),
          borderRadius: BorderRadius.circular(20.r)),
      hintText: hint,
      contentPadding: EdgeInsets.all(40.w),
      border: InputBorder.none,
    ),
  );
}
