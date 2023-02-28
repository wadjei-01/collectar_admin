import 'package:collectar_admin/mainscreen/mainscreen_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

class SideMenuController extends GetxController {
  List tabs = ["Home", "Products", "Orders", "Customer", "Help", "Settings"];

  List<IoniconsData> icons = [
    Ionicons.home,
    Ionicons.bag_handle,
    Ionicons.cart,
    Ionicons.person,
    Ionicons.help_buoy,
    Ionicons.settings
  ];
  RxInt selectedIndex = 0.obs;
  OnTap(int index) {
    selectedIndex.value = index;
    update();
  }
}
