import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

import '../as a player/internationalsports/pages/loginpage.dart';

class signuppage extends StatefulWidget {
  const signuppage({super.key});

  @override
  State<signuppage> createState() => _signuppageState();
}

final _formKey = GlobalKey<FormState>();

class _signuppageState extends State<signuppage> {
  final profession = ['Coache', 'Player'];
  String? selectedval = 'Coache';

  final gender = ['Male', 'Female', 'Other'];
  String? selected = 'Male';
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
              style: TextStyle(fontSize: 40),
            ),
          ),
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
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                        hintText: "your first name",
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
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                        hintText: "your last name",
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
                    value: selectedval,
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
                    decoration: const InputDecoration(
                        labelText: "Your profession",
                        prefixIcon: Icon(Icons.sports),
                        border: OutlineInputBorder()),
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
                    value: selected,
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
                    decoration: const InputDecoration(
                        labelText: "Your gender",
                        prefixIcon: Icon(Icons.sports),
                        border: OutlineInputBorder()),
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
                TextFormField(
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                        hintText: "enter your email",
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
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20)),
                        hintText: "enter your password",
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
                    onInputChanged: (val) {},
                    inputDecoration: const InputDecoration(
                      border: InputBorder.none,
                      hintText: "phone number",
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
                        },
                        // onPressed: () {
                        //   // i add here get for pop bottom
                        //   Get.snackbar("Sing up", "Successfully",
                        //       duration: const Duration(seconds: 1),
                        //       snackPosition: SnackPosition.BOTTOM);
                        // },
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
                        child: const Text("LOGIN"))
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
