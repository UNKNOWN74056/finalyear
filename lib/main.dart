import 'dart:async';
import 'package:finalyear/views/AS%20A%20COACH/culture-sport/cultureplayerdb.dart';
import 'package:finalyear/views/AS%20A%20COACH/culture-sport/player-culture-home.dart';
import 'package:finalyear/views/AS%20A%20COACH/international-sports/bottomtabbars/interhome.dart';
import 'package:finalyear/views/AS%20A%20COACH/international-sports/playerdashboard.dart';
import 'package:finalyear/views/AS%20A%20PLAYER/culturesport/culture_dashboard.dart';
import 'package:finalyear/views/AS%20A%20PLAYER/internationalsports/dashboard/dashboard.dart';
import 'package:finalyear/views/forgotpassword.dart';
import 'package:finalyear/views/loginpage.dart';
import 'package:finalyear/views/signuppage.dart';
import 'package:finalyear/view_model/splashscreen/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Stripe.publishableKey =
      "pk_test_51NY1EmL4v0vSdiaO9Bfhg7tWPfSMo4fF3SzSS7OWZ7p06Bbyb41oxQYEOWHGutvwezpqCP3wa5iiLdkWoyRLst7G00n0q1DeAr";
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          Get.snackbar("Error", "Something went wrong!");
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        return GetMaterialApp(
          title: 'Mr Sports',
          theme: ThemeData.light().copyWith(useMaterial3: true),
          debugShowCheckedModeBanner: false,
          home: const splashscreen(),
          routes: {
            splashscreen.routname: (context) => const splashscreen(),
            loginpage.routname: (context) => const loginpage(),
            interhome.routname: (context) => const interhome(),
            playerculturehome.routname: (context) => const playerculturehome(),
            playerdashboeard.routname: (context) => const playerdashboeard(),
            cultureplayerdb.routname: (context) => const cultureplayerdb(),
            forgotpassword.routname: (context) => const forgotpassword(),
            signuppage.routname: (context) => const signuppage(),
            dashboard.routname: (context) => const dashboard(),
            culturedashboard.routname: (context) => const culturedashboard(),
          },
        );
      },
    );
  }
}
