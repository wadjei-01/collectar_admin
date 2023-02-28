import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class OrdersController extends GetxController {
  RxBool isOrderClicked = false.obs;

  onTap() {
    isOrderClicked(!isOrderClicked.value);
    print(isOrderClicked.value);
  }
}
