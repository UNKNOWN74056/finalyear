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
  final keyForm = GlobalKey<FormState>();

//these are the function for validation
  String? validEmail(String value) {
    if (value.isEmpty) {
      return "Please enter Email";
    } else if (!value.contains("@gmail.com") && !value.contains("@yahoo.com")) {
      return "Please enter correct email";
    }
  }

  checkemailverify() {
    if (keyForm.currentState!.validate()) {
      final isValid = keyForm.currentState!.validate();

      if (!isValid) {
        return null;
      }
      keyForm.currentState!.save();
      email.value = emailverify.value.text;
      isformValidated = true;
      // User those values to send our auth request ...
    }
  }
}
