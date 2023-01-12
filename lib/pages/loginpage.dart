import 'package:finalyear/AS%20A%20PLAYER/internationalsports/dashboard/homedb.dart';
import 'package:finalyear/pages/forgotpassword.dart';
import 'package:finalyear/pages/signuppage.dart';
import 'package:finalyear/service/internet_connection.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class loginpage extends StatefulWidget {
  const loginpage({super.key});
  @override
  State<loginpage> createState() => _loginpageState();
}

final _formKey = GlobalKey<FormState>();

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
        child: Scaffold(
            body: SingleChildScrollView(
      child: Form(
        key: _formKey,
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
                  TextFormField(
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: _emailcontroller,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15)),
                          labelText: "Enter your email",
                          prefixIcon: const Icon(Icons.person)),

                      //form validaiton code
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "please enter your username";
                        } else {
                          return null;
                        }
                      }),
                  const SizedBox(
                    height: 25,
                  ),
                  TextFormField(
                      obscureText: _obsecure,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      controller: _passwordcontroller,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15)),
                          labelText: "Enter your passwowrd",
                          prefixIcon: const Icon(
                            Icons.lock,
                          ),
                          suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                _obsecure = !_obsecure;
                              });
                            },
                            child: Icon(_obsecure
                                ? Icons.visibility_off
                                : Icons.visibility),
                          )),
                      //form validaiton code
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "please enter your password";
                        } else {
                          return null;
                        }
                      })
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
            SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.only(left: 30, right: 30),
                child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
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
            const Text("or"),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 25, right: 25),
              child: SizedBox(
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                      primary: Colors.teal,
                      onPrimary: Colors.white,
                      minimumSize: const Size(double.infinity, 40)),
                  icon: const FaIcon(FontAwesomeIcons.google),
                  label: const Text(
                    "Sign in with google",
                  ),
                  onPressed: () {},
                ),
              ),
            ),
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
    )));
  }
}

// class TextForm extends StatelessWidget {
//   const TextForm({
//     required this.lable,
//     required this.hint,
//     required this.icon,
//     this.iccon,
//     Key? key,
//   }) : super(key: key);
//   final lable;
//   final hint;
//   final icon;
//   final iccon;

//   @override
//   Widget build(BuildContext context) {
//     var obscureText = true;
//     return TextFormField(
//         //obscureText: obscureText,
//         style: const TextStyle(color: Colors.black),
//         decoration: InputDecoration(
//           labelText: lable,
//           hintText: hint,
//           prefixIcon: icon,
//           suffixIcon: iccon,
//           border: OutlineInputBorder(
//             borderRadius: BorderRadius.circular(20),
//           ),
//           enabledBorder: OutlineInputBorder(
//             borderSide: const BorderSide(color: Colors.black),
//             borderRadius: BorderRadius.circular(20),
//           ),
//         ));
//   }
// }
