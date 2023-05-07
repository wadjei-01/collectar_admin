import 'package:collectar_admin/mainscreen/mainscreen_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';

class SideMenuController extends GetxController {
  List tabs = ["Products", "Orders"];

  List<IoniconsData> icons = [
    Ionicons.bag_handle,
    Ionicons.cart,
  ];
  RxInt selectedIndex = 0.obs;
  onTap(int index) {
    selectedIndex.value = index;
    update();
  }
}
