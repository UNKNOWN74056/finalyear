import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ForgotPassword extends GetxController {
  var email = "".obs;

  bool isformValidated = false;

  // contorller for the fieled
  late TextEditingController emailverify;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    emailverify = TextEditingController();
  }

  // form key for validaiton
  final forgotkeyForm = GlobalKey<FormState>();

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

  checkemailverify() {
    if (forgotkeyForm.currentState!.validate()) {
      final isValid = forgotkeyForm.currentState!.validate();

      if (!isValid) {
        return null;
      }
      forgotkeyForm.currentState!.save();
      email.value = emailverify.value.text;
      isformValidated = true;
      // User those values to send our auth request ...
    }
  }
}
