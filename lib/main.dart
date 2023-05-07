import 'dart:io';
import 'dart:convert';
import 'package:collectar_admin/login/user_model.dart' as userModel;

import 'package:collectar_admin/firebase/fire_options.dart';
import 'package:collectar_admin/firebase/firebase_options.dart';
import 'package:collectar_admin/login/login_page.dart';
import 'package:collectar_admin/login/user_model.dart';
import 'package:collectar_admin/mainscreen/mainscreen_controller.dart';
import 'package:collectar_admin/orders/order/order_binding.dart';
import 'package:collectar_admin/orders/order/order_page.dart';
import 'package:collectar_admin/returnscreen.dart';
import 'package:collectar_admin/theme/theme.dart';
import 'package:collectar_admin/widgets/widgets.dart';
import 'package:desktop_window/desktop_window.dart';
import 'package:firebase_dart/firebase_dart.dart' as fbdart;
import 'package:firedart/firedart.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:hive_flutter/hive_flutter.dart';

import 'database/boxes.dart';
import 'mainscreen/mainscreen.dart';
import 'widgets/side_menu_controller.dart';

var app;
bool isAdmin = false;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Injection.init();
  fbdart.FirebaseDart.setup();

  app = await fbdart.Firebase.initializeApp(
      options: fbdart.FirebaseOptions.fromMap(FireOptions.toJson()));
  await Hive.initFlutter();

  Hive.registerAdapter(UserAdapter());
  await Hive.openBox<userModel.User>('user');

  await Firestore.initialize(DefaultFirebaseOptions.web.projectId);

  await DesktopWindow.setMinWindowSize(const Size(1920, 1080));

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(2560, 1440),
      minTextAdapt: true,
      builder: (context, child) => GetMaterialApp(
        theme: MyTheme.lightV2,
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        getPages: [
          GetPage(
            name: '/',
            page: () => GetBuilder<MyAppController>(builder: (controller) {
              return StreamBuilder<fbdart.User?>(
                  stream: fbdart.FirebaseAuth.instance.authStateChanges(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return controller.isAdmin.isTrue
                          ? const Window()
                          : const ReturnScreen();
                    } else {
                      return LoginPage();
                    }
                  });
            }),
          ),
        ],
      ),
    );
  }
}

class MyAppController extends GetxController {
  RxBool isAdmin = false.obs;
}

class Window extends StatelessWidget {
  const Window({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Expanded(
          child: Row(
            children: [
              SideMenu(),
              MainScreen(),
            ],
          ),
        ),
      ]),
    );
  }
}

class Injection {
  static Future<void> init() async {
    Get.put(MyAppController());
    Get.put(SideMenuController());
    Get.put(MainScreenController());
  }
}
