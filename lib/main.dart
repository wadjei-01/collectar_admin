import 'package:collectar_admin/firebase/firebase_options.dart';
import 'package:collectar_admin/mainscreen/mainscreen_controller.dart';
import 'package:collectar_admin/theme/theme.dart';
import 'package:collectar_admin/widgets/widgets.dart';
import 'package:desktop_window/desktop_window.dart';
import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_for_all/firebase_for_all.dart';
import 'package:firedart/firedart.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'mainscreen/mainscreen.dart';
import 'widgets/side_menu_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Injection.init();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.web);

  await Firestore.initialize(DefaultFirebaseOptions.web.projectId);

  await DesktopWindow.setMinWindowSize(const Size(1920, 1080));

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(2560, 1440),
      minTextAdapt: true,
      builder: (context, child) => GetMaterialApp(
        theme: MyTheme.lightV2,
        debugShowCheckedModeBanner: false,
        home: const Window(),
      ),
    );
  }
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
    Get.put(SideMenuController());
    Get.put(MainScreenController());
    print('hhhh');
  }
}
