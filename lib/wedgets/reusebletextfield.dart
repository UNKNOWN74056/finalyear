import 'package:flutter/material.dart';

class reusebletextfield extends StatelessWidget {
  final controller;
  final validator;
  final maxline;
  final maxlength;
  final autoValidateMode;
  final keyboard;
  final icon;
  final sufixicon;
  final labelText;
  final obscureText;

  const reusebletextfield({
    super.key,
    required this.controller,
    required this.autoValidateMode,
    required this.keyboard,
    this.maxlength,
    this.maxline = 1,
    required this.validator,
    required this.icon,
    this.sufixicon,
    required this.labelText,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      maxLines: maxline,
      maxLength: maxlength,
      autovalidateMode: autoValidateMode,
      style: const TextStyle(
        color: Colors.black,
      ),
      keyboardType: keyboard,
      obscureText: obscureText,
      textAlignVertical: TextAlignVertical.center,
      decoration: InputDecoration(
        filled: true,
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(vertical: 22),
        prefixIcon: icon,
        labelText: labelText,
        suffixIcon: sufixicon,
        hintStyle: const TextStyle(
          color: Colors.grey,
        ),
        enabledBorder: OutlineInputBorder(
          // borderSide: const BorderSide(
          //   width: 4,
          //   //  color: Colors.lightGreen,
          // ),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      cursorHeight: 23.0,
    );
  }
}
