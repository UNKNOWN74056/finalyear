// @dart=2.9
import 'dart:async';
import 'package:finalyear/AS%20A%20COACH/culture-sport/cultureplayerdb.dart';
import 'package:finalyear/AS%20A%20COACH/culture-sport/player-culture-home.dart';
import 'package:finalyear/AS%20A%20COACH/international-sports/bottomtabbars/interhome.dart';
import 'package:finalyear/AS%20A%20COACH/international-sports/playerdashboard.dart';
import 'package:finalyear/AS%20A%20PLAYER/culturesport/culture_dashboard.dart';
import 'package:finalyear/AS%20A%20PLAYER/internationalsports/dashboard/dashboard.dart';
import 'package:finalyear/pages/forgotpassword.dart';
import 'package:finalyear/pages/loginpage.dart';
import 'package:finalyear/pages/signuppage.dart';
import 'package:finalyear/splashscreen/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final Future<FirebaseApp> _initailization = Firebase.initializeApp();

  // comment
  @override
  Widget build(BuildContext context) {
    // i add get here GetMaterialApp
    return FutureBuilder(
      future: _initailization,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          Get.snackbar("Error", "Somthing went wrong!");
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        return GetMaterialApp(
          title: 'Mr Sports',
          theme: ThemeData(
            primarySwatch: Colors.blueGrey,
          ),
          debugShowCheckedModeBanner: false,
          initialRoute: splashscreen.routname,
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
