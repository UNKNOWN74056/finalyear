import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finalyear/AS%20A%20COACH/international-sports/playerdashboard.dart';
import 'package:finalyear/AS%20A%20PLAYER/internationalsports/dashboard/dashboard.dart';
import 'package:finalyear/AS%20A%20PLAYER/internationalsports/dashboard/profile.dart';
import 'package:finalyear/GETX/clubdatafirebase.dart';
import 'package:finalyear/GETX/forgotpassword.dart';
import 'package:finalyear/pages/loginpage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../GETX/getdatafromfirebase.dart';
import '../wedgets/reusebletextfield.dart';

class functionservices {
  //controller
  final usercontroller = Get.put(FetchDataFirebase());
  //refresh function for the users
  void refresh_user_data() async {
    await Future.delayed(Duration(seconds: 2));
    usercontroller.GetDataFirebase();
  }

  // controller
  final clubcontroller = Get.put(Getclubdata());
  //refresh function fir the club data
  void refresh_club_data() async {
    await Future.delayed(Duration(seconds: 2));
    clubcontroller.Getclubdatafirebase();
  }

  //logout function
  Future signout() async {
    await FirebaseAuth.instance.signOut();
  }

  //delete accuont function
  Future delete() async {
    FirebaseFirestore.instance
        .collection("users")
        .doc(currentUser.currentUser!.email)
        .delete();
    FirebaseAuth.instance.currentUser!.delete();
  }

  // transfer email function
  void transfer_request_email() async {
    String email = 'recipient@example.com';
    String subject = 'Transfer Request';
    String body = '';
    final Uri params = Uri(
      scheme: 'mailto',
      path: email,
      query: 'subject=$subject&body=$body',
    );
    if (await canLaunch(params.toString())) {
      await launch(params.toString());
    } else {
      throw 'Could not launch email.';
    }
  }

  //getx controller
  final controller = Get.put(ForgotPassword());
  //function for the email verfication
  emailverify() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: controller.email.value)
          .then((value) => Get.to(const loginpage()));
      Get.snackbar("Reset email",
          "Passward reset email has been sent to your email please check.");
    } on FirebaseException catch (e) {
      if (e.code == 'user-not-found') {
        Get.snackbar("Email not found",
            "This enail is not found please enter valid email.");
      }
    }
  }

  loginischeck() {
    FirebaseFirestore.instance
        .collection("users")
        .doc(currentUser.currentUser!.email)
        .get()
        .then((value) {
      if (value['profession'] == 'Player') {
        Get.toNamed(playerdashboeard.routname);
        print("as a coach dashboard");
      } else {
        Get.to(const dashboard());
      }
    });
  }

  Allvideos() {
    FirebaseFirestore.instance.collection("videos").snapshots();
  }
}

var functions = new functionservices();
