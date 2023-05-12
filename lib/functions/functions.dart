import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:finalyear/AS%20A%20COACH/international-sports/playerdashboard.dart';
import 'package:finalyear/AS%20A%20PLAYER/internationalsports/dashboard/dashboard.dart';
import 'package:finalyear/AS%20A%20PLAYER/internationalsports/dashboard/profile.dart';
import 'package:finalyear/GETX/allvideos.dart';
import 'package:finalyear/GETX/clubdatafirebase.dart';
import 'package:finalyear/GETX/forgotpassword.dart';
import 'package:finalyear/GETX/updataprofile.dart';
import 'package:finalyear/pages/loginpage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../GETX/getdatafromfirebase.dart';
import '../model/videomodel.dart';

class functionservices {
  //controller
  final usercontroller = Get.put(FetchDataFirebase());
  final vidcontroller = Get.put(FetchVideoFirebase());
  final updateprofilecontroller = Get.put(updateuserprofile());
  final currentuser = FirebaseAuth.instance.currentUser!.email;
  File? _videoFile;
  final videocontorller = Get.put(FetchVideoFirebase());
  //refresh function for the users
  void refresh_user_data() async {
    await Future.delayed(Duration(seconds: 2));
    usercontroller.GetDataFirebase();
  }

//picked upload function
  Future<void> pickVideo() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(type: FileType.video);
    if (result != null) {
      _videoFile = File(result.files.single.path!);
    }
    if (_videoFile == null) return;
    String fileName = _videoFile!.path.split('/videos').last;
    Reference reference = FirebaseStorage.instance.ref().child(fileName);
    UploadTask uploadTask = reference.putFile(_videoFile!);
    TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
    final downloadURL = await taskSnapshot.ref.getDownloadURL();

    //adding download link to firestore database
    var docRef = FirebaseFirestore.instance.collection("videos").doc();
    var id = docRef.id;
    await docRef.set({
      "videourl": downloadURL.toString(),
      "email": currentuser,
      'id': id,
    });
    Get.snackbar("Message", "Your video has been uploaded");
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

  // function to check the login
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

  // update profile function
  updateprofile() async {
    File? _image;
    final email = FirebaseAuth.instance.currentUser!.email;
    var refer = await FirebaseStorage.instance
        .ref("/MrSport$email")
        .child('images')
        .putFile(_image!.absolute);
    TaskSnapshot uploadTask = refer;
    await Future.value(uploadTask);
    var newUrl = await refer.ref.getDownloadURL();
    FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.email)
        .update({
      'fullname':
          updateprofilecontroller.updatefullnamecontroller.text.toString(),
      'city': updateprofilecontroller.updatecitycontroller.text.toString(),
      'phone': updateprofilecontroller.updatephonecontroller.text.toString(),
      'Imageurl': newUrl.toString(),
    });
  }
}

var functions = functionservices();
