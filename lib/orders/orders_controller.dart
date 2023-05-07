import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../mainscreen/mainscreen_controller.dart';
import '../theme/appcolors.dart';
import 'orders_model.dart';

class OrdersController extends GetxController {
  RxBool isDescending = true.obs;
  final mainScreenController = Get.find<MainScreenController>();
  RxInt selectedIndex = 0.obs;
  List orderByList = ['Date', 'Status', 'Customer'];
  List orderBySelection = ['date', 'status', 'name'];

  void switchOrder() {
    isDescending(!isDescending.value);
    update();
  }
}
