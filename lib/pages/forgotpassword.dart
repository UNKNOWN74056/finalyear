import 'package:finalyear/pages/loginpage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class forgotpassword extends StatefulWidget {
  const forgotpassword({super.key});

  @override
  State<forgotpassword> createState() => _forgotpasswordState();
}

final _formKey = GlobalKey<FormState>();

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
          key: _formKey,
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
              child: TextFormField(
                  controller: _verifyemailcontroller,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15)),
                      hintText: "enter your email",
                      labelText: "EMAIL",
                      prefixIcon: const Icon(Icons.person)),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "please enter your username";
                    } else {
                      return null;
                    }
                  }),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
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
