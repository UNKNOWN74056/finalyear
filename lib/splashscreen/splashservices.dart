import 'dart:async';
import 'package:finalyear/AS%20A%20PLAYER/internationalsports/dashboard/homedb.dart';
import 'package:finalyear/pages/loginpage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class splashservice {
  void islogin(BuildContext, context) {
    final auth = FirebaseAuth.instance;
    final user = auth.currentUser;
    if (user != null) {
      Timer(const Duration(seconds: 3),
          () => Navigator.pushNamed(context, Homedb.routname));
    } else {
      Timer(const Duration(seconds: 3),
          () => Navigator.pushNamed(context, loginpage.routname));
    }
  }
}
