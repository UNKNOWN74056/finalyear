import 'package:flutter/material.dart';

class reusebletextfield extends StatelessWidget {
  final String labelText;
  final Icon icon;
  final validator;
  final autoValidateMode;
  final suffixIcon;
  final maxline;
  final maxlength;
  final keyboard;

  TextEditingController controller;
  reusebletextfield({
    this.keyboard,
    required this.labelText,
    required this.icon,
    required this.controller,
    required this.validator,
    required this.autoValidateMode,
    this.maxline,
    this.suffixIcon,
    this.maxlength,
    Key? key,
  }) : super(key: key);
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
      textAlignVertical: TextAlignVertical.center,
      decoration: InputDecoration(
        filled: true,
        isDense: true,
        contentPadding: const EdgeInsets.symmetric(vertical: 10),
        prefixIcon: icon,
        labelText: labelText,
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
