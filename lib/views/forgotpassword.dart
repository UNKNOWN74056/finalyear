import 'package:finalyear/GETX/forgotpassword.dart';
import 'package:finalyear/functions/functions.dart';
import 'package:finalyear/components/loginbutton.dart';
import 'package:finalyear/components/reusebletextfield.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class forgotpassword extends StatefulWidget {
  const forgotpassword({super.key});

  @override
  State<forgotpassword> createState() => _forgotpasswordState();
}

class _forgotpasswordState extends State<forgotpassword> {
  //getx controller
  final controller = Get.put(ForgotPassword());

  @override
  void dispose() {
    controller.emailverify.text = " ";
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: controller.forgotkeyForm,
          child: Column(children: [
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Container(
                child: const Center(
                  child: Text(
                    "FORGOT PASSWORD ",
                    style: TextStyle(fontSize: 30),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            const Text(
              "Please enter your email to verify it.",
              style: TextStyle(fontSize: 15),
            ),
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: reusebletextfield(
                autoValidateMode: AutovalidateMode.onUserInteraction,
                validator: (Value) {
                  return controller.validEmail(Value!);
                },
                controller: controller.emailverify,
                labelText: "EMAIL",
                icon: const Icon(
                  FontAwesomeIcons.solidUser,
                  color: Color.fromARGB(255, 4, 45, 119),
                ),
                keyboard: TextInputType.emailAddress,
              ),
            ),

            //button for varification of your email to reset your password
            loginbutton(
                onTap: () {
                  controller.checkemailverify();
                  if (controller.isformValidated == true) {
                    functions.emailverify();
                  }
                  dispose();
                },
                child: const Text("Send Email"))
          ]),
        ),
      ),
    ));
  }
}
