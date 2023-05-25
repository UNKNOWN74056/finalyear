import 'dart:async';
import 'package:finalyear/functions/functions.dart';
import 'package:finalyear/pages/loginpage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class splashservice {
  void islogin(BuildContext context) {
    final auth = FirebaseAuth.instance;
    final user = auth.currentUser;
    if (user != null) {
      functions.loginischeck();
    } else {
      Timer(
          const Duration(seconds: 2),
          () => Navigator.push(context,
              MaterialPageRoute(builder: ((context) => const loginpage()))));
    }
  }
}
