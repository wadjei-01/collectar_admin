import 'package:collectar_admin/database/boxes.dart';
import 'package:collectar_admin/main.dart';
import 'package:get/get.dart';

import '../theme/appcolors.dart';
import 'user_model.dart' as userModel;

import 'package:firebase_dart/firebase_dart.dart';
import 'package:firedart/firedart.dart' as firedart;
import 'package:flutter/material.dart';

class Auth {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future<void> registerWithEmailAndPassword(
      String email, String password) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      addUserDetails(email);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    }
  }

  Future<String?> signInWithEmailAndPassword(
      String email, String password) async {
    String? errorMessage;
    final controller = Get.find<MyAppController>();
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      var firebaseUser = FirebaseAuth.instance.currentUser;
      late userModel.User user;
      await firedart.Firestore.instance
          .collection('users')
          .document(firebaseUser!.uid)
          .get()
          .then((value) {
        if (value['userRole'] == 'Admin') {
          controller.isAdmin(true);
        } else {
          controller.isAdmin(false);
        }
        controller.update();

        user = userModel.User(
            email: value['email'],
            firstName: value['firstName'],
            lastName: value['lastName'],
            date: value['date'],
            phoneNo: value['phoneNo'],
            location: value['location'],
            userRole: value['userRole']);
      });
      print('Take note: ${user.firstName}');

      await Boxes.getUser().put('user', user);
    } on FirebaseAuthException catch (e) {
      controller.isAdmin(false);
      if (e.message == 'Given String is empty or null') {
        errorMessage = 'Please enter you credentials';
      } else if (e.message ==
          'There is no user record corresponding to this identifier. The user may have been deleted.') {
        errorMessage = 'User does not exist in our database';
      } else if (e.message ==
          'The password is invalid or the user does not have a password.') {
        errorMessage = 'Password is incorrect. Please try again';
      } else {
        errorMessage = e.message;
      }
    }
    navigator!.pop();
    return errorMessage;
  }

  Future addUserDetails(String email) async {
    var firebaseUser = FirebaseAuth.instance.currentUser;
    //print(firebaseUser!.uid);

    final docUser = firedart.Firestore.instance
        .collection('users')
        .document(firebaseUser!.uid);

    String dateOfBirth = '02 02 1998';

    final user = userModel.User(
        id: docUser.id,
        firstName: 'admin',
        lastName: '',
        email: email,
        phoneNo: '',
        location: '',
        date: '',
        userRole: 'Admin');

    final json = user.toJson();
    Boxes.getUser().put('user', user);
    await docUser.set(json);
  }
}
