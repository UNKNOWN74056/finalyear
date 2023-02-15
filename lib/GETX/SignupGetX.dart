import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class sighnupcontroller extends GetxController {
  var fullname = "".obs;
  var city = " ".obs;
  var email = "".obs;
  var password = "".obs;
  var confirmpasswrod = "".obs;
  var phonenumber = "".obs;
  bool isformValidated = false;

//controller for the fields
  late TextEditingController fullnamecontroller,
      citycontroller,
      emailController,
      passwordcontroller,
      confirmpasswordcontroller,
      phonenumbercontroller;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fullnamecontroller = TextEditingController();
    citycontroller = TextEditingController();
    emailController = TextEditingController();
    passwordcontroller = TextEditingController();
    confirmpasswordcontroller = TextEditingController();
    phonenumbercontroller = TextEditingController();
  }

  // form key for validation
 GlobalKey<FormState> signupkeyForm = GlobalKey<FormState>();
//these are the function for validation
  String? validfullname(String value) {
    if (value.isEmpty) {
      return "Please enter fulll name";
    }
  }

  

  String? validcity(String value) {
    if (value.isEmpty) {
      return "Please enter city";
    }
  }

  String? validEmail(String value) {
    if (value.isEmpty) {
      return "Please enter Email";
    } else if (!value.contains("@gmail.com") && !value.contains("@yahoo.com")) {
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

  String? validconfirmPassword(String value) {
    if (value.isEmpty) {
      return "Please enter Password correctly";
    }
  }

  String? validphonenumber(String value) {
    if (value.isEmpty) {
      return "Please enter your phone number";
    } else if (!value.contains("+")) {
      return "Enter your phone number correctly ";
    }
  }

  checksignup() {
    if (signupkeyForm.currentState!.validate()) {
      final isValid = signupkeyForm.currentState!.validate();

      if (!isValid) {
        return null;
      }
     signupkeyForm.currentState!.save();
      fullname.value = fullnamecontroller.value.text;
      city.value = citycontroller.value.text;
      email.value = emailController.value.text;
      password.value = passwordcontroller.value.text;
      confirmpasswrod.value = confirmpasswordcontroller.value.text;
      phonenumber.value = phonenumbercontroller.value.text;
      isformValidated = true;
      // User those values to send our auth request ...
    }
  }
}
