import 'package:collectar_admin/orders/orders_controller.dart';
import 'package:collectar_admin/orders/orders_model.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:firedart/firestore/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

import '../firebase/firestore_db.dart';
import '../theme/appcolors.dart';
import '../theme/fonts.dart';
import '../widgets/widgets.dart';
import 'package:timeago/timeago.dart' as timeago;

class OrdersPage extends StatelessWidget {
  const OrdersPage({super.key});

  @override
  Widget build(BuildContext context) {
    ScrollController scrollController = ScrollController();
    final controller = Get.put(OrdersController());
    return Stack(children: [
      SingleChildScrollView(
        controller: scrollController,
        child: Column(
          children: [
            SizedBox(
              height: 200.h,
            ),
            StreamBuilder<List<Document>>(
                stream: FirestoreDB.orderStream(),
                builder: (context, AsyncSnapshot<List<Document>> snapshot) {
                  var data = snapshot.data;

                  if (data == null) {
                    return Center(
                        heightFactor: 15,
                        child: CircularProgressIndicator(
                          color: AppColors.primary,
                        ));
                  } else {
                    var datalength = data.length;
                    if (datalength == 0) {
                      return const Center(
                        child: Text('No data found'),
                      );
                    } else {
                      List<Orders> orderList =
                          data.map((e) => Orders.fromJson(e.map)).toList();
                      return AnimatedSize(
                        duration: Duration(milliseconds: 500),
                        child: Padding(
                            padding: EdgeInsets.only(
                                left: 50.w, right: 50.w, bottom: 50.h),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(30.r)),
                              height: 0.85.sh,
                              child: DataTable2(
                                columnSpacing: 0,
                                horizontalMargin: 10,
                                minWidth: 150.w,
                                columns: [
                                  DataColumn(label: Text('OrderID')),
                                  DataColumn(label: Text('Status')),
                                  DataColumn(label: Text('Name')),
                                  DataColumn(label: Text('Date')),
                                ],
                                rows: orderList
                                    .map((e) => DataRow(
                                            onSelectChanged: (selected) {
                                              if (selected!) {
                                                print(e.orderID);
                                                controller.onTap();
                                              }
                                            },
                                            cells: [
                                              DataCell(Text(e.orderID)),
                                              DataCell(Container(
                                                  width: 200.w,
                                                  height: 50.h,
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10.r),
                                                      border: Border.all(
                                                          width: 1.0,
                                                          color: AppColors
                                                              .background)),
                                                  child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Container(
                                                          height: 20.r,
                                                          width: 20.r,
                                                          decoration:
                                                              BoxDecoration(
                                                            color:
                                                                getStatusColor(
                                                                    e),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.r),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 20.w,
                                                        ),
                                                        Text(getStatusType(e))
                                                      ]))),
                                              DataCell(Text(e.name)),
                                              DataCell(
                                                  Text(timeago.format(e.date))),
                                            ]))
                                    .toList(),
                              ),
                            )),
                      );
                    }
                  }
                }),
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
