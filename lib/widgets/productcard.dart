import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../products/product_model.dart';
import '../theme/appcolors.dart';

class ProductCard extends StatelessWidget {
  ProductCard(
      {Key? key,
      required this.storedProducts,
      required this.onPressed,
      this.size})
      : super(key: key);

  Product storedProducts;
  final void Function() onPressed;
  Size? size;

  @override
  Widget build(BuildContext context) {
    Color color = Colors.white;
    Color textColor =
        color.computeLuminance() < 0.6 ? Colors.black : Colors.white;

    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: size?.width ?? 400.w,
        height: size?.height ?? 500.h,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30.r),
            color: HexColor(storedProducts.imageColour),
            image: DecorationImage(
                image: AssetImage('assets/images/gridbg.png'),
                fit: BoxFit.fill,
                opacity: 0.3)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 70.h,
            ),
            TweenAnimationBuilder<double>(
                tween: Tween<double>(begin: 0.0, end: 1.0),
                curve: Curves.easeInOut,
                duration: const Duration(seconds: 1),
                builder: ((context, double opacity, child) {
                  return Opacity(
                    opacity: opacity,
                    child: Center(
                      child: CachedNetworkImage(
                        imageUrl: storedProducts.images[0],
                        height: 230.h,
                      ),
                    ),
                  );
                })),
            SizedBox(
              height: 60.h,
            ),
            Padding(
              padding: EdgeInsets.only(left: 50.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    storedProducts.name,
                    maxLines: 1,
                    style: TextStyle(
                        fontFamily: 'Gotham Black',
                        fontSize: 30.sp,
                        fontWeight: FontWeight.w700,
                        color: textColor,
                        overflow: TextOverflow.ellipsis),
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  Text(
                    '₵ ${storedProducts.price.toStringAsFixed(2)}',
                    style: TextStyle(
                        fontFamily: 'Montserrat Black',
                        fontSize: 13,
                        color: textColor),
                  ),
                  SizedBox(
                    height: 10.h,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
