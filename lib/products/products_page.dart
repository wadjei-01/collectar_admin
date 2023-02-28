import 'package:collectar_admin/firebase/firestore_db.dart';
import 'package:collectar_admin/item/item_controller.dart';
import 'package:collectar_admin/item/item_page.dart';
import 'package:collectar_admin/mainscreen/mainscreen_controller.dart';
import 'package:collectar_admin/newproduct/newproduct_controller.dart';
import 'package:collectar_admin/products/product_model.dart';
import 'package:collectar_admin/theme/appcolors.dart';
import 'package:collectar_admin/theme/fonts.dart';
import 'package:firedart/firedart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import '../newproduct/newproduct_page.dart';
import '../widgets/widgets.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<MainScreenController>();
    final itemController = Get.put(ItemController());
    ScrollController scrollController = ScrollController();
    return Stack(children: [
      SingleChildScrollView(
        controller: scrollController,
        child: Column(
          children: [
            SizedBox(
              height: 200.h,
            ),
            FutureBuilder<List<Document>>(
                future: FirestoreDB.productStream(),
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
                      return Padding(
                        padding: EdgeInsets.only(
                            left: 50.w, right: 50.w, bottom: 50.h),
                        child: GridView.builder(
                          // controller: scrollController,
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 4,
                            mainAxisSpacing: 30.h,
                            childAspectRatio: 2.w / 2.2.h,
                            crossAxisSpacing: 30.w,
                          ),
                          itemCount: datalength,
                          itemBuilder: (context, index) {
                            return ProductCard(
                              storedProducts: Product.fromJson(data[index].map),
                              onPressed: () {
                                controller.onCardPressed(ItemPage());
                                itemController.onInitiate(data[index].id,
                                    Product.fromJson(data[index].map));
                              },
                            );
                          },
                        ),
                      );
                    }
                  }
                }),
          ],
        ),
      ),
      Positioned(
          child: Container(
        padding: EdgeInsets.symmetric(horizontal: 50.w),
        height: 150.h,
        width: double.infinity,
        color: Colors.white,
        child: Center(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
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
                )),
            Button(
              onTap: () {
                Get.put(NewProductController());
                controller.onCardPressed(NewProductPage());
              },
              containerColor: AppColors.primary,
              textColor: Colors.white,
              widget: Text(
                "Add Product",
                style: MediumHeaderStyle(color: Colors.white),
              ),
              width: 350.w,
              height: 90.h,
            ),
          ],
        )),
      )),
    ]);
  }
}
