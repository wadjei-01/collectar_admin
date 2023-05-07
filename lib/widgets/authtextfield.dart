import 'package:flutter/material.dart';

import '../theme/appcolors.dart';

class AuthTextField extends StatelessWidget {
  const AuthTextField({
    Key? key,
    required this.textHint,
    required this.textController,
    required this.isObscured,
    this.inputType = TextInputType.text,
    required this.isValid,
    this.autofillHint,
    this.validator,
    this.prefixIcon,
  }) : super(key: key);

  final String textHint;
  final TextEditingController textController;
  final bool isObscured;
  final TextInputType inputType;
  final bool isValid;
  final String? autofillHint;
  final String? Function(String?)? validator;
  final Icon? prefixIcon;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: inputType,
      obscureText: isObscured,
      cursorColor: AppColors.primary,
      controller: textController,
      autofillHints: autofillHint != null ? [autofillHint!] : null,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: validator,
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        prefixIconColor: AppColors.secondary,
        focusColor: AppColors.primary,
        focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: AppColors.primary,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(10)),
        errorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.red,
              width: 2,
            ),
            borderRadius: BorderRadius.circular(10)),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: isValid == false
                ? Colors.red
                : AppColors.darken(AppColors.background),
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: isValid == false ? Colors.red : AppColors.primary,
            width: 2,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        hintText: textHint,
        contentPadding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        border: InputBorder.none,
      ),
    );
  }
}
