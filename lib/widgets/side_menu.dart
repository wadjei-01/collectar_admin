import 'package:collectar_admin/item/item_controller.dart';
import 'package:collectar_admin/mainscreen/mainscreen_controller.dart';
import 'package:collectar_admin/theme/appcolors.dart';
import 'package:collectar_admin/theme/fonts.dart';
import 'package:collectar_admin/widgets/side_menu_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({super.key});

  @override
  Widget build(BuildContext context) {
    // final controller = Get.find<SideMenuController>();
    final mainscreencontroller = Get.find<MainScreenController>();

    return Container(
      height: 1.sh,
      width: 0.20.sw,
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 50.w),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SizedBox(
            height: 70.h,
          ),
          Row(
            children: [
              SvgPicture.asset(
                'assets/images/collectAR (logo).svg',
                height: 100.r,
                width: 100.r,
              ),
              SizedBox(
                width: 10.w,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "collectAR",
                    style: BoldHeaderstextStyle(
                        color: AppColors.secondary, fontSize: 30.sp),
                  ),
                  Text(
                    "Dashboard",
                    style: RegularHeaderStyle(
                        color: AppColors.lighten(AppColors.secondary, 0.5),
                        fontSize: 25.sp),
                  ),
                ],
              )
            ],
          ),
          SizedBox(
            height: 70.h,
          ),
          Text(
            "MAIN MENU",
            style:
                BoldHeaderstextStyle(color: AppColors.title, fontSize: 30.sp),
          ),
          SizedBox(
            height: 15.h,
          ),
          SizedBox(
            child: GetBuilder<SideMenuController>(builder: (controller) {
              return ListView.builder(
                  shrinkWrap: true,
                  itemCount: controller.tabs.length,
                  itemBuilder: ((context, index) => Padding(
                        padding: EdgeInsets.symmetric(vertical: 15.h),
                        child: InkWell(
                          onTap: () {
                            mainscreencontroller.pageControl.value = false;
                            controller.OnTap(index);
                            //TODO: Add condition for just item controller
                            if (index == 1) {
                              Get.delete<ItemController>();
                              Get.put(ItemController());
                            }
                          },
                          child: AnimatedContainer(
                            duration: Duration(milliseconds: 400),
                            decoration: BoxDecoration(
                                color: index == controller.selectedIndex.value
                                    ? AppColors.primary
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(10.r)),
                            child: ListTile(
                              minLeadingWidth: 0.5.w,
                              leading: Icon(
                                controller.icons[index],
                                color: index == controller.selectedIndex.value
                                    ? Colors.white
                                    : AppColors.secondary,
                              ),
                              title: Text(
                                controller.tabs[index],
                                style: TextStyle(
                                    fontSize: 28.sp,
                                    fontFamily:
                                        index == controller.selectedIndex.value
                                            ? 'Montserrat-SemiBold'
                                            : 'Montserrat',
                                    color:
                                        index == controller.selectedIndex.value
                                            ? Colors.white
                                            : AppColors.secondary),
                              ),
                            ),
                          ),
                        ),
                      )));
            }),
          ),
        ]),
      ),
    );
  }
}
