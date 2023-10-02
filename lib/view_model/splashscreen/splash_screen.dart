import 'package:finalyear/view_model/splashscreen/splashservices.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

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

    splash_screen.islogin(context);
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Center(
            child: SpinKitFadingCircle(
              color: Colors.red, // Set the color of the SpinKit indicator
              size: 50.0, // Set the size of the indicator as needed
            ),
          )),
    );
  }
}
