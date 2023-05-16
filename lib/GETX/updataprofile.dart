import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class updateuserprofile extends GetxController {
  var fullname = "".obs;
  var location = "".obs;
  var phone = "".obs;

  bool isformValidated = false;

  late TextEditingController updatefullnamecontroller,
      updatecitycontroller,
      updatephonecontroller;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    updatefullnamecontroller = TextEditingController();
    updatecitycontroller = TextEditingController();
    updatephonecontroller = TextEditingController();
  }

  final keyForm = GlobalKey<FormState>();

  String? validfullname(String value) {
    if (value.isEmpty) {
      return "Please enter club name";
    }
  }

  String? validlocation(String value) {
    if (value.isEmpty) {
      return "Please enter location";
    }
  }

  String? validphone(String value) {
    String regexPattern = r'(^(?:[+0][1-9])?[0-9]{10,12}$)';
    var regExp = new RegExp(regexPattern);
    if (value.isEmpty) {
      return "Please enter phone";
    } else if (!value.contains("+")) {
      return "Please enter correct phone nmuber";
    } else if (!regExp.hasMatch(value)) {
      return "Please enter valid mobile number";
    }
    return null;
  }

  checkbottomsheet() {
    if (keyForm.currentState!.validate()) {
      final isValid = keyForm.currentState!.validate();

      if (!isValid) {
        return null;
      }
      keyForm.currentState!.save();
      fullname.value = updatefullnamecontroller.value.text;
      location.value = updatecitycontroller.value.text;
      phone.value = updatephonecontroller.value.text;

      isformValidated = true;
      // User those values to send our auth request ...
    }
  }
}