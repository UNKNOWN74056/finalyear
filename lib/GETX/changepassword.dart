import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class changepassword extends GetxController {
  var password = "".obs;
  bool isformValidated = false;

  // contorller for the fieled
  late TextEditingController passwordController;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    passwordController = TextEditingController();
  }

// form key for validaiton
  final keyForm = GlobalKey<FormState>();
//these are the function for validation
  String? validPassword(String value) {
    if (value.isEmpty) {
      return "Please enter a password";
    } else if (value.length < 6) {
      return "Password length should be at least 6";
    } else if (!_containsCapitalLetter(value)) {
      return "Password must contain at least one capital letter";
    }
    return null;
  }

  bool _containsCapitalLetter(String value) {
    // Use a regular expression to check for at least one capital letter
    RegExp regex = RegExp(r'[A-Z]');
    return regex.hasMatch(value);
  }

  void checkPassword() {
    if (keyForm.currentState!.validate()) {
      final isValid = keyForm.currentState!.validate();

      if (!isValid) {
        return;
      }
      keyForm.currentState!.save();
      password.value = passwordController.value.text;
      isformValidated = true;
      // Use the password value for further processing
    }
  }
}
