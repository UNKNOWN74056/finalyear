import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finalyear/AS%20A%20COACH/culturehomedb.dart';
import 'package:finalyear/AS%20A%20PLAYER/internationalsports/dashboard/profile.dart';
import 'package:finalyear/GETX/LoginGetX.dart';
import 'package:finalyear/pages/forgotpassword.dart';
import 'package:finalyear/pages/signuppage.dart';
import 'package:finalyear/service/internet_connection.dart';
import 'package:finalyear/wedgets/loginbutton.dart';
import 'package:finalyear/wedgets/reusebletextfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import '../AS A PLAYER/internationalsports/dashboard/homedb.dart';

class loginpage extends StatefulWidget {
  //route
  static const String routname = 'login_page';
  const loginpage({super.key});
  @override
  State<loginpage> createState() => _loginpageState();
}

class _loginpageState extends State<loginpage> {
  //bool  for visibility of password
  bool _obsecure = true;

  //putting getx controller her
  final controller = Get.put(LoginController());

  //login function for the user
  loginuser() async {
    try {
      checkconnectivity();
      showDialog(
          context: context,
          builder: (context) {
            return const Center(
              child: CircularProgressIndicator(color: Colors.red),
            );
          });
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: controller.email.value, password: controller.password.value);
      FirebaseFirestore.instance
          .collection("users")
          .doc(currentUser.currentUser!.email)
          .get()
          .then((value) {
        if (value['profession'] == 'Player') {
          Get.to(const culturehomedb());
          print("as a coach dashboard");
        } else {
          Get.to(const Homedb());
          print("as a player dashboard");
        }
      });
      //Get.to(const Homedb());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        Get.snackbar("No User", "No user is found for this Email",
            duration: const Duration(seconds: 2),
            snackPosition: SnackPosition.BOTTOM);
        Navigator.of(context).pop();
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        Get.snackbar("Your password",
            "Your password is wrong please correct your password",
            duration: const Duration(seconds: 2),
            snackPosition: SnackPosition.BOTTOM);
        Navigator.of(context).pop();
      }
    }
  }

  // dispose function for the field
  @override
  void dispose() {
    controller.emailController.text = "";
    controller.passwordController.text = "";
    controller.dispose();
    super.dispose();
  }

  //overide function for connectivity
  @override
  void iniState() {
    super.initState();
    checkconnectivity();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return true;
      },
      child: Scaffold(
          body: SingleChildScrollView(
        child: Form(
          key: controller.keyForm,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Container(
                  child: const Text(
                    "LOGIN ",
                    style: TextStyle(
                      fontSize: 30,
                    ),
                  ),
                ),
              ),
              const Center(
                child: Padding(
                  padding: EdgeInsets.only(top: 40),
                  child: CircleAvatar(
                    radius: 80,
                    backgroundImage: AssetImage("assets/mixsport.jpeg"),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  children: [
                    reusebletextfield(
                      keyboard: TextInputType.emailAddress,
                      autoValidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        return controller.validEmail(value!);
                      },
                      labelText: "Enter your email",
                      icon: const Icon(
                        FontAwesomeIcons.solidEnvelope,
                        color: Color.fromARGB(255, 4, 45, 119),
                      ),
                      controller: controller.emailController,
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    reusebletextfield(
                      keyboard: TextInputType.emailAddress,
                      validator: (value) {
                        return controller.validPassword(value!);
                      },
                      autoValidateMode: AutovalidateMode.onUserInteraction,
                      controller: controller.passwordController,
                      labelText: "Enter your passwowrd",
                      icon: const Icon(
                        Icons.lock,
                        color: Color.fromARGB(255, 4, 45, 119),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 13),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, forgotpassword.routname);
                        },
                        child: const Text(
                          "Forgot password",
                          style: TextStyle(color: Colors.blue),
                        )),
                  ],
                ),
              ),
              const SizedBox(height: 15),

              //this is login button
              loginbutton(
                  onTap: () {
                    controller.checkLogin();
                    if (controller.isformValidated == true) {
                      loginuser();
                    }
                  },
                  child: const Text("Login")),

              const SizedBox(
                height: 20,
              ),
              //this is the signup button
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(right: 3),
                    child: Text("Do not have an account!"),
                  ),
                  GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, signuppage.routname);
                      },
                      child: const Text(
                        "SIGNUP",
                        style: TextStyle(color: Colors.blue),
                      )),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ],
          ),
        ),
      )),
    ));
  }
}
