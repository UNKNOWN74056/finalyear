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
      return "Please enter Email";
    } else if (!value.contains("@gmail.com") && !value.contains("@yahoo.com")) {
      return "Please enter correct email";
    }
    return null;
  }

  String? validPassword(String value) {
    if (value.isEmpty) {
      return "Please enter Password";
    } else if (value.length < 6) {
      return "Password length should be 6";
    }
    return null;
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
