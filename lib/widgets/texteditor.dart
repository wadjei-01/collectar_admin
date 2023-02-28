import 'package:collectar_admin/item/item_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class TextEditor extends StatelessWidget {
  TextEditor(
      {super.key,
      required this.string,
      this.horizontalPadding,
      this.style,
      this.width,
      this.textAlign,
      this.textAlignVertical,
      this.textInputType});
  final TextEditingController string;
  double? horizontalPadding;
  TextStyle? style;
  double? width;
  TextAlign? textAlign;
  TextAlignVertical? textAlignVertical;
  TextInputType? textInputType;

  @override
  Widget build(BuildContext context) {
    // bool isEnabled = false;
    final controller = Get.find<ItemController>();
    final String text = string.text;
    return GestureDetector(
      onTap: () {
        // isEnabled = true;
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: horizontalPadding ?? 0.w),
        child: IntrinsicWidth(
          child: IntrinsicHeight(
            child: Container(
              // width: widget.width ?? 700.w,
              child: TextField(
                controller: string,
                maxLines: textInputType == TextInputType.multiline ? null : 1,
                textAlign: textAlign ?? TextAlign.start,
                textAlignVertical: textAlignVertical,
                keyboardType: textInputType,
                enabled: true,
                decoration: InputDecoration(border: InputBorder.none),
                style: style,
                onChanged: (v) {
                  // print(widget.string.text);
                  controller.isMatched(text, string.text);
                  //TODO: Use a boolean to active the save button
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
