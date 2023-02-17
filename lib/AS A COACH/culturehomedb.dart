import 'package:finalyear/AS%20A%20COACH/culture-sport/cultureplayerdb.dart';
import 'package:finalyear/AS%20A%20COACH/international-sports/playerdashboard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../wedgets/homedbwedget.dart';

class culturehomedb extends StatefulWidget {
  const culturehomedb({super.key});

  @override
  State<culturehomedb> createState() => _culturehomedbState();
}

class _culturehomedbState extends State<culturehomedb> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: SafeArea(
      child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: const Text("Mr.Sports"),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                const Center(
                  child: Text(
                    "What Sports Do You Interests?",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Padding(
                  padding: EdgeInsets.only(right: 130),
                  child: Text(
                    "International Sports",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                //this is the home wedget
                homedbwedget(
                  imagepath: "assets/interna.jpeg",
                  child: InkWell(
                    onTap: () {
                      Get.to(const playerdashboeard());
                    },
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(right: 130),
                  child: Text(
                    "Culture Sports",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                //this is the home wedget
                homedbwedget(
                  imagepath: "assets/culture.jpeg",
                  child: InkWell(
                    onTap: () {
                      Get.to(const cultureplayerdb());
                    },
                  ),
                ),
              ],
            ),
          )),
    ));
  }
}
