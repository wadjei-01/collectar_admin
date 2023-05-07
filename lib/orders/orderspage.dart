import 'package:collectar_admin/orders/order/order_page.dart';
import 'package:collectar_admin/orders/orders_controller.dart';
import 'package:collectar_admin/orders/orders_model.dart';
import 'package:collectar_admin/widgets/orderscard.dart';
import 'package:firedart/firestore/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

import '../firebase/firestore_db.dart';
import '../theme/appcolors.dart';
import '../theme/fonts.dart';

import 'order/order_controller.dart';

class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    ScrollController scrollController = ScrollController();
    final controller = Get.put(OrdersController());
    final orderController = Get.put(OrderController());
    return Stack(children: [
      SingleChildScrollView(
        controller: scrollController,
        child: Column(
          children: [
            SizedBox(
              height: 250.h,
            ),
            Row(
              children: [
                Container(
                  alignment: Alignment.centerLeft,
                  height: 90.h,
                  width: 1200.w,
                  child: GetBuilder<OrdersController>(
                      builder: (controller) => ListView.builder(
                          padding: EdgeInsets.symmetric(horizontal: 50.w),
                          itemCount: controller.orderByList.length,
                          physics: NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                controller.selectedIndex(index);
                                controller.update();
                              },
                              child: Container(
                                margin: EdgeInsets.symmetric(horizontal: 30.w),
                                alignment: Alignment.center,
                                width: 300.w,
                                height: 55.h,
                                decoration: BoxDecoration(
                                    color:
                                        controller.selectedIndex.value == index
                                            ? AppColors.primary
                                            : AppColors.title,
                                    borderRadius: BorderRadius.circular(15.r)),
                                child: Text(
                                  controller.orderByList[index],
                                  style: MediumHeaderStyle(
                                      color: Colors.white, fontSize: 30.sp),
                                ),
                              ),
                            );
                          })),
                ),
                Container(
                  decoration: BoxDecoration(
                      color: AppColors.darken(AppColors.background),
                      borderRadius: BorderRadius.circular(15.r)),
                  child: Obx(() => IconButton(
                      onPressed: controller.switchOrder,
                      icon: Icon(
                        controller.isDescending.isTrue
                            ? Ionicons.chevron_down
                            : Ionicons.chevron_up,
                        color: AppColors.secondary,
                      ))),
                )
              ],
            ),
            SizedBox(
              height: 50.h,
            ),
            GetBuilder<OrdersController>(
              builder: (controller) {
                return StreamBuilder<List<Document>>(
                  stream: FirestoreDB.orderStream(
                      orderBy: controller
                          .orderBySelection[controller.selectedIndex.value],
                      descending: controller.isDescending.value),
                  builder: (context, AsyncSnapshot<List<Document>> snapshot) {
                    var data = snapshot.data;

                    if (data == null) {
                      return Center(
                        heightFactor: 15,
                        child: CircularProgressIndicator(
                          color: AppColors.primary,
                        ),
                      );
                    } else {
                      final orderList =
                          data.map((e) => Orders.fromJson(e.map)).toList();
                      return AnimatedSize(
                        duration: const Duration(milliseconds: 500),
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: 50.0,
                            right: 50.0,
                            bottom: 50.0,
                          ),
                          child: ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: data.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 10.0),
                                child: OrdersCard(
                                  orders: orderList[index],
                                  onTap: () {
                                    controller.mainScreenController
                                        .onCardPressed(OrderPage());
                                    orderController.assignOrder(
                                        orderList[index], data[index].id);
                                  },
                                ),
                              );
                            },
                          ),
                        ),
                      );
                    }
                  },
                );
              },
            )
          ],
        ),
      ),
      Positioned(
          child: Container(
        height: 150.h,
        width: double.infinity,
        color: Colors.white,
        child: Center(
            child: Container(
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 237, 237, 237),
                    borderRadius: BorderRadius.circular(20.r)),
                width: 700.w,
                child: TextField(
                  style: MediumHeaderStyle(
                      color: AppColors.title, fontSize: 35.sp),
                  cursorColor: AppColors.primary,
                  decoration: InputDecoration(
                      hintText: "Search",
                      hintStyle: MediumHeaderStyle(
                          color: AppColors.title, fontSize: 35.sp),
                      icon: Padding(
                        padding: EdgeInsets.only(left: 25.w),
                        child: Icon(Ionicons.search),
                      ),
                      iconColor: AppColors.primary,
                      focusColor: AppColors.primary,
                      border: InputBorder.none),
                ))),
      )),
    ]);
  }

  String getStatusType(Orders e) {
    if (e.status.name == "pending") {
      return "Pending";
    }
    if (e.status.name == "accepted") {
      return "Accepted";
    }

    if (e.status.name == "onRoute") {
      return "On Route";
    } else if (e.status.name == "delivered") {
      return "Delivered";
    } else {
      return e.status.name;
    }
  }

  Color getStatusColor(Orders e) {
    if (e.status.name == "pending") {
      return Colors.yellow;
    } else if (e.status.name == "accepted") {
      return Colors.green;
    } else if (e.status.name == "onRoute") {
      return Colors.green;
    } else if (e.status.name == "delivered") {
      return Colors.green;
    } else {
      return Colors.red;
    }
  }
}
