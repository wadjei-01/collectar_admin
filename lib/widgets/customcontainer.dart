import 'package:collectar_admin/theme/fonts.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../theme/appcolors.dart';

Widget getContainer(
    {String? title,
    Widget? widget,
    Alignment alignment = Alignment.center,
    EdgeInsets? padding}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      title != null
          ? Text(
              " " + title,
              style: MediumHeaderStyle(
                  fontSize: 35.sp, color: AppColors.secondary),
            )
          : SizedBox(),
      SizedBox(
        height: 20.sp,
      ),
      Expanded(
        child: Container(
          padding: padding,
          alignment: alignment,
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.r),
            border: Border.all(
                color: AppColors.lighten(AppColors.secondary, 0.65),
                width: 3.sp),
            color: Colors.white.withOpacity(0.6),
          ),
          child: widget,
        ),
      ),
    ],
  );
}
