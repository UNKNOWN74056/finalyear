import 'package:finalyear/splashscreen/splashservices.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class splashscreen extends StatefulWidget {
  //route name
  static const String routname = 'splash_screen';

  const splashscreen({super.key});

  @override
  State<splashscreen> createState() => _splashscreenState();
}

class _splashscreenState extends State<splashscreen> {
  splashservice splash_screen = splashservice();

  @override
  void initState() {
    super.initState();

    splash_screen.islogin(BuildContext, context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          width: double.infinity,
          height: double.infinity,
          child: const Center(child: CircularProgressIndicator())),
    );
  }
}
