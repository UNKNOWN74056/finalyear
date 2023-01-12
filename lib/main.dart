import 'package:finalyear/splashscreen/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {MyApp({super.key});

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
            title: 'Flutter Demo',
            theme: ThemeData(
              primarySwatch: Colors.blueGrey,
            ),
            debugShowCheckedModeBanner: false,
            home: const splashscreen());
      },
    );
  }
}
