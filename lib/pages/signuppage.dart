import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finalyear/pages/loginpage.dart';
import 'package:finalyear/service/internet_connection.dart';
import 'package:finalyear/wedgets/reusebletextfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class signuppage extends StatefulWidget {
  const signuppage({super.key});

  @override
  State<signuppage> createState() => _signuppageState();
}

final _formKey = GlobalKey<FormState>();

class _signuppageState extends State<signuppage> {
  //controllers for text fields
  final _firstnamecontroller = TextEditingController();
  final _lastnamecontroller = TextEditingController();
  final _professioncontroller = TextEditingController();
  final _gendercontroller = TextEditingController();
  final _sportcontroller = TextEditingController();
  final _citycontroller = TextEditingController();
  final _emailcontroller = TextEditingController();
  final _passwordcontroller = TextEditingController();
  final _confirmpasswordcontroller = TextEditingController();
  final _phonenumbercontroller = TextEditingController();

  // this is the dispose funtion to dispose the data
  @override
  void dispose() {
    _firstnamecontroller.dispose();
    _lastnamecontroller.dispose();
    _professioncontroller.dispose();
    _gendercontroller.dispose();
    _sportcontroller.dispose();
    _citycontroller.dispose();
    _emailcontroller.dispose();
    _passwordcontroller.dispose();
    _confirmpasswordcontroller.dispose();
    _phonenumbercontroller.dispose();

    super.dispose();
  }

  //options for profession
  List profession = ['Coache', 'Player'];
  String? profession1;

  //options for gender
  List gender = ['Male', 'Female', 'Other'];
  String? gender1;

  //options for type of sports
  List sports = [
    'FootBall',
    'BasketBall',
    'VulleyBall',
    'TableTenis',
    'Cricket',
    'Hockey',
    'Archery',
    'Kabaddi',
    'Tent pagging',
    'Gymnastic'
  ];
  String? sport1;

