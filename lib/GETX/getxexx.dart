import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  var email = "".obs;
  var password = "".obs;
  var isformValidated = false;

  late TextEditingController emailController, passwordController;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  final keyForm = GlobalKey<FormState>();

  String? validEmail(String value) {
    if (value.isEmpty) {
      return "Please enter Email";
    } else if (!value.contains("@gmail.com")) {
      return "Please enter correct email";
    }
  }

  String? validPassword(String value) {
    if (value.isEmpty) {
      return "Please enter Password";
    } else if (value.length < 6) {
      return "Password length should be 6";
    }
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
}
