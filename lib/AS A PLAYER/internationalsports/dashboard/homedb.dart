import 'package:finalyear/AS%20A%20PLAYER/culturesport/culture_dashboard.dart';
import 'package:finalyear/AS%20A%20PLAYER/internationalsports/dashboard/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Homedb extends StatefulWidget {
  const Homedb({super.key});

  @override
  State<Homedb> createState() => _HomedbState();
}

class _HomedbState extends State<Homedb> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(centerTitle: true, title: const Text("Mr.Sports")),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "WHAT SPORT DO YOU INTEREST?",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                " International Sports",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 15.0),
              InkWell(
                onTap: () {
                  Get.to(const dashboard());
                },
                child: Container(
                  height: 300,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: AssetImage(
                            "assets/interna.jpeg",
                          ))),
                ),
              ),
              const SizedBox(height: 30.0),
              const Text(
                " Cultural Sports",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              const SizedBox(height: 15.0),
              Expanded(
                child: InkWell(
                  onTap: () {
                    Get.to(const culturedashboard());
                  },
                  child: Container(
                    height: 300,
                    width: double.infinity,
                    // color: Colors.amber,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage(
                              "assets/culture.jpeg",
                            ))),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
