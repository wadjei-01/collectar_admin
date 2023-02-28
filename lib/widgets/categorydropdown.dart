import 'package:collectar_admin/categories/categories_model.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../item/item_controller.dart';
import '../theme/appcolors.dart';

class CategoryDropDown extends StatelessWidget {
  CategoryDropDown({
    Key? key,
    // required this.prodController,
  }) : super(key: key);

  final category = Categories();
  var items = [1, 2, 3, 4, 5, 6, 7, 8, 9];

  @override
  Widget build(BuildContext context) {
    // TextEditingController textEditingController = TextEditingController();
    return GetX<ItemController>(builder: (prodController) {
      return DropdownButtonHideUnderline(
        child: IntrinsicWidth(
          child: DropdownButton2(
            isExpanded: true,
            value: prodController.productCat.value,
            items: items.map((item) {
              return DropdownMenuItem(
                value: item,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Text(category.getCatName(item)!),
                ),
              );
            }).toList(),
            onChanged: (dynamic value) {
              prodController.category(value);
              prodController.isMatched(
                  value!, prodController.product.category[0]);
            },
            buttonHeight: 40,
            // buttonWidth: 200.w,
            buttonDecoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.r),
                color: AppColors.lighten(AppColors.title!, 0.5)),
            itemHeight: 40,
            dropdownMaxHeight: 200,
            dropdownWidth: 400.w,
            dropdownDecoration:
                BoxDecoration(borderRadius: BorderRadius.circular(20.r)),
            // searchController: textEditingController,
            // searchInnerWidget: Padding(
            //   padding: const EdgeInsets.only(
            //     top: 8,
            //     bottom: 4,
            //     right: 8,
            //     left: 8,
            //   ),
            // child: TextFormField(
            //   controller: textEditingController,
            //   decoration: InputDecoration(
            //     isDense: true,
            //     contentPadding: const EdgeInsets.symmetric(
            //       horizontal: 10,
            //       vertical: 8,
            //     ),
            //     hintText: 'Search for an item...',
            //     hintStyle: const TextStyle(fontSize: 12),
            //     border: OutlineInputBorder(
            //       borderRadius: BorderRadius.circular(8),
            //     ),
            //   ),
            // ),
            // ),
            // searchMatchFn: (item, searchValue) {
            //   return (item.value.toString().contains(searchValue));
            // },
          ),
        ),
      );
    });
  }
}
// TextEditor(
//       string: prodController.productCat,
//       // width: 300.w,
//       horizontalPadding: 30.w,
//       textAlign: TextAlign.center,
//       textAlignVertical: TextAlignVertical.center,
//       style: MediumHeaderStyle(color: Colors.white),
//     );
