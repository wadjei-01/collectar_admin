import 'package:collectar_admin/products/product_model.dart';
import 'package:collectar_admin/widgets/texteditor.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ItemController extends GetxController {
  late Product product;
  late String id;
  late TextEditingController productName;
  late TextEditingController productPrice;
  late TextEditingController productDesc;
  late TextEditingController productDet;
  late RxInt productCat;
  RxBool isChanged = false.obs;

  onInitiate(String id, Product product) async {
    this.product = product;
    this.id = id;
    productName = TextEditingController(text: product.name);
    productPrice =
        TextEditingController(text: product.price.toStringAsFixed(2));
    productDesc = TextEditingController(text: product.description);
    productDet = TextEditingController(text: product.details);
    productCat = RxInt(product.category[0]);
  }

  category(dynamic value) async {
    productCat.value = value;
    print(value);
    update();
  }

  isMatched(String text, dynamic value) async {
    if (text != value) {
      isChanged.value = true;
      print(isChanged.value);
      update();
      // setState(() {});
    } else {
      isChanged.value = false;
      print(isChanged.value);
      update();
      // setState(() {});
    }
  }
}
