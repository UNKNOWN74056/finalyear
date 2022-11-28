import 'package:finalyear/AS%20A%20COACH/culture-sport/cultureplayerdb.dart';
import 'package:finalyear/AS%20A%20COACH/international-sports/playerdashboard.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class culturehomedb extends StatefulWidget {
  const culturehomedb({super.key});

  @override
  State<culturehomedb> createState() => _culturehomedbState();
}

class _culturehomedbState extends State<culturehomedb> {
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
                " International Sports",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              const SizedBox(height: 15.0),
              InkWell(
                onTap: () {
                  Get.to(const playerdashboeard());
                },
                child: Container(
                  height: 300,
                  width: double.infinity,
                  // color: Colors.amber,
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
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              const SizedBox(height: 15.0),
              Expanded(
                child: InkWell(
                  onTap: () {
                    Get.to(const cultureplayerdb());
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
