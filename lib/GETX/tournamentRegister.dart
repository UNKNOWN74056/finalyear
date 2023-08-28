import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class TournamentsRegistration extends GetxController {
  var teamname = "".obs;
  var captainname = "".obs;
  var address = "".obs;
  var city = "".obs;
  var email = "".obs;
  var contact = "".obs;
  var sportevent = "".obs;
  var player1 = "".obs;
  var player2 = "".obs;
  var player3 = "".obs;
  var player4 = "".obs;
  var player5 = "".obs;
  var player6 = "".obs;
  var player7 = "".obs;
  var player8 = "".obs;
  var player9 = "".obs;
  var player10 = "".obs;
  var player11 = "".obs;
  var player12 = "".obs;
  bool isformValidated = false;

//controllers
  late TextEditingController teamnamecontroller,
      captainnamecontroller,
      addresscontroller,
      citycontroller,
      emailcontroller,
      contactcontroller,
      sporteventcontroller,
      player1controller,
      player2controller,
      player3controller,
      player4controller,
      player5controller,
      player6controller,
      player7controller,
      player8controller,
      player9controller,
      player10controller,
      player11controller,
      player12controller;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    teamnamecontroller = TextEditingController();
    captainnamecontroller = TextEditingController();
    addresscontroller = TextEditingController();
    citycontroller = TextEditingController();
    emailcontroller = TextEditingController();
    contactcontroller = TextEditingController();
    sporteventcontroller = TextEditingController();
    player1controller = TextEditingController();
    player2controller = TextEditingController();
    player3controller = TextEditingController();
    player4controller = TextEditingController();
    player5controller = TextEditingController();
    player6controller = TextEditingController();
    player7controller = TextEditingController();
    player8controller = TextEditingController();
    player9controller = TextEditingController();
    player10controller = TextEditingController();
    player11controller = TextEditingController();
    player12controller = TextEditingController();
  }

  // form key for validaiton
  final regkeyForm = GlobalKey<FormState>();

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

  String? validteamname(String value) {
    if (value.isEmpty) {
      return "Please enter a full team name";
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

  String? validcaptainname(String value) {
    if (value.isEmpty) {
      return "Please enter a full captain name";
    } else if (!_isTextOnly(value)) {
      return "Please enter a valid name with only letters";
    }
    return null;
  }

  String? validplayername(String value) {
    if (value.isEmpty) {
      return "Please enter a full player name";
    } else if (!_isTextOnly(value)) {
      return "Please enter a valid name with only letters";
    }
    return null;
  }

  String? validsportname(String value) {
    if (value.isEmpty) {
      return "Please enter a sport event name";
    } else if (!_isTextOnly(value)) {
      return "Please enter a valid name with only letters";
    }
    return null;
  }

  String? validaddress(String value) {
    if (value.isEmpty) {
      return "Please enter full address";
    } else if (!_isTextOnly(value)) {
      return "Please enter a valid name with only letters";
    }
    return null;
  }

  String? validcitye(String value) {
    if (value.isEmpty) {
      return "Please enter city name";
    } else if (!_isTextOnly(value)) {
      return "Please enter a valid name with only letters";
    }
    return null;
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
      contact.value = contactcontroller.value.text;
      sportevent.value = sporteventcontroller.value.text;
      player1.value = player1controller.value.text;
      player2.value = player2controller.value.text;
      player3.value = player3controller.value.text;
      player4.value = player4controller.value.text;
      player5.value = player5controller.value.text;
      player6.value = player6controller.value.text;
      player7.value = player7controller.value.text;
      player8.value = player8controller.value.text;
      player9.value = player9controller.value.text;
      player10.value = player10controller.value.text;
      player11.value = player11controller.value.text;
      player12.value = player12controller.value.text;
      isformValidated = true;
      // User those values to send our auth request ...
    }
  }
}
