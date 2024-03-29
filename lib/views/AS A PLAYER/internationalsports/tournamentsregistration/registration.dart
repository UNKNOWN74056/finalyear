import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finalyear/GETX/tournamentRegister.dart';
import 'package:finalyear/components/loginbutton.dart';
import 'package:finalyear/components/reusebletextfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_typeahead/flutter_typeahead.dart';
import '../../../../functions/functions.dart';

class registration extends StatefulWidget {
  const registration({super.key});

  @override
  State<registration> createState() => _registrationState();
}

final controller = Get.put(TournamentsRegistration());
final currentuser = FirebaseAuth.instance.currentUser!.email;
final FirebaseFirestore firestore = FirebaseFirestore.instance;

class _registrationState extends State<registration> {
  @override
  void initState() {
    super.initState();
    controller.teamnamecontroller.text = "";
    controller.captainnamecontroller.text = "";
    controller.addresscontroller.text = " ";
    controller.citycontroller.text = "";
    controller.emailcontroller.text = "";
    controller.contactcontroller.text = "";
    controller.sporteventcontroller.text = "";
    controller.player1controller.text = "";
    controller.player2controller.text = "";
    controller.player3controller.text = "";
    controller.player4controller.text = "";
    controller.player5controller.text = "";
    controller.player6controller.text = "";
    controller.player7controller.text = "";
    controller.player8controller.text = "";
    controller.player9controller.text = "";
    controller.player10controller.text = "";
    controller.player11controller.text = "";
    controller.player12controller.text = "";
    controller.sportcontroller.text = "";
  }

  Map<String, dynamic>? paymentIntentData;
  Future<void> makePayment() async {
    try {
      paymentIntentData =
          await createPaymentIntent('20', 'USD'); //json.decode(response.body);
      // print('Response body==>${response.body.toString()}');
      await Stripe.instance
          .initPaymentSheet(
              paymentSheetParameters: SetupPaymentSheetParameters(
                  setupIntentClientSecret:
                      'sk_test_51NY1EmL4v0vSdiaOewK8nnWb6nsnwmEIfQD0nLTZtRR22bLsS7Zcbc4hjA7ZXcQjdASKjtmp2ckheD7ykUOnEuqO001NxtNUvs',
                  paymentIntentClientSecret:
                      paymentIntentData!['client_secret'],
                  //applePay: PaymentSheetApplePay.,
                  //googlePay: true,
                  //testEnv: true,
                  customFlow: true,
                  style: ThemeMode.dark,
                  // merchantCountryCode: 'US',
                  merchantDisplayName: 'Kashif'))
          .then((value) {});

      ///now finally display payment sheeet
      displayPaymentSheet();
    } catch (e, s) {
      print('Payment exception:$e$s');
    }
  }

  Future<List<String>> getSportEventSuggestions() async {
    // Replace this with your Firestore query to fetch sport event names
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection("tournaments").get();
    List<String> suggestions = [];

    for (var doc in snapshot.docs) {
      // Assuming sport event names are stored in a field named "sportevent"
      suggestions.add(doc["tournamentname"] as String);
    }

    return suggestions;
  }

  displayPaymentSheet() async {
    try {
      await Stripe.instance.presentPaymentSheet();

      setState(() {
        paymentIntentData = null;
      });
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('Payment Successful!'),
      ));
    } on StripeException {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('payment cancelled'),
      ));
    } catch (e) {
      print('$e');
    }
  }

  //  Future<Map<String, dynamic>>
  createPaymentIntent(String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': calculateAmount('20'),
        'currency': currency,
        'payment_method_types[]': 'card',
      };
      print(body);
      var response = await http.post(
          Uri.parse('https://api.stripe.com/v1/payment_intents'),
          body: body,
          headers: {
            'Authorization': 'Bearer '
                'sk_test_51NY1EmL4v0vSdiaOewK8nnWb6nsnwmEIfQD0nLTZtRR22bLsS7Zcbc4hjA7ZXcQjdASKjtmp2ckheD7ykUOnEuqO001NxtNUvs',
            'Content-Type': 'application/x-www-form-urlencoded'
          });
      print('Create Intent reponse ===> ${response.body.toString()}');
      return jsonDecode(response.body);
    } catch (err) {
      print('err charging user: ${err.toString()}');
    }
  }

  calculateAmount(String amount) {
    final a = (int.parse(amount)) * 100;
    return a.toString();
  }

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
                  autoValidateMode: AutovalidateMode.onUserInteraction,
                  keyboard: TextInputType.emailAddress,
                  validator: (Value) {
                    return controller.validaddress(Value!);
                  },
                  icon: const Icon(FontAwesomeIcons.locationDot),
                  labelText: 'Enter your address.'),
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
              // Dropdown menu for sport event
              TypeAheadField<String>(
                textFieldConfiguration: TextFieldConfiguration(
                  controller: controller.sporteventcontroller,
                  decoration: const InputDecoration(
                    labelText: "Enter Sport Event",
                    labelStyle: TextStyle(
                        color: Colors.black), // Customize label text color
                    filled: true,
                    fillColor: Colors.white,
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.black), // Black outline border
                    ),
                    prefixIcon: Icon(FontAwesomeIcons.futbol,
                        color: Colors.black), // Icon inside the text field
                  ),
                ),
                suggestionsCallback: (pattern) async {
                  List<String> suggestions = await getSportEventSuggestions();
                  return suggestions
                      .where((event) =>
                          event.toLowerCase().contains(pattern.toLowerCase()))
                      .toList();
                },
                itemBuilder: (context, suggestion) {
                  return ListTile(
                    title: Text(suggestion),
                  );
                },
                onSuggestionSelected: (suggestion) {
                  setState(() {
                    controller.sporteventcontroller.text = suggestion;
                  });
                },
              ),

              const SizedBox(
                height: 10,
              ),
              reusebletextfield(
                  controller: controller.sportcontroller,
                  autoValidateMode: AutovalidateMode.onUserInteraction,
                  keyboard: TextInputType.emailAddress,
                  validator: (Value) {
                    return controller.validsportname(Value!);
                  },
                  icon: const Icon(FontAwesomeIcons.futbol),
                  labelText: "Enter your sport name"),
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
              Container(
                width: double.infinity,
                height: 60,
                color: const Color.fromARGB(255, 2, 5, 7),
                child: ElevatedButton(
                  onPressed: () async {
                    await makePayment();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(0, 20, 20, 20),
                  ),
                  child: const Text(
                    'Pay Your Payment',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              loginbutton(
                  onTap: () {
                    controller.checkregisteration();
                    try {
                      if (controller.isformValidated == true) {
                        functions.sendRequest(context);
                        Get.back();
                        Get.snackbar(
                          "Message",
                          "Your registration request has been send.",
                          backgroundColor: Colors.green,
                          colorText: Colors.white,
                        );
                      }
                    } catch (e) {
                      Get.snackbar(
                        "Error",
                        "Error while sending request.",
                        backgroundColor: Colors.red,
                        colorText: Colors.white,
                      );
                    }
                  },
                  child: const Text("Submit"))
            ],
          ),
        ),
      )),
    ));
  }
}
