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
      return "Please enter a full name";
    } else if (!_isTextOnly(value)) {
      return "Please enter a valid name with only letters";
    }
    return null;
  }

  bool _isTextOnly(String value) {
    // Use a regular expression to match only letters (uppercase and lowercase) and spaces
    RegExp regex = RegExp(r'^[a-zA-Z\s]+$');
    return regex.hasMatch(value);
  }

  String? validcity(String value) {
    if (value.isEmpty) {
      return "Please enter your city name.";
    } else if (!_isTextOnly(value)) {
      return "Please enter a valid name with only letters";
    }
    return null;
  }

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

  String? validconfirmPassword(String confirmPassword, String password) {
    if (confirmPassword.isEmpty) {
      return "Please enter the confirm password";
    } else if (confirmPassword != password) {
      return "Confirm password does not match the password";
    } else if (confirmPassword.length < 6) {
      return "Confirm password length should be at least 6";
    } else if (!_containsCapitalLetter(confirmPassword)) {
      return "Confirm password must contain at least one capital letter";
    }
    return null;
  }

  bool _containsCapitalLetter(String value) {
    // Use a regular expression to check for at least one capital letter
    RegExp regex = RegExp(r'[A-Z]');
    return regex.hasMatch(value);
  }

  String? validphonenumber(String value) {
    String regexPattern = r'^(?:\+92)?[0-9]{9}$';
    var regExp = RegExp(regexPattern);

    if (value.isEmpty) {
      return "Please enter a phone number";
    } else if (!value.startsWith("+92")) {
      return "Please enter the country code +92";
    } else if (!regExp.hasMatch(value)) {
      return "Please enter a valid mobile number";
    }

    return null;
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
