// import 'package:flutter/cupertino.dart';
// import 'package:get/get.dart';

// class Controller extends GetxController {
//   var email = TextEditingController().obs;
//   var password = TextEditingController().obs;

//   final _keyForm = GlobalKey<FormState>();

//   validEmail(String value) {
//     if (value.isEmpty) {
//       return "Please enter Email";
//     }
//   }

//   validPassword(String value) {
//     if (value.isEmpty) {
//       return "Please enter Password";
//     }
//   }

//   checkLogin() {
//     if (_keyForm.currentState!.validate()) {
//       final isValid = _keyForm.currentState!.validate();
//       Get.focusScope!.unfocus();

//       if (isValid) {
//         _keyForm.currentState!.save();
//         print(userEmail);
//         print(userName);
//         print(userPassword);

//         // User those values to send our auth request ...
//       }
//     }
//   }
// }
