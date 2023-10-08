import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:finalyear/GETX/allvideos.dart';
import 'package:finalyear/GETX/clubdatafirebase.dart';
import 'package:finalyear/GETX/forgotpassword.dart';
import 'package:finalyear/GETX/updataprofile.dart';
import 'package:finalyear/model/tournamentrequestmodel.dart';
import 'package:finalyear/views/homedbforcoache.dart';
import 'package:finalyear/views/homedbforplayer.dart';
import 'package:finalyear/views/loginpage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../views/AS A PLAYER/internationalsports/dashboard/tournaments.dart';
import '../GETX/changepassword.dart';
import '../GETX/getdatafromfirebase.dart';
import '../GETX/offerrequest.dart';
import '../GETX/tournamentRegister.dart';

class functionservices {
  //controller
  final chacontroller = Get.put(changepassword());
  final usercontroller = Get.put(FetchDataFirebase());
  final vidcontroller = Get.put(FetchVideoFirebase());
  final offercontroller = Get.put(offerrequestform());
  final regicontroller = Get.put(TournamentsRegistration());
  final updateprofilecontroller = Get.put(updateuserprofile());
  final currentuser = FirebaseAuth.instance.currentUser!.email;
  File? _videoFile;
  final videocontorller = Get.put(FetchVideoFirebase());

//picked upload function
  Future<void> pickVideo(BuildContext context) async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(type: FileType.video);
    if (result != null) {
      _videoFile = File(result.files.single.path!);
    }

    if (_videoFile == null) return;
    String fileName = _videoFile!.path.split('/videos').last;
    Reference reference = FirebaseStorage.instance.ref().child(fileName);
    UploadTask uploadTask = reference.putFile(_videoFile!);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const AlertDialog(
          content: SizedBox(
            height: 50,
            child: Row(
              children: [
                SpinKitFadingCircle(
                  color: Colors.red, // Set the color of the SpinKit indicator
                  size: 50.0, // Set the size of the indicator as needed
                ),
                SizedBox(width: 16),
                Text("Uploading..."),
              ],
            ),
          ),
        );
      },
    );
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
    Navigator.pop(context);
    Get.snackbar(
      "Message",
      "Your video has been uploaded",
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );
  }

  // controller
  final clubcontroller = Get.put(Getclubdata());
  //refresh function fir the club data
  void refresh_club_data() async {
    await Future.delayed(const Duration(seconds: 2));
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
  final emailcontroller = Get.put(ForgotPassword());
  //function for the email verfication
  emailverify() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: emailcontroller.email.value)
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
    final user = currentUser.currentUser;
    if (user == null) {
      // User is not logged in, navigate to the login screen
      Get.to(const loginpage());
      return;
    }

    final userDocRef =
        FirebaseFirestore.instance.collection('users').doc(user.email);
    userDocRef.get().then((doc) {
      if (doc.exists && doc.data() != null) {
        if (doc.data()!['markedForDeletion'] == true) {
          // The user is marked for deletion, log them out
          FirebaseAuth.instance.signOut();
          Get.to(const loginpage());
          Get.snackbar(
            "Message",
            "Your account has been deleted by admin.",
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        } else {
          // User is not marked for deletion
          if (doc.data()!['profession'] == 'Player') {
            Get.to(const homeforcoach());
            print("as a coach dashboard");
          } else if (doc.data()!['profession'] == 'Coache') {
            Get.to(const homeforplayer());
          }
        }
      }
    });
  }

  //user password change function
  passwordchange() async {
    FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.email)
        .update({'password': chacontroller.password.value});
  }

  Future<void> sendRequest(BuildContext context) async {
    final request = TournamentRegistrationRequest(
        teamName: regicontroller.teamnamecontroller.text,
        captainName: regicontroller.captainnamecontroller.text,
        address: regicontroller.addresscontroller.text,
        city: regicontroller.citycontroller.text,
        contactEmail: regicontroller.emailcontroller.text,
        contact: regicontroller.contactcontroller.text,
        sportevent: regicontroller.sporteventcontroller.text,
        player1: regicontroller.player1controller.text,
        player2: regicontroller.player2controller.text,
        player3: regicontroller.player3controller.text,
        player4: regicontroller.player4controller.text,
        player5: regicontroller.player5controller.text,
        player6: regicontroller.player6controller.text,
        player7: regicontroller.player7controller.text,
        player8: regicontroller.player8controller.text,
        player9: regicontroller.player9controller.text,
        player10: regicontroller.player10controller.text,
        player11: regicontroller.player11controller.text,
        player12: regicontroller.player12controller.text,
        sport: regicontroller.sportcontroller.text,
        sentby: currentuser.toString());

    try {
      final collectionRef =
          FirebaseFirestore.instance.collection('registrationRequests');
      final documentRef = await collectionRef.add(request.toJson());

      // Assign the generated document ID to the request
      final generatedId = documentRef.id;
      await documentRef.update({'document': generatedId});

      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Request Sent'),
          content: const Text('Your registration request has been sent.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: GestureDetector(
                  onTap: () {
                    Get.to(const tournaments());
                  },
                  child: const Text('OK')),
            ),
          ],
        ),
      );
    } catch (error) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Error'),
          content: const Text('An error occurred while sending the request.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: GestureDetector(
                  onTap: () {
                    Get.to(const tournaments());
                  },
                  child: const Text('OK')),
            ),
          ],
        ),
      );
    }
  }

  void checkAuthenticationState(user) {
    final currentuser = FirebaseAuth.instance.currentUser!.email;
    // FirebaseAuth.instance.authStateChanges().listen((User? user) {
    //   if (user == null) {
    //     // User is already logged out
    //     return;
    //   }

    // Check the user's Firestore document for 'markedForDeletion'
    final userDocRef =
        FirebaseFirestore.instance.collection('users').doc(currentuser);
    userDocRef.get().then((doc) {
      if (doc.exists && doc.data() != null) {
        if (doc.data()!['markedForDeletion'] == true) {
          //  delete();
          // The user is marked for deletion, log them out
          FirebaseAuth.instance.signOut();
          Get.to(const loginpage());
          Get.snackbar("Message", "Your account has been deleted by admin.");
        }
      }
    });
  }
}

var functions = functionservices();
