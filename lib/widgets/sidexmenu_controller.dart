import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:sidebarx/sidebarx.dart';

import '../homepage/homepage.dart';
import '../mainscreen/mainscreen_controller.dart';
import '../orders/orderspage.dart';
import '../products/products_page.dart';

class SideMenuController extends GetxController {
  final SidebarXController sideMenuController =
      SidebarXController(selectedIndex: 0, extended: true);
  final mainScreenController = Get.find<MainScreenController>();

  List<String> tabs = [
    "Home",
    "Products",
    "Orders",
    "Customer",
    "Help",
    "Settings"
  ];

  List<IoniconsData> icons = [
    Ionicons.home,
    Ionicons.bag_handle,
    Ionicons.cart,
    Ionicons.person,
    Ionicons.help_buoy,
    Ionicons.settings
  ];

  List views = [
    HomePage(),
    ProductPage(),
    OrdersPage(),
    HomePage(),
    HomePage(),
    HomePage()
  ];
}
