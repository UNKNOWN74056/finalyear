import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TransFerForm extends GetxController {
  var eamil = "".obs;
  var message = "".obs;

  bool isformValidated = false;

  //controllers
  late TextEditingController emailController, messagecontroller;

  get clublist => null;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    emailController = TextEditingController();
    messagecontroller = TextEditingController();
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

  String? validmessage(String value) {
    if (value.isEmpty) {
      return "Please enter your message";
    }
  }

  checktransfer() {
    if (keyForm.currentState!.validate()) {
      final isValid = keyForm.currentState!.validate();

      if (!isValid) {
        return null;
      }
      keyForm.currentState!.save();
      eamil.value = emailController.value.text;
      message.value = messagecontroller.value.text;
      isformValidated = true;
      // User those values to send our auth request ...
    }
  }
}
