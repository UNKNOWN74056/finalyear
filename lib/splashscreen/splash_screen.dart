import 'package:finalyear/splashscreen/splashservices.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class splashscreen extends StatefulWidget {
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
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomRight,
                colors: [Color(0xffac255e), Color(0xffca485c)])),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: const [
                CircleAvatar(
                  radius: 130,
                  backgroundImage: AssetImage("assets/mixsport.jpeg"),
                ),
                SizedBox(
                  height: 40,
                ),
                Text(
                  "Welcome To Mr.Sports",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 35,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const CircularProgressIndicator()
          ],
        ),
      ),
    );
  }
}
