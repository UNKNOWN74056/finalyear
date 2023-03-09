// @dart=2.9
import 'package:finalyear/GETX/clubdatafirebase.dart';
import 'package:finalyear/GETX/getdatafromfirebase.dart';
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
            home: const splashscreen());
      },
    );
  }

  @override
  void initState() {
    usercontroller.GetDataFirebase();
    clubcontroller.Getclubdatafirebase();
    super.initState();
  }
}
