import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finalyear/AS%20A%20PLAYER/internationalsports/dashboard/tournaments.dart';
import 'package:finalyear/GETX/tournamentRegister.dart';
import 'package:finalyear/model/tournamentrequestmodel.dart';
import 'package:finalyear/wedgets/loginbutton.dart';
import 'package:finalyear/wedgets/reusebletextfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class registration extends StatefulWidget {
  const registration({super.key});

  @override
  State<registration> createState() => _registrationState();
}

final controller = Get.put(TournamentsRegistration());
final currentuser = FirebaseAuth.instance.currentUser!.email;
Future<void> sendRequest(BuildContext context) async {
  final request = TournamentRegistrationRequest(
      teamName: controller.teamnamecontroller.text,
      captainName: controller.captainnamecontroller.text,
      address: controller.addresscontroller.text,
      city: controller.citycontroller.text,
      contactEmail: controller.emailcontroller.text,
      contact: controller.contactcontroller.text,
      sportevent: controller.sporteventcontroller.text,
      player1: controller.player1controller.text,
      player2: controller.player2controller.text,
      player3: controller.player3controller.text,
      player4: controller.player4controller.text,
      player5: controller.player5controller.text,
      player6: controller.player6controller.text,
      player7: controller.player7controller.text,
      player8: controller.player8controller.text,
      player9: controller.player9controller.text,
      player10: controller.player10controller.text,
      player11: controller.player11controller.text,
      player12: controller.player12controller.text,
      sentby: currentuser.toString());

  try {
    final collectionRef =
        FirebaseFirestore.instance.collection('registrationRequests');
    final documentRef = await collectionRef.add(request.toJson());

    // Assign the generated document ID to the request
    final generatedId = documentRef.id;
    await documentRef.update({'document': generatedId});

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Request Sent'),
        content: const Text('Your registration request has been sent.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: GestureDetector(
                onTap: () {
                  Get.to(const tournaments());
                },
                child: const Text('OK')),
          ),
        ],
      ),
    );
  } catch (error) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Error'),
        content: const Text('An error occurred while sending the request.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: GestureDetector(
                onTap: () {
                  Get.to(const tournaments());
                },
                child: const Text('OK')),
          ),
        ],
      ),
    );
  }
}

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
                      sendRequest(context);
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
