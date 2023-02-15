import 'package:finalyear/GETX/tournamentRegister.dart';
import 'package:finalyear/wedgets/loginbutton.dart';
import 'package:finalyear/wedgets/reusebletextfield.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class registration extends StatefulWidget {
  const registration({super.key});

  @override
  State<registration> createState() => _registrationState();
}

final controller = Get.put(TournamentsRegistration());

class _registrationState extends State<registration> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "REGISTRATION",
        ),
      ),
      body: SingleChildScrollView(
          child: Container(
        margin: const EdgeInsets.all(10.0),
        child: Form(
          key: controller.regkeyForm,
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.only(
                  top: 25,
                ),
                child: Text(
                  "Registration Form",
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text("Team Name:",
                  style: TextStyle(
                    fontSize: 15,
                  )),
              const SizedBox(
                height: 10,
              ),
              reusebletextfield(
                  controller: controller.teamnamecontroller,
                  autoValidateMode: AutovalidateMode.onUserInteraction,
                  keyboard: TextInputType.name,
                  validator: (Value) {
                    return controller.validteamname(Value!);
                  },
                  icon: const Icon(FontAwesomeIcons.users),
                  labelText: "Enter your team name"),
              const SizedBox(
                height: 10,
              ),
              const Text("Captain Name:",
                  style: TextStyle(
                    fontSize: 15,
                  )),
              const SizedBox(
                height: 10,
              ),
              reusebletextfield(
                  controller: controller.teamnamecontroller,
                  autoValidateMode: AutovalidateMode.onUserInteraction,
                  keyboard: TextInputType.name,
                  validator: (Value) {
                    return controller.validcaptainname(Value!);
                  },
                  icon: const Icon(FontAwesomeIcons.solidUser),
                  labelText: "Enter captain name"),
              const Text("Address",
                  style: TextStyle(
                    fontSize: 15,
                  )),
              const SizedBox(
                height: 10,
              ),
              reusebletextfield(
                  controller: controller.addresscontroller,
                  autoValidateMode: AutovalidateMode.onUserInteraction,
                  keyboard: TextInputType.name,
                  validator: (Value) {
                    return controller.validaddress(Value!);
                  },
                  icon: const Icon(FontAwesomeIcons.locationDot),
                  labelText: "Enter your address"),
              const Text("City",
                  style: TextStyle(
                    fontSize: 15,
                  )),
              const SizedBox(
                height: 10,
              ),
              reusebletextfield(
                  controller: controller.citycontroller,
                  autoValidateMode: AutovalidateMode.onUserInteraction,
                  keyboard: TextInputType.name,
                  validator: (Value) {
                    return controller.validcitye(Value!);
                  },
                  icon: Icon(FontAwesomeIcons.city),
                  labelText: "Enter your city"),
              const Text("Contact Email",
                  style: TextStyle(
                    fontSize: 15,
                  )),
              const SizedBox(
                height: 10,
              ),
              reusebletextfield(
                  controller: controller.emailcontroller,
                  autoValidateMode: AutovalidateMode.onUserInteraction,
                  keyboard: TextInputType.emailAddress,
                  validator: (Value) {
                    return controller.validEmail(Value!);
                  },
                  icon: const Icon(FontAwesomeIcons.solidEnvelope),
                  labelText: "Enter your email"),
              const SizedBox(
                height: 10,
              ),
              loginbutton(
                  onTap: () {
                    controller.checkregisteration();
                    if (controller.isformValidated == true) {}
                  },
                  child: const Text("Submitt"))
            ],
          ),
        ),
      )),
    ));
  }
}
