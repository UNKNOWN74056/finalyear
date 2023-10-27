import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class utils {
  //this is flushbar
  // static void Show_Flushbar_Error_Message(
  //     String message, BuildContext context) {
  //   showFlushbar(
  //       context: context,
  //       flushbar: Flushbar(
  //         message: message,
  //         title: "Error",
  //         titleColor: Colors.white,
  //         icon: const Icon(Icons.error),
  //         duration: const Duration(seconds: 3),
  //         flushbarPosition: FlushbarPosition.BOTTOM,
  //         messageColor: Colors.white,
  //         backgroundColor: Colors.red,
  //       )..show(context));
  // }
  //////////////////////////////////

  // Show a SnackBar message
  static void showSnackbarMessage(
      String message, Color color, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: color,
        content: Text(message),
        duration: const Duration(seconds: 3),
      ),
    );
  }

  //////////////////////////////////////
  static void flutter_toast(String msg, Color color) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: color,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
