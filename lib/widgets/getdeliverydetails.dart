import 'package:collectar_admin/widgets/customappbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ionicons/ionicons.dart';
import '../orders/orders_model.dart';
import '../theme/appcolors.dart';
import '../theme/fonts.dart';

Column getDeliveryDetails(Orders order) {
  return Column(
    children: [
      Container(
          margin: EdgeInsets.all(20.r),
          clipBehavior: Clip.hardEdge,
          width: 450.w,
          height: 250.h,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(25.r)),
          child: SvgPicture.asset(
            'assets/images/map.svg',
            fit: BoxFit.fitWidth,
          )),
      SizedBox(
        height: 20.h,
      ),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Row(
          children: [
            Icon(
              Ionicons.location,
              color: AppColors.primary,
              size: 50.r,
            ),
            SizedBox(
              width: 10.w,
            ),
            Container(
              width: 300.w,
              alignment: Alignment.centerLeft,
              child: Text(
                order.userLocation,
                style: MediumHeaderStyle(
                    color: AppColors.secondary, fontSize: 30.sp),
              ),
            ),
          ],
        ),
      ),
      SizedBox(
        height: 20.h,
      ),
      Padding(
        padding: EdgeInsets.symmetric(horizontal: 25.w),
        child: Row(
          children: [
            Icon(
              Ionicons.cash,
              color: AppColors.primary,
              size: 40.r,
            ),
            SizedBox(
              width: 10.w,
            ),
            Container(
              width: 300.w,
              alignment: Alignment.centerLeft,
              child: Text(
                'Cash',
                style: MediumHeaderStyle(
                    color: AppColors.secondary, fontSize: 30.sp),
              ),
            ),
          ],
        ),
      ),
    ],
  );
}
