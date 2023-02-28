import 'package:collectar_admin/mainscreen/mainscreen_controller.dart';
import 'package:collectar_admin/newproduct/newproduct_controller.dart';
import 'package:collectar_admin/theme/appcolors.dart';
import 'package:collectar_admin/theme/fonts.dart';
import 'package:collectar_admin/widgets/side_menu_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

import '../item/item_controller.dart';

Container customAppBar({String? text}) {
  return Container(
      padding: EdgeInsets.only(left: 30.w),
      height: 150.h,
      width: double.infinity,
      color: Colors.white,
      child: Align(
        alignment: Alignment.centerLeft,
        widthFactor: 3,
        child: Row(
          children: [
            IconButton(
              icon: Icon(Icons.chevron_left_rounded),
              iconSize: 70.r,
              onPressed: backToProduct,
            ),
            text != null
                ? Text(
                    text,
                    style: MediumHeaderStyle(
                        color: AppColors.secondary, fontSize: 35.sp),
                  )
                : const SizedBox()
          ],
        ),
      ));
}

backToProduct() async {
  final main = Get.find<MainScreenController>();
  final side = Get.find<SideMenuController>();
  main.pageControl.value = false;
  side.OnTap(1);
  //TODO: Add condition for just item controller
  Get.delete<ItemController>();
  Get.delete<NewProductController>();
  await Get.put(ItemController());
  await Get.put(NewProductController());
}
