import 'package:flutter/material.dart';

class AppTextFormField extends StatelessWidget {
  final String hintText;
  final TextStyle? inputTextStyle;
  final TextStyle? hintStyle;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool? isObscureText;
  final Function? suffixPressed;
  final InputBorder? focusedBorder;
  final InputBorder? enabledBorder;
  final Color? backgroundColor;
  final TextEditingController? controller;
  final TextInputType type;
  final String? Function(String?) validator;
  final bool readonly;

  final Function(String)? onSubmit;

  const AppTextFormField(
      {super.key,
      required this.hintText,
      this.inputTextStyle,
      this.hintStyle,
      this.isObscureText,
      this.suffixIcon,
      this.focusedBorder,
      this.enabledBorder,
      this.backgroundColor,
      this.prefixIcon,
      this.controller,
      required this.type,
      required this.readonly,
      required this.validator,
      this.suffixPressed,
      this.onSubmit});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: TextStyle(color: Colors.black),
      controller: controller,
      keyboardType: type,
      autofocus:true ,
    
      readOnly: readonly,
      validator: validator,
      obscureText: isObscureText ?? false,
      onFieldSubmitted: onSubmit,
      decoration: InputDecoration(
        // labelText: hintText,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 15, horizontal: 10.0),
        prefixIcon: prefixIcon,
        hintText: hintText,
        hintStyle: hintStyle ?? TextStyle(color: Colors.black),
        suffixIcon: suffixIcon,
        enabledBorder: enabledBorder ??
            OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: const BorderSide(
                  color: Colors.white,
                  width: 1.3,
                )),
        focusedBorder: focusedBorder ??
            OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: const BorderSide(
                  color: Colors.white,
                  width: 1.3,
                )),
      ),
    );
  }
}