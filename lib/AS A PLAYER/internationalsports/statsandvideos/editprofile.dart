import 'package:finalyear/wedgets/reusebletextfield.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class editprofile extends StatefulWidget {
  const editprofile({super.key});

  @override
  State<editprofile> createState() => _editprofileState();
}

final _formKey = GlobalKey<FormState>();

class _editprofileState extends State<editprofile> {
  TextEditingController editfirstname = TextEditingController();
  TextEditingController editlastname = TextEditingController();
  TextEditingController editemail = TextEditingController();
  TextEditingController editephonenumber = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: const Text(
          "Edit profile",
          style: TextStyle(fontSize: 25),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(children: [
              const Center(
                  child: Text(
                "please fill the following details \n in order to edit your profile.",
                style: TextStyle(fontSize: 15),
              )),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                      onTap: () async {},
                      child: Container(
                          child: CircleAvatar(
                        radius: 70,
                        backgroundColor: Colors.pink,
                        child: Image.asset("assets/mixsport.jpeg"),
                      ))),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              reusebletextfield(
                  autoValidateMode: AutovalidateMode.onUserInteraction,
                  controller: editfirstname,
                  validator: (Value) {
                    return Value.isEmpty ? "enter your first name" : null;
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  labelText: "First Name",
                  icon: const Icon(
                    FontAwesomeIcons.solidUser,
                    color: Color.fromARGB(255, 4, 45, 119),
                  )),
              const SizedBox(
                height: 20,
              ),
              reusebletextfield(
                  autoValidateMode: AutovalidateMode.onUserInteraction,
                  controller: editfirstname,
                  validator: (Value) {
                    return Value.isEmpty ? "enter your last name" : null;
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  labelText: "last Name",
                  icon: const Icon(
                    FontAwesomeIcons.solidUser,
                    color: Color.fromARGB(255, 4, 45, 119),
                  )),
              const SizedBox(
                height: 20,
              ),
              reusebletextfield(
                  autoValidateMode: AutovalidateMode.onUserInteraction,
                  controller: editfirstname,
                  validator: (Value) {
                    return Value.isEmpty ? "enter your email" : null;
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  labelText: "Email",
                  icon: const Icon(
                    FontAwesomeIcons.solidEnvelope,
                    color: Color.fromARGB(255, 4, 45, 119),
                  )),
              const SizedBox(
                height: 20,
              ),
              const SizedBox(
                height: 20,
              ),
              InternationalPhoneNumberInput(
                  autoValidateMode: AutovalidateMode.onUserInteraction,
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
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Processing Data')),
                      );
                    }
                  },
                  child: const Text("Save changes"))
            ]),
          ),
        ),
      ),
    ));
  }
}
