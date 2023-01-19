import 'dart:ui';

import 'package:finalyear/AS%20A%20PLAYER/internationalsports/dashboard/profile.dart';
import 'package:finalyear/wedgets/reusebletextfield.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class transferform extends StatefulWidget {
  const transferform({super.key});

  @override
  State<transferform> createState() => _transferformState();
}

final _formKey = GlobalKey<FormState>();

class _transferformState extends State<transferform> {
  //these are the controller
  TextEditingController transfercontroller = TextEditingController();
  TextEditingController messagecontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("TRANSFER"),
      ),
      body: SingleChildScrollView(
          child: Container(
        margin: EdgeInsets.all(10.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Row(
                children: const [
                  Padding(
                    padding: EdgeInsets.only(top: 25, left: 20),
                    child: Text(
                      "Transfer Request",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: const [
                  Padding(
                    padding: EdgeInsets.only(top: 50, left: 20),
                    child: Text(
                      "To:",
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              reusebletextfield(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                controller: transfercontroller,
                validator: (Value) {
                  return Value.isEmpty ? "enter your email" : null;
                },
                autoValidateMode: AutovalidateMode.onUserInteraction,
                labelText: "Enter Email",
                icon: const Icon(FontAwesomeIcons.solidEnvelope,
                    color: Color.fromARGB(255, 4, 45, 119)),
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                children: const [
                  Padding(
                    padding: EdgeInsets.only(left: 15),
                    child: Text(
                      "Message:",
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              reusebletextfield(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                maxline: 10,
                maxlength: 120,
                controller: messagecontroller,
                validator: (Value) {
                  return Value.isEmpty ? "enter your message" : null;
                },
                autoValidateMode: AutovalidateMode.onUserInteraction,
                icon: const Icon(
                  FontAwesomeIcons.solidMessage,
                  color: Color.fromARGB(255, 4, 45, 119),
                ),
                labelText: "Enter your message",
              ),
              const SizedBox(
                height: 40,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 50, right: 50),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton.icon(
                        onPressed: () => Get.to(const profile()),
                        icon: const FaIcon(
                          FontAwesomeIcons.trash,
                          color: Colors.red,
                        ),
                        label: const Text("CANCEL"),
                      ),
                      ElevatedButton.icon(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Processing Data')),
                            );
                          }
                        },
                        icon: const FaIcon(
                          FontAwesomeIcons.check,
                          color: Colors.green,
                        ),
                        label: const Text("CONFERM"),
                      ),
                    ]),
              ),
            ],
          ),
        ),
      )),
    ));
  }
}
