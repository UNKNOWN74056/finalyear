import 'package:finalyear/pages/forgotpassword.dart';
import 'package:finalyear/pages/signuppage.dart';
import 'package:finalyear/service/internet_connection.dart';
import 'package:finalyear/wedgets/reusebletextfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import '../AS A PLAYER/internationalsports/dashboard/homedb.dart';

class loginpage extends StatefulWidget {
  const loginpage({super.key});
  @override
  State<loginpage> createState() => _loginpageState();
}

final _form_Key = GlobalKey<FormState>();

class _loginpageState extends State<loginpage> {
  //bool vareable for visibility of password
  bool _obsecure = true;
  //these are the cotroller for eamil and password
  var email = "";
  var password = "";
  final _emailcontroller = TextEditingController();
  final _passwordcontroller = TextEditingController();

  // dispose function for the field
  @override
  void dispose() {
    _emailcontroller.dispose();
    _passwordcontroller.dispose();

    super.dispose();
  }

  //login function for the user
  loginuser() async {
    try {
      checkconnectivity();
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      Get.to(const Homedb());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        Get.snackbar("No User", "No user is found for this Email",
            duration: const Duration(seconds: 2),
            snackPosition: SnackPosition.BOTTOM);
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        Get.snackbar("Your password",
            "Your password is wrong please correct your password",
            duration: const Duration(seconds: 2),
            snackPosition: SnackPosition.BOTTOM);
      }
    }
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
          key: _form_Key,
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
                      validator: (Value) {
                        return Value.isEmpty ? "enter your email" : null;
                      },
                      labelText: "Enter your email",
                      icon: const Icon(
                        FontAwesomeIcons.solidEnvelope,
                        color: Color.fromARGB(255, 4, 45, 119),
                      ),
                      controller: _emailcontroller,
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    reusebletextfield(
                      keyboard: TextInputType.emailAddress,
                    
                      validator: (Value) {
                        return Value.isEmpty ? "enter your email" : null;
                      },
                      suffixIcon: GestureDetector(
                        onTap: () {
                          setState(() {
                            _obsecure = !_obsecure;
                          });
                        },
                        child: Icon(_obsecure
                            ? FontAwesomeIcons.eye
                            : FontAwesomeIcons.eyeSlash),
                      ),
                      autoValidateMode: AutovalidateMode.onUserInteraction,
                      controller: _passwordcontroller,
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
                    TextButton(
                        onPressed: () => Get.to(() => (const forgotpassword())),
                        child: const Text(
                          "Forgot password",
                          style: TextStyle(color: Colors.blue),
                        ))
                  ],
                ),
              ),

              //this is login button
              SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.only(left: 30, right: 30),
                  child: ElevatedButton(
                      onPressed: () {
                        if (_form_Key.currentState!.validate()) {
                          setState(() {
                            email = _emailcontroller.text;
                            password = _passwordcontroller.text;
                          });
                        }
                        loginuser();
                      },
                      child: const Text("LOGIN")),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              //this is the signup button
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Do not have an account!"),
                  TextButton(
                      onPressed: () => Get.to(() => (const signuppage())),
                      child: const Text(
                        "SIGNUP",
                        style: TextStyle(color: Colors.blue),
                      ))
                ],
              ),
            ],
          ),
        ),
      )),
    ));
  }
}
