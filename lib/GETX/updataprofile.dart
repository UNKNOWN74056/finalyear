import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class updateuserprofile extends GetxController {
  var fullname = "".obs;
  var location = "".obs;
  var phone = "".obs;
  var club = "".obs;

  bool isformValidated = false;

  late TextEditingController updatefullnamecontroller,
      updatecitycontroller,
      updatephonecontroller,
      clubupdatecontroller;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    updatefullnamecontroller = TextEditingController();
    updatecitycontroller = TextEditingController();
    updatephonecontroller = TextEditingController();
    clubupdatecontroller = TextEditingController();
  }

  final keyForm = GlobalKey<FormState>();

  String? validfullname(String value) {
    if (value.isEmpty) {
      return "Please enter club name";
    }
    return null;
  }

  String? validlocation(String value) {
    if (value.isEmpty) {
      return "Please enter location";
    }
    return null;
  }

  String? validphone(String value) {
    String regexPattern = r'(^(?:[+0][1-9])?[0-9]{10,12}$)';
    var regExp = RegExp(regexPattern);
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
      club.value = clubupdatecontroller.value.text;

      isformValidated = true;
      // User those values to send our auth request ...
    }
  }
}
