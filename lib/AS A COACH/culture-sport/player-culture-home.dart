import 'package:finalyear/AS%20A%20COACH/culture-sport/tabs/player-culture-archery.dart';
import 'package:finalyear/AS%20A%20COACH/culture-sport/tabs/player-culture-gymnastic.dart';
import 'package:finalyear/AS%20A%20COACH/culture-sport/tabs/player-culture-kabaddi.dart';
import 'package:finalyear/AS%20A%20COACH/culture-sport/tabs/player-culture-tent-pagging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../AS A PLAYER/internationalsports/dashboard/homedb.dart';

class playerculturehome extends StatefulWidget {
  const playerculturehome({super.key});

  @override
  State<playerculturehome> createState() => _playerculturehomeState();
}

class _playerculturehomeState extends State<playerculturehome> {
  @override
  Widget build(BuildContext context) => SafeArea(
        child: DefaultTabController(
          length: 4,
          child: Scaffold(
            body: NestedScrollView(
              floatHeaderSlivers: true,
              headerSliverBuilder: (context, innerBoxIsScrolled) => [
                SliverAppBar(
                  actions: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: IconButton(
                          onPressed: () => Get.to(() => (const Homedb())),
                          icon: const Icon(Icons.search)),
                    ),
                    Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: IconButton(
                          onPressed: () => Get.to(() => (const Homedb())),
                          icon: const Icon(Icons.camera_alt),
                        ))
                  ],
                  expandedHeight: 200,
                  pinned: true,
                  floating: true,
                  snap: true,
                  title: const Text(
                    "Culture sport",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                   flexibleSpace: FlexibleSpaceBar(
                      background: Image.asset(
                    "assets/mixsport.jpeg",
                    fit: BoxFit.cover,
                  )),
                  centerTitle: true,
                  bottom: const TabBar(
                      indicatorColor: Colors.orange,
                      indicatorWeight: 5,
                      isScrollable: true,
                      labelStyle: TextStyle(fontSize: 20),
                      tabs: [
                        Text("Archery"),
                        Text("Kabaddi"),
                        Text("Tent pagging"),
                        Text("Gymnastic"),
                      ]),
                )
              ],
              body: const TabBarView(children: [
                playerculturearchery(),
                playerculturekabaddi(),
                playerculturetentpagging(),
                playerculturegymnastic()
              ]),
            ),
          ),
        ),
      );
}
