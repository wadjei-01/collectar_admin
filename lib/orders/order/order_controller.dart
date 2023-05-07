import 'dart:developer';

import 'package:collectar_admin/firebase/firestore_db.dart';
import 'package:collectar_admin/login/user_model.dart';
import 'package:collectar_admin/theme/appcolors.dart';
import 'package:collectar_admin/theme/fonts.dart';
import 'package:firedart/firedart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:timelines/timelines.dart';

import '../../widgets/widgets.dart';
import '../orders_model.dart';

class OrderController extends GetxController {
  String? id;
  Orders? order;
  List statusList = ['Pending', 'Accepted', 'OnRoute', 'Delivered'];
  RxInt statusIndex = 0.obs;
  double deliveryFee = 15.0;
  double rate = 0.01;

  int getStatusIndex() {
    if (order!.status == Status.pending) {
      return 0;
    } else if (order!.status == Status.accepted) {
      return 1;
    } else if (order!.status == Status.onRoute) {
      return 2;
    } else if (order!.status == Status.delivered) {
      return 3;
    } else {
      return 5;
    }
  }

  void assignOrder(Orders order, String id) async {
    this.order = order;
    this.id = id;
  }

  String getOrderNumber() {
    var str = order!.orderID.split("-");
    String id = str[1] + str[3];
    return id;
  }

  String getTotal() {
    double sum = 0;
    for (int i = 0; i < order!.items.length; i++) {
      sum = sum + (order!.items[i].price * order!.items[i].quantity);
    }
    return (sum + (sum * rate) + deliveryFee).toStringAsFixed(2);
  }

  switchPanel() {
    if (order!.status == Status.pending) {
      return getDeliveryDetails(order!);
    } else if (order!.status != Status.declined) {
      double activeStatus = 50.r;
      double inActiveStatus = 20.r;

      return Container(
        alignment: Alignment.centerLeft,
        width: double.infinity,
        child: ListView.builder(
          shrinkWrap: true,
          scrollDirection: Axis.vertical,
          itemCount: statusList.length,
          itemBuilder: (_, index) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    SizedBox(
                      child: SizedBox(
                        width: activeStatus,
                        child: Center(
                          child: Container(
                            height: getStatusIndex() == index
                                ? activeStatus
                                : inActiveStatus,
                            width: getStatusIndex() == index
                                ? activeStatus
                                : inActiveStatus,
                            decoration: BoxDecoration(
                                color: getStatusIndex() == index
                                    ? AppColors.primary
                                    : null,
                                borderRadius:
                                    BorderRadius.circular(activeStatus / 2),
                                border: getStatusIndex() != index
                                    ? Border.all(
                                        color:
                                            AppColors.lighten(AppColors.title!),
                                        width: 4.r)
                                    : null),
                            child: getStatusIndex() == index
                                ? Icon(
                                    Ionicons.checkmark,
                                    color: Colors.white,
                                    size: 35.r,
                                  )
                                : SizedBox(),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10.w,
                    ),
                    Text(
                      statusList[index],
                      style: getStatusIndex() == index
                          ? MediumHeaderStyle(
                              color: AppColors.secondary, fontSize: 30.sp)
                          : MediumHeaderStyle(
                              color: AppColors.title, fontSize: 20.sp),
                    )
                  ],
                ),
                index != statusList.length - 1
                    ? SizedBox(
                        width: activeStatus,
                        height: getStatusIndex() == index + 1
                            ? activeStatus + 5.h
                            : inActiveStatus,
                        child: Center(
                          child: Container(
                            height: getStatusIndex() == index + 1
                                ? activeStatus + 5.h
                                : inActiveStatus,
                            width: 4.w,
                            color: getStatusIndex() == index + 1
                                ? AppColors.primary
                                : AppColors.lighten(AppColors.title!),
                          ),
                        ),
                      )
                    : SizedBox(),
              ],
            );
          },
        ),
      );
    } else {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Ionicons.close_circle,
            color: HexColor('FF5B5B'),
            size: 90.r,
          ),
          SizedBox(
            height: 20.h,
          ),
          SizedBox(
            width: 250.w,
            child: Text(
              "This order was cancelled",
              style: MediumHeaderStyle(
                  fontSize: 30.sp, color: AppColors.secondary),
              textAlign: TextAlign.center,
            ),
          )
        ],
      );
    }
  }

  void onTapAccept() {
    if (order!.status == Status.pending) {
      FirestoreDB.fireDB
          .collection('orders')
          .document(id!)
          .update({'status': 'accepted'});
      update();
      Get.defaultDialog(
        title: "Completed",
        middleText: '${order!.name}\'s order has been accepted',
      ).whenComplete(() => backToOrders());
    }
  }

  void onTapDecline() {
    if (order!.status == Status.pending || order!.status != Status.declined) {
      FirestoreDB.fireDB
          .collection('orders')
          .document(id!)
          .update({'status': 'declined'});

      update();

      Get.defaultDialog(
        title: "Completed",
        middleText: '${order!.name}\'s order has been declined',
      ).whenComplete(() => backToOrders());
    }
  }
}
