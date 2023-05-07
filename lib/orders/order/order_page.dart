import 'package:cached_network_image/cached_network_image.dart';
import 'package:collectar_admin/firebase/firestore_db.dart';
import 'package:collectar_admin/orders/order/order_controller.dart';
import 'package:collectar_admin/orders/orders_model.dart';
import 'package:collectar_admin/theme/appcolors.dart';
import 'package:collectar_admin/theme/fonts.dart';
import 'package:collectar_admin/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

import '../../widgets/customcontainer.dart';

class OrderPage extends StatelessWidget {
  OrderPage({super.key});

  final controller = Get.find<OrderController>();
  ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
            height: 0.1.sh,
            width: double.infinity,
            child: customAppBar(backButtonOnTap: backToOrders)),
        SizedBox(
          height: 0.85.sh,
          width: 0.75.sw,
          child: Padding(
            padding: EdgeInsets.all(50.r),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'OrderID #${controller.getOrderNumber()}',
                      style: BoldHeaderstextStyle(
                          color: AppColors.secondary, fontSize: 35.sp),
                    ),
                    GetBuilder<OrderController>(builder: (orderController) {
                      return Row(
                        children: [
                          Button(
                            widget: Text(
                              'Cancel Order',
                              style: BoldHeaderstextStyle(
                                  color: Colors.white, fontSize: 20.sp),
                            ),
                            width: 200.w,
                            height: 75.h,
                            containerColor:
                                orderController.order!.status != Status.declined
                                    ? HexColor('FF5B5B')
                                    : AppColors.darken(AppColors.background),
                            onTap: controller.onTapDecline,
                          ),
                          SizedBox(
                            width: 30.w,
                          ),
                          orderController.order!.status == Status.pending
                              ? Button(
                                  widget: Text(
                                    'Accept Order',
                                    style: BoldHeaderstextStyle(
                                        color: Colors.white, fontSize: 20.sp),
                                  ),
                                  width: 200.w,
                                  height: 75.h,
                                  containerColor: HexColor('00EF71'),
                                  onTap: orderController.onTapAccept,
                                )
                              : SizedBox()
                        ],
                      );
                    })
                  ],
                ),
                SizedBox(
                  height: 20.h,
                ),
                SizedBox(
                  child: StaggeredGrid.count(
                    axisDirection: AxisDirection.down,
                    crossAxisCount: 4,
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                    children: [
                      StaggeredGridTile.count(
                          crossAxisCellCount: 1,
                          mainAxisCellCount: 1,
                          child: getContainer(
                              widget: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                height: 200.r,
                                width: 200.r,
                                decoration: BoxDecoration(
                                    color:
                                        AppColors.darken(AppColors.background),
                                    borderRadius: BorderRadius.circular(100.r)),
                                child: Icon(
                                  Ionicons.person,
                                  color: Colors.white,
                                  size: 100.r,
                                ),
                              ),
                              SizedBox(
                                height: 20.h,
                              ),
                              Text(
                                controller.order!.name,
                                style:
                                    MediumHeaderStyle(color: AppColors.title),
                              ),
                              SizedBox(
                                height: 20.h,
                              ),
                              Button(
                                height: 65.h,
                                width: 200.w,
                                widget: Text(
                                  'Customer',
                                  style: MediumHeaderStyle(
                                    color: Colors.white,
                                  ),
                                ),
                                containerColor:
                                    AppColors.primary.withOpacity(0.7),
                              )
                            ],
                          ))),
                      StaggeredGridTile.count(
                          crossAxisCellCount: 3,
                          mainAxisCellCount: 2,
                          child: getContainer(
                              widget: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 30.w),
                                height: 0.090.sh,
                                color: AppColors.primary,
                                child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                          width: 300.w,
                                          child: Text(
                                            'Items',
                                            style: MediumHeaderStyle(
                                                color: Colors.white,
                                                fontSize: 30.sp),
                                          )),
                                      Container(
                                          alignment: Alignment.center,
                                          width: 70.w,
                                          child: Text(
                                            'Qty',
                                            style: MediumHeaderStyle(
                                                color: Colors.white,
                                                fontSize: 30.sp),
                                          )),
                                      SizedBox(
                                          width: 170.w,
                                          child: Text(
                                            'Price',
                                            style: MediumHeaderStyle(
                                                color: Colors.white,
                                                fontSize: 30.sp),
                                          )),
                                      SizedBox(
                                          width: 170.w,
                                          child: Text(
                                            'Total Price',
                                            style: MediumHeaderStyle(
                                                color: Colors.white,
                                                fontSize: 30.sp),
                                          )),
                                    ]),
                              ),
                              SizedBox(
                                height: 0.474.sh,
                                child: ListView.builder(
                                    physics: ClampingScrollPhysics(),
                                    itemCount: controller.order!.items.length,
                                    itemBuilder: (context, index) {
                                      return Container(
                                        margin: EdgeInsets.all(10.r),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 30.w),
                                        height: 150.h,
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(15.r)),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                              width: 300.w,
                                              child: Row(
                                                children: [
                                                  Container(
                                                    height: 105.r,
                                                    width: 105.r,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(15.r),
                                                        color: Color(controller
                                                            .order!
                                                            .items[index]
                                                            .color)),
                                                    child: CachedNetworkImage(
                                                        imageUrl: controller
                                                            .order!
                                                            .items[index]
                                                            .image),
                                                  ),
                                                  SizedBox(
                                                    width: 20.w,
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      SizedBox(
                                                        width: 100.w,
                                                        child: Text(
                                                          controller.order!
                                                              .items[index].id,
                                                          style:
                                                              BoldHeaderstextStyle(
                                                                  color:
                                                                      AppColors
                                                                          .title,
                                                                  fontSize:
                                                                      20.sp),
                                                        ),
                                                      ),
                                                      SizedBox(
                                                        width: 175.w,
                                                        child: Text(
                                                          controller
                                                              .order!
                                                              .items[index]
                                                              .name,
                                                          maxLines: 2,
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                          style: MediumHeaderStyle(
                                                              color: AppColors
                                                                  .secondary,
                                                              fontSize: 25.sp),
                                                        ),
                                                      ),
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ),
                                            Container(
                                              alignment: Alignment.center,
                                              width: 70.w,
                                              child: Text(
                                                controller.order!.items[index]
                                                    .quantity
                                                    .toString(),
                                                style: MediumHeaderStyle(
                                                    color: AppColors.secondary),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 170.w,
                                              child: Text(
                                                '₵ ${(controller.order!.items[index].price).toStringAsFixed(2)}',
                                                style: MediumHeaderStyle(),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 170.w,
                                              child: Text(
                                                '₵ ${(double.parse(controller.order!.items[index].price.toStringAsFixed(2)) * controller.order!.items[index].quantity).toStringAsFixed(2)}',
                                                style: MediumHeaderStyle(),
                                              ),
                                            ),
                                          ],
                                        ),
                                      );
                                    }),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 30.w),
                                alignment: Alignment.centerRight,
                                width: double.infinity,
                                color: AppColors.primary,
                                height: 0.0701.sh,
                                child: Text(
                                  "Total: ₵ ${controller.getTotal()}",
                                  style: MediumHeaderStyle(color: Colors.white),
                                ),
                              )
                            ],
                          ))),
                      StaggeredGridTile.count(
                          crossAxisCellCount: 1,
                          mainAxisCellCount: 1,
                          child: getContainer(
                              widget: controller.switchPanel(),
                              alignment: controller.order!.status !=
                                          Status.pending &&
                                      controller.order!.status !=
                                          Status.declined
                                  ? Alignment.centerLeft
                                  : Alignment.center,
                              padding:
                                  controller.order!.status != Status.pending &&
                                          controller.order!.status !=
                                              Status.declined
                                      ? EdgeInsets.all(30.r)
                                      : null)),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
