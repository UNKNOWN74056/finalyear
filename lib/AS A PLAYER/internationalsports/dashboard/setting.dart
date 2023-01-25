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
  Future signout() async {
    await FirebaseAuth.instance.signOut();
    Get.to(const loginpage());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: Column(
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
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            tileColor: Colors.grey.shade300,
            title: const Text("Logout"),
            leading: const Icon(FontAwesomeIcons.rightFromBracket),
            iconColor: Color.fromARGB(255, 4, 45, 119),
            onTap: () {
              signout();
            },
          ),
        ],
      )),
    );
  }
}
