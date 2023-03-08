
import 'package:finalyear/GETX/transferform.dart';
import 'package:finalyear/wedgets/loginbutton.dart';
import 'package:finalyear/wedgets/reusebletextfield.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class transferform extends StatefulWidget {
  const transferform({super.key});

  @override
  State<transferform> createState() => _transferformState();
}

final controller = Get.put(TransFerForm());

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
        margin: const EdgeInsets.all(10.0),
        child: Form(
          key: controller.keyForm,
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
                controller: controller.emailController,
                validator: (Value) {
                  return controller.validEmail(Value!);
                },
                autoValidateMode: AutovalidateMode.onUserInteraction,
                labelText: "Enter Email",
                icon: const Icon(FontAwesomeIcons.solidEnvelope,
                    color: Color.fromARGB(255, 4, 45, 119)),
                keyboard: TextInputType.emailAddress,
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
                maxline: 10,
                maxlength: 120,
                controller: controller.messagecontroller,
                validator: (Value) {
                  return controller.validmessage(Value!);
                },
                autoValidateMode: AutovalidateMode.onUserInteraction,
                icon: const Icon(
                  FontAwesomeIcons.solidMessage,
                  color: Color.fromARGB(255, 4, 45, 119),
                ),
                labelText: "Enter your message",
                keyboard: TextInputType.text,
              ),
              const SizedBox(
                height: 40,
              ),
              loginbutton(
                  onTap: () async {
                    controller.checktransfer();
                    if (controller.isformValidated == true) {}
                  },
                  child: const Text("Confirm Transfer"))
            ],
          ),
        ),
      )),
    ));
  }
}
