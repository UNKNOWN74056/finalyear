import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finalyear/pages/loginpage.dart';
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
    _emailcontroller.dispose();
    _passwordcontroller.dispose();
    _confirmpasswordcontroller.dispose();
    _phonenumbercontroller.dispose();

    super.dispose();
  }

  //options for profession
  final profession = ['Coache', 'Player'];
  String? selectedval = 'coache';

  //options for gender
  final gender = ['Male', 'Female', 'Other'];
  String? selected = 'Male';

  //options for type of sports
  final sports = [
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
  String? selected1 = 'FootBall';

  //function to create user
  Future signup() async {
    if (passwrodconfirm()) {
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
        _emailcontroller.text.trim(),
        _passwordcontroller.text.trim(),
        _confirmpasswordcontroller.text.trim(),
        _phonenumbercontroller.text.trim(),
      );
    }
  }

  //add user details to firestore database
  Future Adduserdeatial(
      String firstname,
      String lastname,
      String profession,
      String gender,
      String sports,
      String email,
      String password,
      String confirm,
      String phone) async {
    await FirebaseFirestore.instance.collection('users').add({
      'firstname': firstname,
      'lastname': lastname,
      'profession': profession,
      'gender': gender,
      'sport': sports,
      'email': email,
      'password': password,
      'confirmpassword': confirm,
      'phoneNumber': phone,
    });
  }

  //bool function to confirm password
  bool passwrodconfirm() {
    if (_passwordcontroller.text.trim() ==
        _confirmpasswordcontroller.text.trim()) {
      return true;
    } else {
      return false;
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
          height: 25,
        ),
        Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                TextFormField(
                    controller: _firstnamecontroller,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
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
                    controller: _lastnamecontroller,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
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
                   // value: selectedval,
                    items: profession
                        .map(
                          (e) => DropdownMenuItem(
                            child: Text(e),
                            value: e,
                          ),
                        )
                        .toList(),
                    onChanged: (val) {
                      setState(() {
                        selectedval = val as String;
                      });
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
                            borderRadius: BorderRadius.circular(20))),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "please enter your profession";
                      } else {
                        return null;
                      }
                    }),
                const SizedBox(
                  height: 25,
                ),
                DropdownButtonFormField(
                   // value: selected,
                    items: gender
                        .map(
                          (e) => DropdownMenuItem(
                            child: Text(e),
                            value: e,
                          ),
                        )
                        .toList(),
                    onChanged: (val) {
                      setState(() {
                        selected = val as String;
                      });
                    },
                    icon: const Icon(
                      Icons.arrow_drop_down_circle,
                      color: Colors.purple,
                    ),
                    decoration: InputDecoration(
                        labelText: "Your gender",
                        hintText: "select option",
                        prefixIcon: const Icon(Icons.sports),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20))),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "please enter your gender";
                      } else {
                        return null;
                      }
                    }),
                const SizedBox(
                  height: 25,
                ),
                DropdownButtonFormField(
                    value: selected1,
                    items: sports
                        .map(
                          (e) => DropdownMenuItem(
                            child: Text(e),
                            value: e,
                          ),
                        )
                        .toList(),
                    onChanged: (val) {
                      setState(() {
                        selected1 = val as String;
                      });
                    },
                    icon: const Icon(
                      Icons.arrow_drop_down_circle,
                      color: Colors.purple,
                    ),
                    decoration: InputDecoration(
                        labelText: "Your sports",
                        hintText: "select option",
                        prefixIcon: const Icon(Icons.sports),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20))),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "please enter your sports";
                      } else {
                        return null;
                      }
                    }),
                const SizedBox(
                  height: 25,
                ),
                TextFormField(
                    controller: _emailcontroller,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
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
                    controller: _passwordcontroller,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
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
                    controller: _confirmpasswordcontroller,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
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
                        //  onPressed: () {

                        //   if (_formKey.currentState!.validate()) {
                        //     ScaffoldMessenger.of(context).showSnackBar(
                        //       const SnackBar(content: Text('Processing Data')),
                        //     );
                        //   }
                        //},
                        onPressed: () {
                          // i add here get for pop bottom
                          signup();
                          Get.snackbar("Sing up", "Successfully",
                              duration: const Duration(seconds: 1),
                              snackPosition: SnackPosition.BOTTOM);
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
                        onPressed: () => Get.to(() => (const loginpage())),
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
