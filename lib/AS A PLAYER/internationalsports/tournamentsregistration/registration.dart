import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finalyear/AS%20A%20PLAYER/internationalsports/dashboard/tournaments.dart';
import 'package:finalyear/GETX/tournamentRegister.dart';
import 'package:finalyear/model/tournamentrequestmodel.dart';
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
Future<void> sendRequest(BuildContext context) async {
  final request = TournamentRegistrationRequest(
    teamName: controller.teamnamecontroller.text,
    captainName: controller.captainnamecontroller.text,
    address: controller.addresscontroller.text,
    city: controller.citycontroller.text,
    contactEmail: controller.emailcontroller.text,
  );

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
                  controller: controller.captainnamecontroller,
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
                  icon: const Icon(FontAwesomeIcons.city),
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