  //function to create user
  Future signup() async {
    try {
      checkconnectivity();
      passwrodconfirm();
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailcontroller.text.trim(),
        password: _passwordcontroller.text.trim(),
      );
      Adduserdeatial(
        _firstnamecontroller.text.trim(),
        _lastnamecontroller.text.trim(),
        _professioncontroller.text.trim(),
        _gendercontroller.text.trim(),
        _sportcontroller.text.trim(),
        _citycontroller.text.trim(),
        _emailcontroller.text.trim(),
        _passwordcontroller.text.trim(),
        _phonenumbercontroller.text.trim(),
      );
      Get.snackbar("Registration",
          "Your account has been register succefully please login again.");
      Get.to(const loginpage());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Get.snackbar("Password weak", "Password is too weak!");
      } else if (e.code == 'email-already-in-use') {
        Get.snackbar(
            "Email", "This email is already in use please try a valid email!");
      }
    }
  }

  //add user details to firestore database
  Future Adduserdeatial(
      String firstname,
      String lastname,
      String profession,
      String gender,
      String sports,
      String city,
      String email,
      String password,
      String phone) async {
    await FirebaseFirestore.instance.collection('users').add({
      'firstname': firstname,
      'lastname': lastname,
      'profession': profession1,
      'gender': gender1,
      'sport': sport1,
      'city': city,
      'email': email,
      'password': password,
      'phoneNumber': phone,
    });
  }

  //bool function to confirm password
  void passwrodconfirm() {
    if (_passwordcontroller.text.trim() ==
        _confirmpasswordcontroller.text.trim()) {
      return null;
    } else {
      Get.snackbar(
          "Passwrod", "The password and confirm password are not equal");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: SingleChildScrollView(
      child: Column(children: [
        Padding(
          padding: const EdgeInsets.only(top: 30, left: 10),
          child: Container(
            child: const Text(
              "SIGN UP",
              style: TextStyle(
                fontSize: 40,
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        const Text(
          "Register below with your details",
          style: TextStyle(fontSize: 20),
        ),
        const SizedBox(
          height: 15,
        ),
        Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                reusebletextfield(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  autoValidateMode: AutovalidateMode.onUserInteraction,
                  validator: (Value) {
                    return Value.isEmpty ? "enter your first name" : null;
                  },
                  labelText: "First Name",
                  icon: const Icon(
                    FontAwesomeIcons.solidUser,
                    color: Color.fromARGB(255, 4, 45, 119),
                  ),
                  controller: _firstnamecontroller,
                ),
                const SizedBox(
                  height: 25,
                ),
                reusebletextfield(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  autoValidateMode: AutovalidateMode.onUserInteraction,
                  validator: (Value) {
                    return Value.isEmpty ? "enter your last name" : null;
                  },
                  controller: _lastnamecontroller,
                  labelText: "Last Name",
                  icon: const Icon(
                    FontAwesomeIcons.solidUser,
                    color: Color.fromARGB(255, 4, 45, 119),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                DropdownButtonFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  value: profession1,
                  onChanged: (newvalue) {
                    setState(() {
                      profession1 = newvalue as String;
                    });
                  },
                  items: profession
                      .map(
                        (e) => DropdownMenuItem(
                          child: Text(e),
                          value: e,
                        ),
                      )
                      .toList(),
                  validator: (value) {
                    if (value == null) {
                      return "please enter your profession";
                    } else {
                      return null;
                    }
                  },
                  icon: const Icon(
                    Icons.arrow_drop_down_circle,
                    color: Colors.purple,
                  ),
                  decoration: InputDecoration(
                    filled: true,
                    isDense: true,
                    contentPadding: const EdgeInsets.symmetric(vertical: 10),
                    prefixIcon: const Icon(
                      FontAwesomeIcons.userTie,
                      color: Color.fromARGB(255, 4, 45, 119),
                    ),
                    labelText: "Your profession",
                    hintStyle: const TextStyle(
                      color: Colors.grey,
                    ),
                    enabledBorder: OutlineInputBorder(
                      // borderSide: const BorderSide(
                      //   width: 4,
                      //   //  color: Colors.lightGreen,
                      // ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                DropdownButtonFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    value: gender1,
                    onChanged: (newvalue) {
                      setState(() {
                        gender1 = newvalue as String;
                      });
                    },
                    items: gender
                        .map(
                          (e) => DropdownMenuItem(
                            child: Text(e),
                            value: e,
                          ),
                        )
                        .toList(),
                    icon: const Icon(
                      Icons.arrow_drop_down_circle,
                      color: Colors.purple,
                    ),
                    decoration: InputDecoration(
                      filled: true,
                      isDense: true,
                      contentPadding: const EdgeInsets.symmetric(vertical: 10),
                      prefixIcon: const Icon(
                        FontAwesomeIcons.venusMars,
                        color: Color.fromARGB(255, 4, 45, 119),
                      ),
                      labelText: "Your gender",
                      hintStyle: const TextStyle(
                        color: Colors.grey,
                      ),
                      enabledBorder: OutlineInputBorder(
                        // borderSide: const BorderSide(
                        //   width: 4,
                        //   //  color: Colors.lightGreen,
                        // ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    validator: (value) {
                      if (value == null) {
                        return "please enter your gender";
                      } else {
                        return null;
                      }
                    }),
                const SizedBox(
                  height: 25,
                ),
                DropdownButtonFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    value: sport1,
                    onChanged: (val) {
                      setState(() {
                        sport1 = val as String;
                      });
                    },
                    items: sports
                        .map(
                          (e) => DropdownMenuItem(
                            child: Text(e),
                            value: e,
                          ),
                        )
                        .toList(),
                    icon: const Icon(
                      Icons.arrow_drop_down_circle,
                      color: Colors.purple,
                    ),
                    decoration: InputDecoration(
                      filled: true,
                      isDense: true,
                      contentPadding: const EdgeInsets.symmetric(vertical: 10),
                      prefixIcon: const Icon(
                        FontAwesomeIcons.futbol,
                        color: Color.fromARGB(255, 4, 45, 119),
                      ),
                      labelText: "Your sports",
                      hintStyle: const TextStyle(
                        color: Colors.grey,
                      ),
                      enabledBorder: OutlineInputBorder(
                        // borderSide: const BorderSide(
                        //   width: 4,
                        //   //  color: Colors.lightGreen,
                        // ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    validator: (value) {
                      if (value == null) {
                        return "please enter your sports";
                      } else {
                        return null;
                      }
                    }),
                const SizedBox(
                  height: 25,
                ),
                reusebletextfield(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  autoValidateMode: AutovalidateMode.onUserInteraction,
                  validator: (Value) {
                    return Value.isEmpty ? "enter your city" : null;
                  },
                  labelText: "City",
                  controller: _citycontroller,
                  icon: const Icon(
                    FontAwesomeIcons.locationDot,
                    color: Color.fromARGB(255, 4, 45, 119),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                reusebletextfield(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                    autoValidateMode: AutovalidateMode.onUserInteraction,
                    validator: (Value) {
                      return Value.isEmpty ? "enter your email" : null;
                    },
                    controller: _emailcontroller,
                    labelText: "EMAIL",
                    icon: const Icon(
                      FontAwesomeIcons.solidEnvelope,
                      color: Color.fromARGB(255, 4, 45, 119),
                    )),
                const SizedBox(
                  height: 25,
                ),
                reusebletextfield(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                    autoValidateMode: AutovalidateMode.onUserInteraction,
                    validator: (Value) {
                      return Value.isEmpty ? "enter your password" : null;
                    },
                    controller: _passwordcontroller,
                    labelText: "PASSWORD",
                    icon: const Icon(Icons.lock,
                        color: Color.fromARGB(255, 4, 45, 119))),
                const SizedBox(
                  height: 25,
                ),
                reusebletextfield(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                    autoValidateMode: AutovalidateMode.onUserInteraction,
                    validator: (Value) {
                      return Value.isEmpty ? "enter your email" : null;
                    },
                    controller: _confirmpasswordcontroller,
                    labelText: "confirm password",
                    icon: const Icon(Icons.lock,
                        color: Color.fromARGB(255, 4, 45, 119))),
                const SizedBox(
                  height: 25,
                ),
                InternationalPhoneNumberInput(
                    autoValidateMode: AutovalidateMode.onUserInteraction,
                    textFieldController: _phonenumbercontroller,
                    onInputChanged: (val) {},
                    inputDecoration: InputDecoration(
                      filled: true,
                      isDense: true,
                      contentPadding: EdgeInsets.symmetric(vertical: 10),
                      labelText: "Your phone number",
                      hintStyle: TextStyle(
                        color: Colors.grey,
                      ),
                      enabledBorder: OutlineInputBorder(
                        // borderSide: const BorderSide(
                        //   width: 4,
                        //   //  color: Colors.lightGreen,
                        // ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "please enter your phone number";
                      } else {
                        return null;
                      }
                    }),
                const SizedBox(
                  height: 10,
                ),
                //this is signup button to create the user
                SizedBox(
                  width: double.infinity,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 30, right: 30),
                    child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Processing Data')),
                            );
                          }
                          signup();
                        },
                        child: const Text("SIGIN UP")),
                  ),
                ),

                //login button if u have account
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("All ready have an account!"),
                    TextButton(
                        // i use get for going to login screen
                        onPressed: () {
                          Get.back();
                        },
                        child: const Text(
                          "LOGIN",
                        ))
                  ],
                )
              ],
            ),
          ),
        ),
      ]),
    )));
  }
}
