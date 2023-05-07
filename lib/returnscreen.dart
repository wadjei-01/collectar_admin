import 'package:collectar_admin/database/boxes.dart';
import 'package:collectar_admin/theme/appcolors.dart';
import 'package:collectar_admin/theme/fonts.dart';
import 'package:collectar_admin/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:firebase_dart/firebase_dart.dart';

class ReturnScreen extends StatelessWidget {
  const ReturnScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(children: [
          SvgPicture.asset(
            'assets/images/returnerror.svg',
            height: 680.h,
          ),
          SizedBox(
            height: 50.h,
          ),
          Text(
            'Whoops! Not an Admin.',
            style: BoldHeaderstextStyle(
                color: AppColors.secondary, fontSize: 55.sp),
          ),
          SizedBox(
            height: 20.h,
          ),
          Text(
            'This account does not have Admin privileges',
            style: RegularHeaderStyle(
                color: AppColors.lighten(AppColors.secondary, 0.3),
                fontSize: 30.sp),
          ),
          SizedBox(
            height: 20.h,
          ),
          Button(
            widget: Text(
              'Return',
              style: MediumHeaderStyle(
                  color: AppColors.secondary, fontSize: 35.sp),
            ),
            width: 0.3.sw,
            height: 100.h,
            onTap: () {
              FirebaseAuth.instance.signOut();
              Boxes.getUser().clear();
            },
          )
        ]),
      ),
    );
  }
}
