import 'package:collectar_admin/homepage/homepage.dart';
import 'package:collectar_admin/item/item_page.dart';
import 'package:collectar_admin/mainscreen/mainscreen_controller.dart';
import 'package:collectar_admin/theme/appcolors.dart';
import 'package:collectar_admin/widgets/side_menu_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final mainscreen = Get.find<MainScreenController>();
    return Container(
      color: AppColors.background,
      width: 0.8.sw,
      height: 1.sh,
      child: Obx(() {
        return mainscreen.pageControl.isFalse
            ? mainscreen.onTap()
            : mainscreen.page;
      }),
    );
  }
}
