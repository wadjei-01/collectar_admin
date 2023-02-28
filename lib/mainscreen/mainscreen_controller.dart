import 'package:collectar_admin/widgets/side_menu_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../homepage/homepage.dart';
import '../item/item_page.dart';
import '../orders/orderspage.dart';
import '../products/products_page.dart';

class MainScreenController extends GetxController {
  final controller = Get.find<SideMenuController>();
  RxBool pageControl = false.obs;
  late dynamic page;

  onCardPressed(Widget widget) {
    pageControl.value = !pageControl.value;
    update();
    print(pageControl);
    page = widget;

    return widget;
  }

  onTap() {
    switch (controller.selectedIndex.value) {
      case 0:
        {
          return HomePage();
        }
      case 1:
        {
          return ProductPage();
        }
      case 2:
        {
          return OrdersPage();
        }
      case 3:
        {
          return HomePage();
        }
      case 4:
        {
          return HomePage();
        }
      case 5:
        {
          return HomePage();
        }
    }
  }
}
