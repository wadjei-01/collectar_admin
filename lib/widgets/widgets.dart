import 'package:collectar_admin/item/item_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../theme/appcolors.dart';

export 'side_menu.dart';
export 'customtextfield.dart';
export 'customappbar.dart';
export 'productcard.dart';
export 'texteditor.dart';
export 'imageslistview.dart';
export 'categorydropdown.dart';

class Button extends StatelessWidget {
  Button(
      {super.key,
      this.onTap,
      this.widget,
      this.containerColor,
      this.textColor,
      this.width,
      this.height});
  dynamic onTap;
  Widget? widget;
  Color? containerColor;
  Color? textColor;
  double? width;
  double? height;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        height: height,
        width: width,
        decoration: BoxDecoration(
            color: containerColor ?? AppColors.primary,
            borderRadius: BorderRadius.circular(20.r)),
        child: Padding(
            padding: EdgeInsets.symmetric(vertical: 10.h), child: widget),
      ),
    );
  }
}
