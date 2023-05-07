import 'package:collectar_admin/login/login_controller.dart';
import 'package:collectar_admin/theme/appcolors.dart';
import 'package:collectar_admin/theme/fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../widgets/widgets.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});
  final loginController = Get.put(LoginController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                CoverImage(
                  loginController: loginController,
                ),
                Login(
                  loginController: loginController,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CoverImage extends StatelessWidget {
  CoverImage({super.key, required this.loginController});
  LoginController loginController;
  @override
  Widget build(BuildContext context) {
    return Container(
      // clipBehavior: Clip.antiAlias,
      color: AppColors.secondary,
      height: 1.sh,
      width: 0.55.sw,

      child: Image.asset(
        'assets/images/loop0001.png',
        fit: BoxFit.fill,
      ),
    );
  }
}

class Login extends StatelessWidget {
  Login({super.key, required this.loginController});
  LoginController loginController;
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      width: 0.45.sw,
      color: AppColors.background,
      child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 0.07.sw),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SvgPicture.asset(
                    'assets/images/collectAR (logo).svg',
                    height: 130.r,
                    width: 130.r,
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "collectAR",
                        style: BoldHeaderstextStyle(
                            color: AppColors.secondary, fontSize: 35.sp),
                      ),
                      Text(
                        "Admin",
                        style: RegularHeaderStyle(
                            color: AppColors.lighten(AppColors.secondary, 0.5),
                            fontSize: 30.sp),
                      ),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(
              height: 30.h,
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 0.07.sw),
                child: Text(
                  'Log in to your Account.',
                  style: BoldHeaderstextStyle(
                      color: AppColors.secondary, fontSize: 45.sp),
                ),
              ),
            ),
            SizedBox(
              height: 50.h,
            ),
            SizedBox(
              width: 0.3.sw,
              child: AuthTextField(
                isObscured: false,
                textHint: 'Email',
                textController: loginController.emailController,
                inputType: TextInputType.emailAddress,
                isValid: true,
                autofillHint: AutofillHints.email,
                prefixIcon: Icon(
                  Ionicons.mail_outline,
                  color: AppColors.darken(AppColors.background, 0.6),
                ),
                validator: loginController.emailValidator,
              ),
            ),
            SizedBox(
              height: 50.h,
            ),
            SizedBox(
              width: 0.3.sw,
              child: AuthTextField(
                isObscured: true,
                textHint: 'Password',
                textController: loginController.passwordController,
                isValid: true,
                autofillHint: AutofillHints.password,
                prefixIcon: Icon(
                  Ionicons.lock_closed_outline,
                  color: AppColors.darken(AppColors.background, 0.6),
                ),
                validator: loginController.passwordValidator,
              ),
            ),
            Obx(() {
              return Container(
                alignment: Alignment.center,
                margin: EdgeInsets.all(10.r),
                height: loginController.errorCode.isEmpty ? 50.h : 85.h,
                width: 750.w,
                child: loginController.errorCode.isEmpty
                    ? const SizedBox()
                    : Text(
                        loginController.errorCode.string,
                        style: MediumHeaderStyle(
                            color: Colors.red, fontSize: 25.sp),
                      ),
              );
            }),
            Button(
              width: 0.3.sw,
              height: 120.h,
              widget: Text(
                'Login',
                style: MediumHeaderStyle(
                  color: AppColors.secondary,
                ),
              ),
              onTap: () {
                showDialog(
                    context: context,
                    barrierDismissible: false,
                    barrierColor: AppColors.background,
                    builder: (context) {
                      return Center(
                          child: CircularProgressIndicator(
                        color: AppColors.primary,
                      ));
                    });
                loginController.onTap();
              },
            ),
          ]),
    );
  }
}
