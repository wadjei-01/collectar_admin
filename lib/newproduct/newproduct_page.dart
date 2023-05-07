import 'dart:async';
import 'dart:io';
import 'package:collectar_admin/firebase/cloudstorage.dart';
import 'package:collectar_admin/newproduct/newproduct_controller.dart';
import 'package:collectar_admin/theme/appcolors.dart';
import 'package:collectar_admin/theme/fonts.dart';
import 'package:collectar_admin/widgets/widgets.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
// import 'package:open_file/open_file.dart';
import 'dart:ui' as ui;
import 'package:file_picker/file_picker.dart';
import 'package:ionicons/ionicons.dart';
import 'package:multi_select_flutter/chip_display/multi_select_chip_display.dart';
import 'package:multi_select_flutter/chip_field/multi_select_chip_field.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:path/path.dart' as p;

import '../categories/categories_model.dart';

class NewProductPage extends StatelessWidget {
  const NewProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<NewProductController>();
    return Stack(
      children: [
        SingleChildScrollView(
          child: Column(children: [
            SizedBox(
              height: 170.h,
            ),
            Padding(
              padding: EdgeInsets.all(30.r),
              child: StaggeredGrid.count(
                crossAxisCount: 4,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                children: [
                  StaggeredGridTile.count(
                    crossAxisCellCount: 2,
                    mainAxisCellCount: 2,
                    child: getContainer(
                        title: "Product Info",
                        widget: getProductTextField(controller)),
                  ),
                  StaggeredGridTile.count(
                    crossAxisCellCount: 2,
                    mainAxisCellCount: 1,
                    child: getImageContainer(controller),
                  ),
                  StaggeredGridTile.count(
                    crossAxisCellCount: 2,
                    mainAxisCellCount: 2,
                    child: getContainer(
                        title: "Color",
                        widget: getColorPickerContainer(controller)),
                  ),
                  StaggeredGridTile.count(
                      crossAxisCellCount: 2,
                      mainAxisCellCount: 1,
                      child: getContainer(
                        title: "Category",
                        widget: getMultiSelectCategoryContainer(controller),
                      )),
                  StaggeredGridTile.count(
                    crossAxisCellCount: 1,
                    mainAxisCellCount: 1,
                    child: getContainer(
                      title: "Pricing",
                      widget: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 30.w),
                          child: Column(children: [
                            SizedBox(
                              height: 50.h,
                            ),
                            textNumField(controller.productPrice,
                                textAlign: TextAlign.end,
                                icon: Text(
                                  "GH₵",
                                  style: MediumHeaderStyle(),
                                ),
                                textInputType:
                                    const TextInputType.numberWithOptions(
                                        decimal: true)),
                            SizedBox(
                              height: 20.h,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Discount",
                                  style: MediumHeaderStyle(fontSize: 30.sp),
                                ),
                                Obx(() {
                                  return CupertinoSwitch(
                                      value: controller.isDiscount.value,
                                      onChanged: controller.switchDiscount);
                                }),
                              ],
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            Obx(() => textNumField(controller.productDiscount,
                                textAlign: TextAlign.end,
                                icon: Text(
                                  "%",
                                  style: MediumHeaderStyle(),
                                ),
                                textInputType: TextInputType.number,
                                enabled: controller.isDiscount.value))
                          ])),
                    ),
                  ),
                  StaggeredGridTile.count(
                      crossAxisCellCount: 2,
                      mainAxisCellCount: 1,
                      child: getContainer(
                          title: "Measurements",
                          widget: Padding(
                            padding: EdgeInsets.symmetric(horizontal: 80.w),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: 250.w,
                                      child: textNumField(
                                        controller.productLength,
                                        textAlign: TextAlign.end,
                                        textInputType:
                                            TextInputType.numberWithOptions(
                                                decimal: true),
                                        icon: Text(
                                          "L",
                                          style: MediumHeaderStyle(),
                                        ),
                                        suffix: Text(
                                          "m",
                                          style: MediumHeaderStyle(),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 20.w,
                                    ),
                                    SizedBox(
                                      width: 250.w,
                                      child: textNumField(
                                        controller.productWidth,
                                        textAlign: TextAlign.end,
                                        textInputType:
                                            TextInputType.numberWithOptions(
                                                decimal: true),
                                        icon: Text(
                                          "W",
                                          style: MediumHeaderStyle(),
                                        ),
                                        suffix: Text(
                                          "m",
                                          style: MediumHeaderStyle(),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 20.w,
                                    ),
                                    SizedBox(
                                      width: 250.w,
                                      child: textNumField(
                                        controller.productHeight,
                                        textAlign: TextAlign.end,
                                        textInputType:
                                            TextInputType.numberWithOptions(
                                                decimal: true),
                                        icon: Text(
                                          "H",
                                          style: MediumHeaderStyle(),
                                        ),
                                        suffix: Text(
                                          "m",
                                          style: MediumHeaderStyle(),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 50.h,
                                ),
                                textNumField(
                                  controller.productWeight,
                                  textAlign: TextAlign.end,
                                  textInputType:
                                      TextInputType.numberWithOptions(
                                          decimal: true),
                                  suffix: Text(
                                    "kg",
                                    style: MediumHeaderStyle(),
                                  ),
                                )
                              ],
                            ),
                          ))),
                  StaggeredGridTile.count(
                      crossAxisCellCount: 1,
                      mainAxisCellCount: 1,
                      child: Padding(
                          padding: EdgeInsets.only(bottom: 100.h),
                          child: getContainer(
                              title: "Materials",
                              widget: Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 50.w),
                                  child: textField(controller.productMaterials,
                                      maxLines: 4,
                                      errorText: controller.errorText(
                                          controller.productMaterials.text,
                                          "Materials")))))),
                  StaggeredGridTile.count(
                      crossAxisCellCount: 2,
                      mainAxisCellCount: 1,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 500.h,
                          ),
                          Button(
                            width: 300.w,
                            height: 100.h,
                            containerColor: AppColors.secondary,
                            onTap: () {
                              print(p.extension(controller.model.string));
                            },
                            widget: Text(
                              "Discard",
                              style: MediumHeaderStyle(color: Colors.white),
                            ),
                          ),
                          SizedBox(
                            width: 20.w,
                          ),
                          Obx(() {
                            return Button(
                                containerColor: controller.pickerColor.value,
                                onTap: controller.onSubmit,
                                width: 300.w,
                                height: 100.h,
                                widget:
                                    Obx(() => controller.uploadButtonInfo()));
                          }),
                        ],
                      ))
                ],
              ),
            )
          ]),
        ),
        customAppBar(text: "New Product", backButtonOnTap: backToProduct)
      ],
    );
  }

  Widget getImageContainer(NewProductController controller) {
    return getContainer(
        title: "Images",
        widget: Padding(
          padding: EdgeInsets.all(50.r),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              getUploadImageButton(controller),
              SizedBox(
                height: 25.h,
              ),
              getUploadModelButton(controller)
            ],
          ),
        ));
  }

  Padding getProductTextField(NewProductController controller) {
    return Padding(
      padding: EdgeInsets.all(50.r),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 10.h,
          ),
          Text(
            "Product Name",
            style:
                MediumHeaderStyle(fontSize: 30.sp, color: AppColors.secondary),
          ),
          SizedBox(
            height: 20.h,
          ),
          textField(controller.productName,
              hint: "Product Name",
              errorText: controller.errorText(
                  controller.productName.text, "Product Name")),
          SizedBox(
            height: 30.h,
          ),
          Text(
            "Product Description",
            style:
                MediumHeaderStyle(fontSize: 30.sp, color: AppColors.secondary),
          ),
          SizedBox(
            height: 20.h,
          ),
          textField(controller.productDesc,
              hint: "Product Description",
              textInputType: TextInputType.multiline,
              maxLines: 3,
              errorText: controller.errorText(
                  controller.productDesc.text, "Product Description")),
          SizedBox(
            height: 15.h,
          ),
          Text(
            "Product Details",
            style:
                MediumHeaderStyle(fontSize: 30.sp, color: AppColors.secondary),
          ),
          SizedBox(
            height: 10.h,
          ),
          textField(controller.productDetails,
              hint: "Product Details",
              textInputType: TextInputType.multiline,
              maxLines: 4),
        ],
      ),
    );
  }

  Obx getUploadModelButton(NewProductController controller) {
    return Obx(() {
      return DottedBorder(
          borderType: BorderType.RRect,
          padding: EdgeInsets.all(2.r),
          color: controller.isModelUploaded.isFalse
              ? AppColors.darken(AppColors.background, 0.2)
              : Colors.transparent,
          strokeWidth: 2,
          dashPattern: [15, 15],
          strokeCap: StrokeCap.round,
          radius: Radius.circular(20.r),
          child: GestureDetector(
            onTap: () => controller.tapToUploadModel(['glb', 'gltf']),
            child: AnimatedContainer(
              duration: Duration(milliseconds: 300),
              height: 100.h,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: controller.isModelUploaded.isFalse
                      ? AppColors.darken(AppColors.background, 0.05)
                      : controller.pickerColor.value,
                  borderRadius: BorderRadius.circular(20.r)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  controller.isModelUploaded.isTrue
                      ? SizedBox()
                      : Icon(
                          Ionicons.cloud_circle_sharp,
                          color: AppColors.secondary,
                          size: 70.r,
                        ),
                  SizedBox(
                    width: 10.w,
                  ),
                  controller.isModelUploaded.isTrue
                      ? Text(
                          "${p.basename(controller.model.value.path)}",
                          style: MediumHeaderStyle(
                              fontSize: 25.sp,
                              color: AppColors.darken(
                                  controller.pickerColor.value, 0.5)),
                        )
                      : Text(
                          "Upload 3D model",
                          style: MediumHeaderStyle(fontSize: 25.sp),
                        )
                ],
              ),
            ),
          ));
    });
  }

  Row getUploadImageButton(NewProductController controller) {
    double imageContainerHeight = 200.h;
    return Row(
      children: [
        Expanded(
          child: GestureDetector(
            onTap: () => controller.tapToUploadImage(['jpeg', 'jpg', 'png']),
            child: DottedBorder(
              borderType: BorderType.RRect,
              padding: EdgeInsets.all(1.r),
              color: AppColors.darken(AppColors.background, 0.2),
              strokeWidth: 2,
              dashPattern: [15, 15],
              strokeCap: StrokeCap.round,
              radius: Radius.circular(20.r),
              child: Obx(() {
                return AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  height: imageContainerHeight,
                  decoration: BoxDecoration(
                    color: AppColors.darken(AppColors.background, 0.05),
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  alignment: Alignment.center,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Ionicons.image_sharp,
                        color: AppColors.secondary,
                        size: controller.isImageUploaded.isFalse ? 100.r : 50.r,
                      ),
                      SizedBox(
                        width: 10.w,
                      ),
                      controller.isImageUploaded.isTrue
                          ? SizedBox()
                          : Text(
                              "Click to upload images",
                              maxLines: 2,
                              style: MediumHeaderStyle(
                                  fontSize: 30.sp, color: AppColors.secondary),
                            ),
                    ],
                  ),
                );
              }),
            ),
          ),
        ),
        Obx(() => controller.images.isEmpty
            ? const SizedBox()
            : AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: 25.w,
              )),
        Obx(
          () => controller.images.length == 0
              ? const SizedBox()
              : SizedBox(
                  width: 700.w,
                  height: imageContainerHeight,
                  child: Obx(
                    () => GridView.custom(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        gridDelegate: SliverQuiltedGridDelegate(
                          crossAxisCount: 4,
                          mainAxisSpacing: 5,
                          crossAxisSpacing: 5,
                          repeatPattern: QuiltedGridRepeatPattern.mirrored,
                          pattern: [
                            QuiltedGridTile(4, 4),
                            QuiltedGridTile(2, 2),
                            QuiltedGridTile(2, 2),
                            QuiltedGridTile(4, 4),
                          ],
                        ),
                        childrenDelegate: SliverChildBuilderDelegate(
                          childCount: controller.images.length,
                          (context, index) => Obx(() {
                            return AnimatedContainer(
                              duration: Duration(milliseconds: 300),
                              clipBehavior: Clip.hardEdge,
                              decoration: BoxDecoration(
                                  color: controller.isColorChanged.isTrue
                                      ? controller.pickerColor.value
                                      : AppColors.lighten(
                                          AppColors.secondary, 0.4),
                                  borderRadius: BorderRadius.circular(20.r)),
                              child: Stack(fit: StackFit.expand, children: [
                                Image.file(
                                  controller.images[index],
                                  fit: index == 0
                                      ? BoxFit.fitWidth
                                      : BoxFit.cover,
                                  width: 100.w,
                                ),
                                Align(
                                  alignment: Alignment.topRight,
                                  child: GestureDetector(
                                    onTap: () {
                                      controller.images.removeAt(index);
                                      if (controller.images.isEmpty) {
                                        controller.isImageUploaded(false);
                                      }
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      margin: EdgeInsets.all(10.r),
                                      width: 50.r,
                                      height: 50.r,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(25.r)),
                                      child: Icon(
                                        Icons.close,
                                        size: 25.r,
                                      ),
                                    ),
                                  ),
                                )
                              ]),
                            );
                          }),
                        )),
                  )),
        )
      ],
    );
  }

  Column getColorPickerContainer(NewProductController controller) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 700.r,
          width: 700.r,
          child: ColorPicker(
              colorPickerWidth: 350.r,
              paletteType: PaletteType.hueWheel,
              enableAlpha: false,
              portraitOnly: true,
              pickerColor: controller.pickerColor.value,
              onColorChanged: controller.changeColor),
        ),
        Obx(() => Text("${controller.pickerColor.value}"))
      ],
    );
  }

  Column getMultiSelectCategoryContainer(NewProductController controller) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Obx(() {
          return MultiSelectChipField(
            items: controller.categories
                .getCatList()
                .entries
                .map((e) => MultiSelectItem(e.key, e.value))
                .toList(),
            initialValue: [],
            decoration: const BoxDecoration(),
            chipShape: RoundedRectangleBorder(
                side: BorderSide.none,
                borderRadius: BorderRadius.circular(15.r)),
            chipColor: controller.isColorChanged.isTrue
                ? AppColors.lighten(controller.pickerColor.value, 0.3)
                : AppColors.lighten(AppColors.primary, 0.3),
            selectedChipColor: controller.isColorChanged.isTrue
                ? controller.pickerColor.value
                : AppColors.primary,
            selectedTextStyle: MediumHeaderStyle(color: Colors.white),
            textStyle: MediumHeaderStyle(
                color: controller.isColorChanged.isTrue
                    ? AppColors.darken(controller.pickerColor.value, 0.5)
                    : AppColors.darken(AppColors.primary, 0.3)),
            showHeader: false,
            scroll: false,
            onTap: (p0) {
              controller.values(p0);
              print(controller.values);
            },
          );
        }),
      ],
    );
  }
}
