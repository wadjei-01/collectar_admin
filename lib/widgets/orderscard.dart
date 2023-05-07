import 'package:cached_network_image/cached_network_image.dart';
import 'package:collectar_admin/theme/fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:ionicons/ionicons.dart';
import 'package:timeago/timeago.dart' as timeago;

import '../orders/orders_model.dart';
import '../theme/appcolors.dart';

class OrdersCard extends StatelessWidget {
  OrdersCard({super.key, required this.orders, this.onTap});

  final Orders orders;

  dynamic onTap;

  @override
  Widget build(BuildContext context) {
    var str = orders.orderID.split("-");
    String id = str[1] + str[3];
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 20.h),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(30.r)),
          child: Padding(
            padding: EdgeInsets.all(40.r),
            child: IntrinsicHeight(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text(
                            '${orders.name}   |   ',
                            style: MediumHeaderStyle(
                                fontSize: 40.sp, color: AppColors.secondary),
                          ),
                          Text(
                            '#${id}',
                            style: MediumHeaderStyle(
                                fontSize: 30.sp, color: AppColors.title),
                          ),
                        ],
                      ),
                      AnimatedContainer(
                        duration: Duration(milliseconds: 500),
                        height: 55.h,
                        decoration: BoxDecoration(
                            color: AppColors.lighten(
                                showColorUpdate(orders.status.name), 0.4),
                            borderRadius: BorderRadius.circular(15.r)),
                        child: IntrinsicWidth(
                          child: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 25.r),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(
                                  Ionicons.ellipse_sharp,
                                  size: 20.r,
                                  color: showColorUpdate(orders.status.name),
                                ),
                                SizedBox(
                                  width: 20.w,
                                ),
                                Text(
                                  showTitleUpdate(orders.status.name),
                                  style: MediumHeaderStyle(
                                      fontSize: 30.sp,
                                      color: AppColors.secondary),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  Row(
                    children: [
                      Icon(
                        Ionicons.location,
                        color: AppColors.title,
                        size: 50.r,
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      Text(
                        orders.userLocation,
                        style: MediumHeaderStyle(
                            color: AppColors.title, fontSize: 35.sp),
                      )
                    ],
                  ),
                  Divider(
                    color: AppColors.title,
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  SizedBox(
                    height: 85.r,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AnimationLimiter(
                          child: ListView.builder(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemCount: orders.items.length,
                            itemBuilder: (context, value) =>
                                AnimationConfiguration.staggeredList(
                              position: value,
                              duration: Duration(milliseconds: 500),
                              child: SlideAnimation(
                                horizontalOffset: 50.0,
                                child: FadeInAnimation(
                                  child: value <= 10
                                      ? Align(
                                          widthFactor: 0.8,
                                          child: Container(
                                            clipBehavior: Clip.hardEdge,
                                            height: 85.r,
                                            width: 85.r,
                                            decoration: BoxDecoration(
                                                color: Color(
                                                    orders.items[value].color),
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        45.r)),
                                            child: CachedNetworkImage(
                                              imageUrl:
                                                  orders.items[value].image,
                                              fit: BoxFit.fitWidth,
                                              width: 70.r,
                                            ),
                                          ),
                                        )
                                      : SizedBox(),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: 70.h,
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(horizontal: 30.w),
                          decoration: BoxDecoration(
                              color: AppColors.background,
                              borderRadius: BorderRadius.circular(15.r)),
                          child: IntrinsicWidth(
                            child: Text(
                              timeago.format(orders.date),
                              style:
                                  MediumHeaderStyle(color: AppColors.secondary),
                            ),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  String showTitleUpdate(String name) {
    if (name.contains('pending')) {
      return 'Pending';
    } else if (name.contains('accepted')) {
      return 'Accepted';
    } else if (name.contains('onRoute')) {
      return 'On Route!';
    } else if (name.contains('delivered')) {
      return 'Delivered';
    } else {
      return 'Declined';
    }
  }

  Color showColorUpdate(String name) {
    if (name.contains('pending')) {
      return Colors.orange;
    } else if (name.contains('accepted')) {
      return Color.fromARGB(255, 183, 255, 17);
    } else if (name.contains('onRoute')) {
      return Color.fromARGB(255, 183, 255, 17);
    } else if (name.contains('delivered')) {
      return Colors.green;
    } else {
      return Colors.red;
    }
  }

  String showSubtitleUpdate(String name) {
    if (name.contains('pending')) {
      return 'Your order is being processed';
    } else if (name.contains('accepted')) {
      return 'Your order has been accepted...';
    } else if (name.contains('onRoute')) {
      return 'Your order would be coming soon!!';
    } else if (name.contains('delivered')) {
      return 'Your order has been deliver';
    } else {
      return 'Sorry about that';
    }
  }

  Color? showUpdate(List<Status> stats, String name, int index) {
    if (name == "declined") {
      return Colors.red;
    } else if (stats.indexOf(Status.fromJson(name)) >= index) {
      return AppColors.primary;
    } else {
      return AppColors.title;
    }
  }
}
