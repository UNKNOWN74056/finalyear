import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  var email = "".obs;
  var password = "".obs;
  bool isformValidated = false;

  // contorller for the fieled
  late TextEditingController emailController, passwordController;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

// form key for validaiton
  final keyForm = GlobalKey<FormState>();
//these are the function for validation
  String? validEmail(String value) {
    if (value.isEmpty) {
      return "Please enter an email";
    } else if (!value.contains("@gmail.com") &&
        !value.contains("@yahoo.com") &&
        !value.contains("@cusite.com") &&
        !value.contains("@hotmail.com")) {
      return "Please enter a valid email";
    } else if (value.endsWith("@gmail.com") ||
        value.endsWith("@yahoo.com") ||
        value.endsWith("@cusite.com") ||
        value.endsWith("@hotmail.com")) {
      if (value.startsWith("@")) {
        return "Please enter a valid email with a username";
      }
    }
    return null;
  }

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

  checkLogin() {
    if (keyForm.currentState!.validate()) {
      final isValid = keyForm.currentState!.validate();

      if (!isValid) {
        return null;
      }
      keyForm.currentState!.save();
      email.value = emailController.value.text;
      password.value = passwordController.value.text;
      isformValidated = true;
      // User those values to send our auth request ...
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
