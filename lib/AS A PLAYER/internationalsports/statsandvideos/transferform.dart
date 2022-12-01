import 'package:finalyear/AS%20A%20PLAYER/internationalsports/dashboard/profile.dart';
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
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Transfer"),
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
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
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
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ],
              ),
              TextFormField(
                  decoration: InputDecoration(
                      label: const Text("Enter Email"),
                      hintText: "Enter email",
                      prefixIcon: const Icon(Icons.email),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      )),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "please enter your username";
                    } else {
                      return null;
                    }
                  }),
              const SizedBox(
                height: 30,
              ),
              Row(
                children: const [
                  Padding(
                    padding: EdgeInsets.only(left: 15),
                    child: Text(
                      "Message:",
                      style: TextStyle(fontSize: 20),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25)),
                    hintText: "Enter your message",
                  ),
                  maxLines: 10,
                  maxLength: 120,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "please enter your username";
                    } else {
                      return null;
                    }
                  }),
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
                        icon: const FaIcon(FontAwesomeIcons.trash),
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
                        icon: const FaIcon(FontAwesomeIcons.check),
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
