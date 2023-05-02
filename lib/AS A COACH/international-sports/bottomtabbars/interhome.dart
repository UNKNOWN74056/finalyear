import 'package:finalyear/AS%20A%20COACH/culture-sport/cultureplayerdb.dart';
import 'package:finalyear/wedgets/search_engine_for_user.dart';
import 'package:get/get.dart';
import 'package:finalyear/AS%20A%20COACH/international-sports/tabs/player-basketball.dart';
import 'package:finalyear/AS%20A%20COACH/international-sports/tabs/player-cricket.dart';
import 'package:finalyear/AS%20A%20COACH/international-sports/tabs/player-football.dart';
import 'package:finalyear/AS%20A%20COACH/international-sports/tabs/player-hockey.dart';
import 'package:finalyear/AS%20A%20COACH/international-sports/tabs/player-tabletenis.dart';
import 'package:finalyear/AS%20A%20COACH/international-sports/tabs/player-vulleyball.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import '../../../AS A PLAYER/internationalsports/dashboard/home.dart';

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
                          icon: const Icon(Icons.search)),
                    ),
                    PopupMenuButton(
                      position: PopupMenuPosition.under,
                      icon: const Icon(Icons.more_horiz),
                      itemBuilder: ((context) => [
                            PopupMenuItem(
                                child: GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, cultureplayerdb.routname);
                              },
                              child: const Text("Culture sports"),
                            ))
                          ]),
                    )
                  ],
                  automaticallyImplyLeading: false,
                  expandedHeight: 200,
                  pinned: true,
                  floating: true,
                  snap: true,
                  title: const Text(
                    "INTERNATIONAL",
                    style: TextStyle(fontWeight: FontWeight.bold),
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
