import 'package:flutter/material.dart';
import 'package:get/get.dart';

class offerrequestform extends GetxController {
  var offer = " ".obs;

  bool isformValidated = false;

  late TextEditingController amountcontroller;

  @override
  void onInit() {
    amountcontroller = TextEditingController();
    super.onInit();
  }

  // form key for validaiton
  final GlobalKey<FormState> offerkey = GlobalKey<FormState>();

  String? validammount(String? value) {
    if (value == null || value.isEmpty) {
      return "Please enter the amount";
    }
    return null;
  }

  checkoffer() {
    if (offerkey.currentState!.validate()) {
      final isValid = offerkey.currentState!.validate();

      if (!isValid) {
        return null;
      }
      offerkey.currentState!.save();
      offer.value = amountcontroller.value.text;
      isformValidated = true;
      // User those values to send our auth request ...
    }
  }
}
