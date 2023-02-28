import 'package:collectar_admin/theme/appcolors.dart';
import 'package:collectar_admin/widgets/sidexmenu_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:sidebarx/sidebarx.dart';

import '../theme/fonts.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SideMenuController());
    return SidebarX(
      controller: controller.sideMenuController,
      theme: SidebarXTheme(
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        hoverColor: AppColors.primary,
        textStyle: TextStyle(
            fontSize: 28.sp,
            fontFamily: 'Montserrat',
            color: AppColors.secondary),
        selectedTextStyle: TextStyle(
            fontSize: 28.sp,
            fontFamily: 'Montserrat-SemiBold',
            color: Colors.white),
        itemTextPadding: const EdgeInsets.only(left: 30),
        selectedItemTextPadding: const EdgeInsets.only(left: 30),
        iconTheme: IconThemeData(
          color: AppColors.secondary,
          size: 20,
        ),
        selectedIconTheme: const IconThemeData(
          color: Colors.white,
          size: 20,
        ),
        selectedItemDecoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: AppColors.primary),
      ),
      extendedTheme: SidebarXTheme(
        padding: EdgeInsets.all(40.r),
        width: 0.20.sw,
        decoration: BoxDecoration(
          color: Colors.white,
        ),
      ),
      headerBuilder: (context, extended) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: !controller.sideMenuController.extended
                  ? MainAxisAlignment.center
                  : MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 70.h,
                ),
                SvgPicture.asset(
                  'assets/images/collectAR (logo).svg',
                  height: 100.r,
                  width: 100.r,
                ),
                SizedBox(
                  width: 10.w,
                ),
                AnimatedSize(
                    duration: Duration(milliseconds: 700),
                    child: controller.sideMenuController.extended
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "collectAR",
                                style: BoldHeaderstextStyle(
                                    color: AppColors.secondary,
                                    fontSize: 30.sp),
                              ),
                              Text(
                                "Dashboard",
                                style: RegularHeaderStyle(
                                    color: AppColors.lighten(
                                        AppColors.secondary, 0.5),
                                    fontSize: 25.sp),
                              ),
                            ],
                          )
                        : SizedBox())
              ],
            ),
            SizedBox(
              height: 70.h,
            ),
            controller.sideMenuController.extended
                ? Text(
                    "MAIN MENU",
                    style: BoldHeaderstextStyle(
                        color: AppColors.title, fontSize: 30.sp),
                  )
                : SizedBox(),
            SizedBox(
              height: 15.h,
            )
          ],
        );
      },
      items: [
        for (int i = 0; i < controller.tabs.length; i++)
          SidebarXItem(
            icon: controller.icons[i],
            label: controller.tabs[i],
            onTap: () {
              print(controller.sideMenuController.selectedIndex);
              controller.mainScreenController.pageControl(false);
              controller.update();
            },
          ),
      ],
    );
  }
}
