import 'package:collectar_admin/orders/order/order_controller.dart';
import 'package:get/get.dart';

class OrderBinding implements Bindings {
  @override
  void dependencies() {
    Get.put<OrderController>(OrderController());
  }
}
