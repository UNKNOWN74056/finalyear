import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class TournamentsRegistration extends GetxController {
  var teamname = "".obs;
  var captainname = "".obs;
  var address = "".obs;
  var city = "".obs;
  var email = "".obs;
  bool isformValidated = false;

//controllers
  late TextEditingController teamnamecontroller,
      captainnamecontroller,
      addresscontroller,
      citycontroller,
      emailcontroller;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    teamnamecontroller = TextEditingController();
    captainnamecontroller = TextEditingController();
    addresscontroller = TextEditingController();
    citycontroller = TextEditingController();
    emailcontroller = TextEditingController();
  }

  // form key for validaiton
  final regkeyForm = GlobalKey<FormState>();

  //these are the function for validation
  String? validEmail(String value) {
    if (value.isEmpty) {
      return "Please enter Email";
    } else if (!value.contains("@gmail.com") && !value.contains("@yahoo.com")) {
      return "Please enter correct email";
    }
    return null;
  }

  String? validteamname(String value) {
    if (value.isEmpty) {
      return "Please enter your message";
    }
    return null;
  }

  String? validcaptainname(String value) {
    if (value.isEmpty) {
      return "Please enter your message";
    }
    return null;
  }

  String? validaddress(String value) {
    if (value.isEmpty) {
      return "Please enter your message";
    }
    return null;
  }

  String? validcitye(String value) {
    if (value.isEmpty) {
      return "Please enter your message";
    }
    return null;
  }

  checkregisteration() {
    if (regkeyForm.currentState!.validate()) {
      final isValid = regkeyForm.currentState!.validate();

      if (!isValid) {
        return null;
      }
      regkeyForm.currentState!.save();
      email.value = emailcontroller.value.text;
      teamname.value = teamnamecontroller.value.text;
      captainname.value = captainnamecontroller.value.text;
      address.value = addresscontroller.value.text;
      city.value = citycontroller.value.text;
      isformValidated = true;
      // User those values to send our auth request ...
    }
  }
}
