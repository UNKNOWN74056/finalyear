// @dart=2.9
import 'dart:async';
import 'package:finalyear/AS%20A%20PLAYER/culturesport/culture_dashboard.dart';
import 'package:finalyear/AS%20A%20PLAYER/internationalsports/dashboard/dashboard.dart';
import 'package:finalyear/AS%20A%20PLAYER/internationalsports/dashboard/homedb.dart';
import 'package:finalyear/GETX/clubdatafirebase.dart';
import 'package:finalyear/GETX/getdatafromfirebase.dart';
import 'package:finalyear/pages/forgotpassword.dart';
import 'package:finalyear/pages/loginpage.dart';
import 'package:finalyear/pages/signuppage.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  //keep user login 
  User user;

  // getx controller to fetch firebase data
  final usercontroller = Get.put(FetchDataFirebase());
  final clubcontroller = Get.put(Getclubdata());

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
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blueGrey,
          ),
          debugShowCheckedModeBanner: false,
          initialRoute: user != null ? Homedb.routname : loginpage.routname,
          routes: {
            //splashscreen.routname: (context) => const splashscreen(),
            loginpage.routname: (context) => const loginpage(),
            Homedb.routname: (context) => const Homedb(),
            forgotpassword.routname: (context) => const forgotpassword(),
            signuppage.routname: (context) => const signuppage(),
            dashboard.routname: (context) => const dashboard(),
            culturedashboard.routname: (context) => const culturedashboard(),
          },
        );
      },
    );
  }

  @override
  void initState() {
    usercontroller.GetDataFirebase();
    clubcontroller.Getclubdatafirebase();
    user = FirebaseAuth.instance.currentUser;
    super.initState();
  }
}
