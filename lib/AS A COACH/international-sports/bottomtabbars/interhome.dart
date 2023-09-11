import 'package:finalyear/wedgets/search_engine_for_user.dart';
import 'package:get/get.dart';
import 'package:finalyear/AS%20A%20COACH/international-sports/tabs/player-basketball.dart';
import 'package:finalyear/AS%20A%20COACH/international-sports/tabs/player-cricket.dart';
import 'package:finalyear/AS%20A%20COACH/international-sports/tabs/player-football.dart';
import 'package:finalyear/AS%20A%20COACH/international-sports/tabs/player-hockey.dart';
import 'package:finalyear/AS%20A%20COACH/international-sports/tabs/player-tabletenis.dart';
import 'package:finalyear/AS%20A%20COACH/international-sports/tabs/player-vulleyball.dart';
import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';

class interhome extends StatefulWidget {
  static const String routname = "interhome";
  const interhome({super.key});

  @override
  State<interhome> createState() => _interhomeState();
}

//images for swiper
var images = [
  'assets/football.jpg',
  'assets/basketball.jpg',
  'assets/vullyball.jpg',
  'assets/tabletanis.jpg',
  'assets/cricket.jpg',
  'assets/hockey.jpg',
];

class _interhomeState extends State<interhome> {
  @override
  Widget build(BuildContext context) => SafeArea(
        child: DefaultTabController(
          length: 6,
          child: SafeArea(
            child: Scaffold(
              body: NestedScrollView(
                floatHeaderSlivers: true,
                headerSliverBuilder: (context, innerBoxIsScrolled) => [
                  SliverAppBar(
                    actions: [
                      Padding(
                        padding: const EdgeInsets.only(left: 70),
                        child: IconButton(
                            onPressed: () {
                              Get.to(usersearchengine());
                            },
                            icon: const Icon(
                              Icons.search,
                              color: Colors.white,
                            )),
                      ),
                    ],
                    automaticallyImplyLeading: false,
                    expandedHeight: 200,
                    pinned: true,
                    floating: true,
                    snap: true,
                    title: const Text(
                      "INTERNATIONAL",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    flexibleSpace: FlexibleSpaceBar(
                      background: Swiper(
                        autoplay: true,
                        itemBuilder: (BuildContext context, int index) {
                          return ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: Image(
                              image: AssetImage(images[index]),
                              fit: BoxFit.cover,
                            ),
                          );
                        },
                        itemCount: 6,
                      ),
                    ),
                    centerTitle: true,
                    bottom: const TabBar(
                        indicatorColor: Colors.orange,
                        indicatorWeight: 5,
                        unselectedLabelColor:
                            Color.fromARGB(255, 194, 203, 208),
                        labelColor: Colors.white,
                        isScrollable: true,
                        labelStyle: TextStyle(fontSize: 20),
                        tabs: [
                          Text("Football"),
                          Text("Basketball"),
                          Text("volleyball"),
                          Text("Tabletennis"),
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
        ),
      );
}
