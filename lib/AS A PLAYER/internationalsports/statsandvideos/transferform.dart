import 'package:finalyear/wedgets/reusebletextfield.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class transferform extends StatefulWidget {
  const transferform({super.key});

  @override
  State<transferform> createState() => _transferformState();
}

//these are the controller
TextEditingController emailto = TextEditingController();
TextEditingController message = TextEditingController();

//dispose function
@override
void dispose() {
  emailto.dispose();
  message.dispose();
}

final key4 = GlobalKey<FormState>();

class _transferformState extends State<transferform> {
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
          key: key4,
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
                controller: emailto,
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
                controller: message,
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
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Center(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        if (key4.currentState!.validate()) {}
                      },
                      icon: const Icon(
                        FontAwesomeIcons.check,
                        color: Colors.green,
                      ),
                      label: const Text("CONFERM"),
                    ),
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
