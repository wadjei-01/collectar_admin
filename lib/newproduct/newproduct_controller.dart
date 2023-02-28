import 'dart:io';
import 'dart:typed_data';

import 'package:collectar_admin/categories/categories_model.dart';
import 'package:collectar_admin/firebase/cloudstorage.dart';
import 'package:collectar_admin/firebase/firestore_db.dart';
import 'package:collectar_admin/theme/appcolors.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_core/firebase_core.dart' as firebase_core;
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as p;

import '../products/product_model.dart';

class NewProductController extends GetxController {
  RxList<File> images = <File>[].obs;
  late Rx<File> model = File("").obs;
  RxBool isModelUploaded = false.obs;
  RxBool isImageUploaded = false.obs;
  RxBool isDiscount = false.obs;
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

  uploadModelToFireStorage(File model) async {
    String fileName = productName.text.toLowerCase().replaceAll(" ", "");
    final fireStorage = FirestoreDB.firestorage;
    final extension = p.extension(model.toString().replaceAll("'", ""));

    print("models/" + fileName + "/" + fileName + extension);

    String url = "";
    String contentType = "model/gltf-binary";
    final cs = CloudStorage();
    url = await cs.uploadFile(
        model, "models", fileName, fileName + extension, contentType);

    return url;
  }

  uploadImageToFireStorage(File image, int value) async {
    String imgName = productName.text.toLowerCase().replaceAll(" ", "");

    final extensionString = p.extension(image.toString().replaceAll("'", ""));

    String contentType = "";

    if (extensionString == ".jpg" || extensionString == ".jpeg") {
      contentType = "image/jpeg";
    } else {
      contentType = "image/png";
    }

    print(extensionString);
    final cs = CloudStorage();
    String val = await cs.uploadFile(image, "img", imgName,
        imgName + value.toString() + extensionString, contentType);

    return val;
  }

  uploadToFirebase() async {
    var materialArray = productMaterials.text.split(',');

    List imageURL = [];
    int i = 0;
    for (var element in images) {
      imageURL.add(await uploadImageToFireStorage(element, i));
      i++;
    }
    String modelURL = await uploadModelToFireStorage(model.value);

    Product product = Product(
        id: "DI-1001",
        name: productName.text,
        description: productDesc.text,
        details: productDetails.text,
        materials: materialArray,
        price: double.parse(productPrice.text),
        stock: 21,
        images: imageURL,
        imageColour: pickerColor.value.value.toRadixString(16),
        dateAdded: DateTime.now(),
        category: values.value,
        modelAR: modelURL,
        measurements: [
          productLength.text,
          productWidth.text,
          productHeight.text,
          productWeight.text
        ]);
    FirestoreDB.addProduct(product);
  }
}
