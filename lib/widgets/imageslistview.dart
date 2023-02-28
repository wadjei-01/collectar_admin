import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../products/product_model.dart';
import '../theme/appcolors.dart';

class ImagesListView extends StatelessWidget {
  const ImagesListView({
    Key? key,
    required this.product,
  }) : super(key: key);

  final Product product;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: product.images.length + 1,
        itemBuilder: (context, index) {
          if (index == product.images.length) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 300.h,
                width: 600.w,
                decoration: BoxDecoration(
                    color: AppColors.title,
                    borderRadius: BorderRadius.circular(30.r)),
                child: Center(
                  child: Icon(
                    Icons.add_a_photo_rounded,
                    color: Colors.white,
                    size: 100.r,
                  ),
                ),
              ),
            );
          }
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 300.h,
              width: 600.w,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                  color: HexColor(product.imageColour),
                  borderRadius: BorderRadius.circular(30.r)),
              child: index == 0
                  ? Center(
                      child: CachedNetworkImage(
                        imageUrl: product.images[index],
                        width: 450.w,
                        fit: BoxFit.fitWidth,
                      ),
                    )
                  : CachedNetworkImage(
                      imageUrl: product.images[index],
                      fit: BoxFit.fitWidth,
                    ),
            ),
          );
        });
  }
}
