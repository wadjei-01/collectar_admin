import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:firebase_dart/firebase_dart.dart';

import '../database/boxes.dart';
import '../theme/appcolors.dart';
import '../theme/fonts.dart';
import '../widgets/widgets.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Button(
      widget: Text(
        'Return',
        style: MediumHeaderStyle(color: AppColors.secondary, fontSize: 35.sp),
      ),
      width: 0.3.sw,
      height: 100.h,
      onTap: () {},
    ));
  }
}
