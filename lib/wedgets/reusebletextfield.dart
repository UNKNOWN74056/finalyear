import 'package:flutter/material.dart';

class reusebletextfield extends StatelessWidget {
  final String labelText;
  final Icon icon;
  final validator;
  final autoValidateMode;
  final suffixIcon;
  final maxline;
  final maxlength;

  TextEditingController controller;
  reusebletextfield({
    required this.labelText,
    required this.icon,
    required this.controller,
    required this.validator,
    required this.autoValidateMode,
    this.maxline,
    this.suffixIcon,
    this.maxlength,
    Key? key, required AutovalidateMode autovalidateMode,
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
      keyboardType: TextInputType.emailAddress,
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
