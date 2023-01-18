import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finalyear/pages/loginpage.dart';
import 'package:finalyear/service/internet_connection.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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
                TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: _firstnamecontroller,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15)),
                        labelText: "First Name",
                        prefixIcon: const Icon(Icons.person)),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "please enter your firstname";
                      } else {
                        return null;
                      }
                    }),
                const SizedBox(
                  height: 25,
                ),
                TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: _lastnamecontroller,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15)),
                        labelText: "Last Name",
                        prefixIcon: const Icon(Icons.person)),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "please enter your lastname";
                      } else {
                        return null;
                      }
                    }),
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
                      labelText: "Your profession",
                      hintText: "select in option",
                      prefixIcon: const Icon(Icons.sports),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15))),
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
                        labelText: "Your gender",
                        prefixIcon: const Icon(Icons.sports),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15))),
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
                        labelText: "Your sports",
                        hintText: "Your sport",
                        prefixIcon: const Icon(Icons.sports),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15))),
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
                TextFormField(
                    controller: _citycontroller,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15)),
                        labelText: "City",
                        prefixIcon: const Icon(Icons.room)),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "please enter your city name";
                      } else {
                        return null;
                      }
                    }),
                const SizedBox(
                  height: 25,
                ),
                TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: _emailcontroller,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15)),
                        labelText: "EMAIL",
                        prefixIcon: const Icon(Icons.email)),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "please enter your email";
                      } else {
                        return null;
                      }
                    }),
                const SizedBox(
                  height: 25,
                ),
                TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: _passwordcontroller,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15)),
                        labelText: "PASSWORD",
                        prefixIcon: const Icon(Icons.lock)),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "please enter your password";
                      } else {
                        return null;
                      }
                    }),
                const SizedBox(
                  height: 25,
                ),
                TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: _confirmpasswordcontroller,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15)),
                        hintText: "confirm your password",
                        labelText: "confirm password",
                        prefixIcon: const Icon(Icons.lock)),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "please enter your password";
                      } else {
                        return null;
                      }
                    }),
                const SizedBox(
                  height: 25,
                ),
                InternationalPhoneNumberInput(
                    autoValidateMode: AutovalidateMode.onUserInteraction,
                    textFieldController: _phonenumbercontroller,
                    onInputChanged: (val) {},
                    inputDecoration: const InputDecoration(
                      border: InputBorder.none,
                      labelText: "phone number",
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
