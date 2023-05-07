import 'package:collectar_admin/login/auth.dart';
import 'package:collectar_admin/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gif/flutter_gif.dart';
import 'package:get/get.dart';

import '../theme/appcolors.dart';

class LoginController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  late FlutterGifController gifController;
  final errorCode = Rx<String>('');

  String? emailValidator(String? formEmail) {
    if (formEmail == null || formEmail.isEmpty) {
      return 'Email address is empty';
    }

    String format = r'\w+@\w+\.\w+';
    RegExp regExp = RegExp(format);

    if (!regExp.hasMatch(formEmail)) {
      return 'Invalid Email format';
    }

    return null;
  }

  String? passwordValidator(String? password) {
    if (password == null || password.isEmpty) {
      return 'Password is empty';
    }

    if (password.length < 8) {
      return 'Password should be at least 8 characters';
    }

    return null;
  }

  void onTap() async {
    Auth auth = Auth();
    // final appcontroller = Get.find<MyAppController>();

    errorCode(await auth.signInWithEmailAndPassword(
        emailController.value.text.trim(), passwordController.value.text));

    if (errorCode.value == '') {
      emailController.clear();
      passwordController.clear();
    }
    errorCode('');
  }
}
