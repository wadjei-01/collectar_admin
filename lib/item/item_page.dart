import 'package:collectar_admin/firebase/firestore_db.dart';
import 'package:collectar_admin/item/item_controller.dart';
import 'package:collectar_admin/products/product_model.dart';
import 'package:collectar_admin/theme/appcolors.dart';
import 'package:collectar_admin/theme/fonts.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import '../mainscreen/mainscreen_controller.dart';
import '../widgets/side_menu_controller.dart';
import '../widgets/widgets.dart';

class ItemPage extends StatelessWidget {
  ItemPage({super.key});

  final controller = Get.find<ItemController>();
  final mainscreencontroller = Get.find<MainScreenController>();
  final sidemenucontroller = Get.find<SideMenuController>();

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 200.h,
            ),
            SizedBox(
              height: 500.h,
              child: ImagesListView(product: controller.product),
            ),
            SizedBox(
              height: 10.h,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: IntrinsicHeight(
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 1000),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30.r)),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 50.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 50.h,
                        ),
                        Padding(
                          padding: EdgeInsets.only(right: 100.w),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextEditor(
                                string: controller.productName,
                                style: BoldHeaderstextStyle(
                                    color: HexColor(
                                        controller.product.imageColour)),
                              ),
                              Row(
                                children: [
                                  Text(
                                    '₵',
                                    style: BoldHeaderstextStyle(
                                        color: AppColors.lighten(
                                            HexColor(
                                                controller.product.imageColour),
                                            0.2),
                                        fontSize: 40.sp),
                                  ),
                                  TextEditor(
                                    string: controller.productPrice,
                                    textInputType: TextInputType.number,
                                    style: BoldHeaderstextStyle(
                                        color: AppColors.lighten(
                                            HexColor(
                                                controller.product.imageColour),
                                            0.2),
                                        fontSize: 40.sp),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Category ",
                              style: MediumHeaderStyle(color: AppColors.title),
                            ),
                            SizedBox(
                              width: 10.w,
                            ),
                            IntrinsicWidth(
                              child: CategoryDropDown(
                                  // prodController: controller
                                  ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: TextEditor(
                            string: controller.productDesc,
                            textInputType: TextInputType.multiline,
                          ),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Text(
                          "Details",
                          style: BoldHeaderstextStyle(
                              color: AppColors.title, fontSize: 40.sp),
                        ),
                        SizedBox(
                          width: double.infinity,
                          child: TextEditor(
                            string: controller.productDet,
                            textInputType: TextInputType.multiline,
                          ),
                        ),
                        SizedBox(
                          height: 20.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Button(
                                onTap: () {},
                                height: 90.h,
                                width: 340.w,
                                widget: Text(
                                  'Delete',
                                  style: MediumHeaderStyle(color: Colors.white),
                                ),
                                containerColor: Colors.red),
                            SizedBox(
                              width: 50.w,
                            ),
                            GetX<ItemController>(
                                builder: (controller) => Button(
                                    onTap: () {
                                      Product product = controller.product;
                                      Product product1 = Product(
                                          id: product.id,
                                          name: controller.productName.text,
                                          description:
                                              controller.productDesc.text,
                                          details: controller.productDet.text,
                                          materials: product.materials,
                                          price: double.parse(
                                              controller.productPrice.text),
                                          stock: product.stock,
                                          images: product.images,
                                          imageColour: product.imageColour,
                                          dateAdded: product.dateAdded,
                                          category: product.category,
                                          modelAR: product.modelAR,
                                          measurements: [
                                            100.10,
                                            200.1,
                                            300.1,
                                            400
                                          ]);

                                      FirestoreDB.update(
                                          controller.id, product1);
                                      controller.isChanged.value = false;

                                      Get.defaultDialog(
                                        title: "Completed",
                                        middleText: 'Changes have been saved',
                                      );
                                    },
                                    width: 340.w,
                                    height: 90.h,
                                    widget: Text(
                                      'Save',
                                      style: MediumHeaderStyle(
                                          color: Colors.white),
                                    ),
                                    containerColor: controller.isChanged.isTrue
                                        ? AppColors.primary
                                        : AppColors.title)),
                          ],
                        ),
                        SizedBox(
                          height: 30.h,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      Positioned(child: customAppBar()),
    ]);
  }
}
