import 'package:finalyear/AS%20A%20PLAYER/culturesport/culture_dashboard.dart';
import 'package:finalyear/AS%20A%20PLAYER/internationalsports/dashboard/dashboard.dart';
import 'package:finalyear/wedgets/homedbwedget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Homedb extends StatefulWidget {
  //route name
  static const String routname = 'Home_db';
  const Homedb({super.key});

  @override
  State<Homedb> createState() => _HomedbState();
}

class _HomedbState extends State<Homedb> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, dashboard.routname);
                      },
                    )),
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
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, culturedashboard.routname);
                      },
                    )),
              ],
            ),
          )),
    );
  }
}
