import 'package:finalyear/pages/loginpage.dart';
import 'package:finalyear/wedgets/reusebletextfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class forgotpassword extends StatefulWidget {
  const forgotpassword({super.key});

  @override
  State<forgotpassword> createState() => _forgotpasswordState();
}

final key3 = GlobalKey<FormState>();

class _forgotpasswordState extends State<forgotpassword> {
  //controller for the verify eamil field
  final _verifyemailcontroller = TextEditingController();
  var email = "";

  //function for the email verfication
  emailverify() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: email)
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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: key3,
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Container(
                child: const Text(
                  "FORGOT\n PASSWORD ",
                  style: TextStyle(fontSize: 30),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            const Text(
              "Please enter your email to verify it.",
              style: TextStyle(fontSize: 15),
            ),
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: reusebletextfield(
                autoValidateMode: AutovalidateMode.onUserInteraction,
                  validator: (Value) {
                    return Value.isEmpty ? "enter your email" : null;
                  },
                  controller: _verifyemailcontroller,
                  labelText: "EMAIL",
                  icon: const Icon(
                    FontAwesomeIcons.solidUser,
                    color: Color.fromARGB(255, 4, 45, 119),
                  )),
            ),

            //button for varification of oyur email to reset your password
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: () {
                      if (key3.currentState!.validate()) {
                        setState(() {
                          email = _verifyemailcontroller.text;
                        });
                      }
                      emailverify();
                    },
                    child: const Text("SEND EMAIL"))
              ],
            )
          ]),
        ),
      ),
    ));
  }
}
