import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finalyear/AS%20A%20PLAYER/internationalsports/dashboard/profile.dart';
import 'package:finalyear/pages/loginpage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class setting extends StatefulWidget {
  const setting({super.key});

  @override
  State<setting> createState() => _settingState();
}

class _settingState extends State<setting> {
  //logout function
  Future signout() async {
    await FirebaseAuth.instance.signOut();
    Get.to(const loginpage());
  }

  //delete accuont function
  Future delete() async {
    FirebaseFirestore.instance
        .collection("users")
        .doc(currentUser.currentUser!.email)
        .delete();
    FirebaseAuth.instance.currentUser!.delete();
    Get.off(const loginpage());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Container(
        margin: EdgeInsets.all(10),
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 10),
              child: Center(
                child: Text(
                  "Settings",
                  style: TextStyle(fontSize: 40),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ListTile(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
              tileColor: Colors.grey.shade300,
              title: const Text("Delete"),
              leading: const Icon(FontAwesomeIcons.trash),
              iconColor: const Color.fromARGB(255, 4, 45, 119),
              onTap: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: const Text("Delete Account"),
                        content: const Text("Are you sure you want to delete?"),
                        actions: [
                          TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text("Cancel")),
                          TextButton(
                              onPressed: () {
                                delete();
                                Get.to(const loginpage());
                              },
                              child: const Text("Yas")),
                        ],
                      );
                    });
              },
            ),
            const SizedBox(
              height: 20,
            ),
            ListTile(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
              tileColor: Colors.grey.shade300,
              title: const Text("Logout"),
              leading: const Icon(FontAwesomeIcons.rightFromBracket),
              iconColor: const Color.fromARGB(255, 4, 45, 119),
              onTap: () {
                signout();
              },
            ),
          ],
        ),
      )),
    );
  }
}
