import 'dart:io';
import 'dart:typed_data';
import 'package:crypto/crypto.dart';

import 'package:collectar_admin/categories/categories_model.dart';
import 'package:collectar_admin/firebase/cloudstorage.dart';
import 'package:collectar_admin/firebase/firestore_db.dart';
import 'package:collectar_admin/theme/appcolors.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:path/path.dart' as p;

import '../products/product_model.dart';
import '../theme/fonts.dart';

class NewProductController extends GetxController {
  RxList<File> images = <File>[].obs;
  Rx<File> model = File("").obs;
  RxBool isModelUploaded = false.obs;
  RxBool isImageUploaded = false.obs;
  RxBool isDiscount = false.obs;
  RxInt verifyValue = 0.obs;
  RxBool isValid = false.obs;
  final categories = Categories();
  RxList values = [].obs;
  RxList categoryList = [].obs;

  TextEditingController productName = TextEditingController();
  TextEditingController productDesc = TextEditingController();
  TextEditingController productDetails = TextEditingController();
  TextEditingController productPrice = TextEditingController();
  TextEditingController productDiscount = TextEditingController();
  TextEditingController productLength = TextEditingController();
  TextEditingController productWidth = TextEditingController();
  TextEditingController productHeight = TextEditingController();
  TextEditingController productWeight = TextEditingController();
  TextEditingController productMaterials = TextEditingController();

  //
  Rx<Color> pickerColor = AppColors.lighten(AppColors.secondary, 0.5).obs;
  Rx<Color> submitColorButton = AppColors.lighten(AppColors.secondary, 0.4).obs;
  RxBool isColorChanged = false.obs;

  void changeColor(Color color) {
    pickerColor(color);
    isColorChanged(true);
  }

  void switchDiscount(bool value) {
    isDiscount(value);
    print(isDiscount);
  }

  tapToUploadImage(List<String> extension) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: extension,
    );

    if (result != null && images.length <= 4) {
      images.add(File(result.files.first.path.toString()));
      isImageUploaded(true);
      print(images.length);
      update();
    } else {
      // User canceled the picker
    }
  }

  tapToUploadModel(List<String> extension) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: extension,
    );

    if (result != null) {
      model(File(result.files.first.path.toString()));
      isModelUploaded(true);
      update();
    } else {}
  }

  uploadImageToFireStorage(File image, int value) async {
    String imgName = productName.text.toLowerCase().replaceAll(" ", "");

    final extensionString = p.extension(image.toString().replaceAll("'", ""));

    final cs = CloudStorage();

    String url = await cs.uploadFile(
        image, imgName, imgName + value.toString(), extensionString);

    return url;
  }

  uploadModelToFireStorage(File model) async {
    String fileName = productName.text.toLowerCase().replaceAll(" ", "");
    final extensionString = p.extension(model.toString().replaceAll("'", ""));

    print(fileName + "/" + fileName + extensionString);

    String url = "";

    final cs = CloudStorage();
    url = await cs.uploadFile(model, fileName, fileName, extensionString);

    return url;
  }

  RxBool isError = false.obs;

  String? errorText(String value, String title) {
    if (value.isEmpty && isError.isTrue) {
      return "$title is empty";
    } else {
      return null;
    }
  }

  void validations() async {
    if (productName.text.isNotEmpty &
        productDetails.text.isNotEmpty &
        productDesc.text.isNotEmpty &
        productPrice.text.isNotEmpty &
        productMaterials.text.isNotEmpty &
        images.isNotEmpty &
        values.isNotEmpty &
        model.string.isNotEmpty &
        productLength.text.isNotEmpty &
        productWidth.text.isNotEmpty &
        productHeight.text.isNotEmpty &
        productWeight.text.isNotEmpty) {
      isError(false);
      isValid(true);
    } else {
      isValid(false);
      isError(true);
    }
  }

  onSubmit() {
    validations();
    if (isValid.isTrue) {
      uploadToFirebase();
    } else {
      isError(true);
    }
  }

  uploadToFirebase() async {
    verifyValue(1);
    var materialArray = productMaterials.text.split(',');

    List imageURL = [];
    int i = 0;
    for (var element in images) {
      imageURL.add(await uploadImageToFireStorage(element, i));
      i++;
    }
    String modelURL = await uploadModelToFireStorage(model.value);

    String hash = sha256.convert(productName.text.codeUnits).toString();
    String id = hash.substring(0, 8);

    Product product = Product(
        id: "DI-${id.toUpperCase()}",
        name: productName.text.trim(),
        description: productDesc.text.trim(),
        details: productDetails.text.trim(),
        materials: materialArray,
        price: double.parse(productPrice.text.trim()),
        stock: 21,
        images: imageURL,
        imageColour: pickerColor.value.value.toRadixString(16),
        dateAdded: DateTime.now(),
        category: values.value,
        modelAR: modelURL,
        measurements: [
          double.parse(productLength.text.trim()),
          double.parse(productWidth.text.trim()),
          double.parse(productHeight.text.trim()),
          double.parse(productWeight.text.trim())
        ]);
    FirestoreDB.addProduct(product);
    verifyValue(2);
    Future.delayed(Duration(seconds: 1), () {
      Get.defaultDialog(
        title: "Completed",
        middleText: 'Changes have been saved',
      );
      verifyValue(0);
    });
  }

  Widget uploadButtonInfo() {
    switch (verifyValue.value) {
      case 1:
        {
          return Lottie.asset('assets/lottie/loading.json',
              width: 200.r, height: 200.r);
        }

      case 2:
        {
          return Lottie.asset('assets/lottie/success.json',
              width: 200.r, height: 200.r);
        }

      default:
        {
          //statements;
          return Text("Add Product",
              style: MediumHeaderStyle(color: Colors.white));
        }
    }
  }
}
