import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finalyear/GETX/LoginGetX.dart';
import 'package:finalyear/utils/Routes_Name.dart';
import 'package:finalyear/views/homedbforcoache.dart';
import 'package:finalyear/views/homedbforplayer.dart';
import 'package:finalyear/view_model/service/internet_connection.dart';
import 'package:finalyear/components/loginbutton.dart';
import 'package:finalyear/components/reusebletextfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class loginpage extends StatefulWidget {
  const loginpage({super.key});
  @override
  State<loginpage> createState() => _loginpageState();
}

final currentUser = FirebaseAuth.instance;

class _loginpageState extends State<loginpage> {
  //putting getx controller her
  final controller = Get.put(LoginController());
  // State variable for password visibility toggle
  bool _isObscured = true;

  //login function for the user
  void loginuser() async {
    try {
      checkconnectivity();
      showDialog(
        context: context,
        builder: (context) {
          return const Center(
            child: SpinKitFadingCircle(
              color: Colors.green,
              size: 50.0,
            ),
          );
        },
      );
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: controller.email.value,
        password: controller.password.value,
      );

      final currentuser = FirebaseAuth.instance.currentUser!.email;

      final userDocRef =
          FirebaseFirestore.instance.collection('users').doc(currentuser);

      userDocRef.get().then((doc) {
        if (doc.exists && doc.data() != null) {
          if (doc.data()!['markedForDeletion'] == true) {
            Get.snackbar(
              "Message",
              "Your account is disabled by admin.",
              backgroundColor: Colors.red,
              colorText: Colors.white,
            );
            Navigator.of(context).pop();
          } else {
            // User is not marked for deletion
            FirebaseFirestore.instance
                .collection("users")
                .doc(currentUser.currentUser!.email)
                .get()
                .then((value) {
              if (value['profession'] == 'Player') {
                Get.to(const homeforcoach());
              } else if (value['profession'] == 'Coache') {
                Get.to(const homeforplayer());
              } else {
                // Handle other professions or navigation logic here
              }
              Get.snackbar(
                "Message",
                "You have logged in successfully.",
                backgroundColor: Colors.green,
                colorText: Colors.white,
              );
            });
          }
        } else {
          Get.snackbar(
            "Error",
            "User document does not exist in Firestore.",
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
          Navigator.of(context).pop();
        }
      });
    } on FirebaseAuthException catch (e) {
      // Handle FirebaseAuth exceptions
      if (e.code == 'user-not-found') {
        Get.snackbar("No User", "No user is found for this Email",
            backgroundColor: Colors.red,
            colorText: Colors.white,
            duration: const Duration(seconds: 2),
            snackPosition: SnackPosition.BOTTOM);
        Navigator.of(context).pop();
      } else if (e.code == 'wrong-password') {
        Get.snackbar("Your password",
            "Your password is wrong; please correct your password",
            backgroundColor: Colors.red,
            colorText: Colors.white,
            duration: const Duration(seconds: 2),
            snackPosition: SnackPosition.BOTTOM);
        Navigator.of(context).pop();
      }
    }
  }

  //overide function for connectivity
  @override
  void initState() {
    super.initState();
    checkconnectivity();
    Future.delayed(Duration.zero, () {
      controller.emailController.text = ""; // Clear email text
      controller.passwordController.text = ""; // Clear password text
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: WillPopScope(
      onWillPop: () async {
        SystemNavigator.pop();
        return true;
      },
      child: SafeArea(
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
                        obscureText: _isObscured,
                        labelText: "Enter your password",
                        icon: const Icon(
                          Icons.lock,
                          color: Color.fromARGB(255, 4, 45, 119),
                        ),
                        sufixicon: GestureDetector(
                          onTap: (() {
                            setState(() {
                              _isObscured = !_isObscured;
                            });
                          }),
                          child: Icon(
                            _isObscured
                                ? FontAwesomeIcons.eyeSlash
                                : FontAwesomeIcons.eye,
                            color: Colors.black,
                            size: 21,
                          ),
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
                            Navigator.pushNamed(
                                context, Routesname.forgotpassword);
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
                    child: const Text(
                      "Login",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16),
                    )),

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
                          Navigator.pushNamed(context, Routesname.signup);
                        },
                        child: const Text(
                          "SIGNUP",
                          style: TextStyle(color: Colors.blue),
                        )),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ],
            ),
          ),
        )),
      ),
    ));
  }
}