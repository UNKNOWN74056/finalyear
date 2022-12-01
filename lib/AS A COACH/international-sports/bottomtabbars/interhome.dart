import 'package:finalyear/AS%20A%20COACH/international-sports/playerdashboard.dart';
import 'package:finalyear/AS%20A%20COACH/international-sports/tabs/player-basketball.dart';
import 'package:finalyear/AS%20A%20COACH/international-sports/tabs/player-cricket.dart';
import 'package:finalyear/AS%20A%20COACH/international-sports/tabs/player-football.dart';
import 'package:finalyear/AS%20A%20COACH/international-sports/tabs/player-hockey.dart';
import 'package:finalyear/AS%20A%20COACH/international-sports/tabs/player-tabletenis.dart';
import 'package:finalyear/AS%20A%20COACH/international-sports/tabs/player-vulleyball.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../AS A PLAYER/internationalsports/dashboard/home.dart';
import '../../../AS A PLAYER/internationalsports/dashboard/homedb.dart';

class interhome extends StatefulWidget {
  const interhome({super.key});

  @override
  State<interhome> createState() => _interhomeState();
}

class _interhomeState extends State<interhome> {
  @override
  Widget build(BuildContext context) => SafeArea(
        child: DefaultTabController(
          length: 6,
          child: Scaffold(
            body: NestedScrollView(
              floatHeaderSlivers: true,
              headerSliverBuilder: (context, innerBoxIsScrolled) => [
                SliverAppBar(
                  actions: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: IconButton(
                          onPressed: () {
                            showSearch(
                                context: context,
                                delegate: CustomSearchDelegate());
                          },
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
                    "Internation sport",
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
                        Text("football"),
                        Text("Basketball"),
                        Text("vulleyball"),
                        Text("tabletenis"),
                        Text("Cricket"),
                        Text("Hockey"),
                      ]),
                )
              ],
              body: const TabBarView(children: [
                playerfootball(),
                playerbasketball(),
                playervulleyball(),
                playercricket(),
                playertabletenis(),
                palyerhockey()
              ]),
            ),
          ),
        ),
      );
}
