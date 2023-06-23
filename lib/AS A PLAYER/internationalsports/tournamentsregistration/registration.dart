import 'package:finalyear/GETX/tournamentRegister.dart';
import 'package:finalyear/wedgets/loginbutton.dart';
import 'package:finalyear/wedgets/reusebletextfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../../functions/functions.dart';

class registration extends StatefulWidget {
  const registration({super.key});

  @override
  State<registration> createState() => _registrationState();
}

final controller = Get.put(TournamentsRegistration());
final currentuser = FirebaseAuth.instance.currentUser!.email;

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
              reusebletextfield(
                  controller: controller.captainnamecontroller,
                  autoValidateMode: AutovalidateMode.onUserInteraction,
                  keyboard: TextInputType.name,
                  validator: (Value) {
                    return controller.validcaptainname(Value!);
                  },
                  icon: const Icon(FontAwesomeIcons.solidUser),
                  labelText: "Enter captain name"),
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
                  icon: const Icon(FontAwesomeIcons.city),
                  labelText: "Enter your city"),
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
              reusebletextfield(
                  controller: controller.contactcontroller,
                  autoValidateMode: AutovalidateMode.onUserInteraction,
                  keyboard: TextInputType.phone,
                  validator: (Value) {
                    return controller.validphonenumber(Value!);
                  },
                  icon: const Icon(FontAwesomeIcons.phone),
                  labelText: " + Enter your number"),
              const SizedBox(
                height: 10,
              ),
              reusebletextfield(
                  controller: controller.sporteventcontroller,
                  autoValidateMode: AutovalidateMode.onUserInteraction,
                  keyboard: TextInputType.emailAddress,
                  validator: (Value) {
                    return controller.validsportname(Value!);
                  },
                  icon: const Icon(FontAwesomeIcons.phone),
                  labelText: "Enter your sport event corractly"),
              const SizedBox(
                height: 10,
              ),
              reusebletextfield(
                  controller: controller.player1controller,
                  autoValidateMode: AutovalidateMode.onUserInteraction,
                  keyboard: TextInputType.emailAddress,
                  validator: (Value) {
                    return controller.validplayername(Value!);
                  },
                  icon: const Icon(FontAwesomeIcons.person),
                  labelText: "Enter your player name"),
              const SizedBox(
                height: 10,
              ),
              reusebletextfield(
                  controller: controller.player2controller,
                  autoValidateMode: AutovalidateMode.onUserInteraction,
                  keyboard: TextInputType.emailAddress,
                  validator: (Value) {
                    return controller.validplayername(Value!);
                  },
                  icon: const Icon(FontAwesomeIcons.person),
                  labelText: "Enter your player name"),
              const SizedBox(
                height: 10,
              ),
              reusebletextfield(
                  controller: controller.player3controller,
                  autoValidateMode: AutovalidateMode.onUserInteraction,
                  keyboard: TextInputType.emailAddress,
                  validator: (Value) {
                    return controller.validplayername(Value!);
                  },
                  icon: const Icon(FontAwesomeIcons.person),
                  labelText: "Enter your player name"),
              const SizedBox(
                height: 10,
              ),
              reusebletextfield(
                  controller: controller.player4controller,
                  autoValidateMode: AutovalidateMode.onUserInteraction,
                  keyboard: TextInputType.emailAddress,
                  validator: (Value) {
                    return controller.validplayername(Value!);
                  },
                  icon: const Icon(FontAwesomeIcons.person),
                  labelText: "Enter your player name"),
              const SizedBox(
                height: 10,
              ),
              reusebletextfield(
                  controller: controller.player5controller,
                  autoValidateMode: AutovalidateMode.onUserInteraction,
                  keyboard: TextInputType.emailAddress,
                  validator: (Value) {
                    return controller.validplayername(Value!);
                  },
                  icon: const Icon(FontAwesomeIcons.person),
                  labelText: "Enter your player name"),
              const SizedBox(
                height: 10,
              ),
              reusebletextfield(
                  controller: controller.player6controller,
                  autoValidateMode: AutovalidateMode.onUserInteraction,
                  keyboard: TextInputType.emailAddress,
                  validator: (Value) {
                    return controller.validplayername(Value!);
                  },
                  icon: const Icon(FontAwesomeIcons.person),
                  labelText: "Enter your player name"),
              const SizedBox(
                height: 10,
              ),
              reusebletextfield(
                  controller: controller.player7controller,
                  autoValidateMode: AutovalidateMode.onUserInteraction,
                  keyboard: TextInputType.emailAddress,
                  validator: (Value) {
                    return controller.validplayername(Value!);
                  },
                  icon: const Icon(FontAwesomeIcons.person),
                  labelText: "Enter your player name"),
              const SizedBox(
                height: 10,
              ),
              reusebletextfield(
                  controller: controller.player8controller,
                  autoValidateMode: AutovalidateMode.onUserInteraction,
                  keyboard: TextInputType.emailAddress,
                  validator: (Value) {
                    return controller.validplayername(Value!);
                  },
                  icon: const Icon(FontAwesomeIcons.person),
                  labelText: "Enter your player name"),
              const SizedBox(
                height: 10,
              ),
              reusebletextfield(
                  controller: controller.player9controller,
                  autoValidateMode: AutovalidateMode.onUserInteraction,
                  keyboard: TextInputType.emailAddress,
                  validator: (Value) {
                    return controller.validplayername(Value!);
                  },
                  icon: const Icon(FontAwesomeIcons.person),
                  labelText: "Enter your player name"),
              const SizedBox(
                height: 10,
              ),
              reusebletextfield(
                  controller: controller.player10controller,
                  autoValidateMode: AutovalidateMode.onUserInteraction,
                  keyboard: TextInputType.emailAddress,
                  validator: (Value) {
                    return controller.validplayername(Value!);
                  },
                  icon: const Icon(FontAwesomeIcons.person),
                  labelText: "Enter your player name"),
              const SizedBox(
                height: 10,
              ),
              reusebletextfield(
                  controller: controller.player11controller,
                  autoValidateMode: AutovalidateMode.onUserInteraction,
                  keyboard: TextInputType.emailAddress,
                  validator: (Value) {
                    return controller.validplayername(Value!);
                  },
                  icon: const Icon(FontAwesomeIcons.person),
                  labelText: "Enter your player name"),
              const SizedBox(
                height: 10,
              ),
              reusebletextfield(
                  controller: controller.player12controller,
                  autoValidateMode: AutovalidateMode.onUserInteraction,
                  keyboard: TextInputType.emailAddress,
                  validator: (Value) {
                    return controller.validplayername(Value!);
                  },
                  icon: const Icon(FontAwesomeIcons.person),
                  labelText: "Enter your player name"),
              const SizedBox(
                height: 10,
              ),
              loginbutton(
                  onTap: () {
                    controller.checkregisteration();
                    if (controller.isformValidated == true) {
                      functions.sendRequest(context);
                    }
                  },
                  child: const Text("Submitt"))
            ],
          ),
        ),
      )),
    ));
  }
}
