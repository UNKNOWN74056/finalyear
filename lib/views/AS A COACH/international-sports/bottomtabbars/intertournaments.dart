import 'package:finalyear/views/AS%20A%20COACH/international-sports/intertournaments/player-tour-basketball.dart';
import 'package:finalyear/views/AS%20A%20COACH/international-sports/intertournaments/player-tour-cricket.dart';
import 'package:finalyear/views/AS%20A%20COACH/international-sports/intertournaments/player-tour-football.dart';
import 'package:finalyear/views/AS%20A%20COACH/international-sports/intertournaments/player-tour-hockey.dart';
import 'package:finalyear/views/AS%20A%20COACH/international-sports/intertournaments/player-tour-vulleyball.dart';
import 'package:finalyear/views/AS%20A%20COACH/international-sports/intertournaments/player-your-tabletenis.dart';
import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import '../../../AS A PLAYER/internationalsports/tournamentsregistration/registration.dart';

class intertournaments extends StatefulWidget {
  const intertournaments({super.key});

  @override
  State<intertournaments> createState() => _intertournamentsState();
}

class _intertournamentsState extends State<intertournaments> {
  //images for swiper
  var images = [
    'assets/football.jpg',
    'assets/basketball.jpg',
    'assets/vullyball.jpg',
    'assets/tabletanis.jpg',
    'assets/cricket.jpg',
    'assets/hockey.jpg',
  ];
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
                  automaticallyImplyLeading: false,
                  actions: [
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: IconButton(
                          onPressed: () => Get.to(() => (const registration())),
                          icon: const FaIcon(
                            FontAwesomeIcons.trophy,
                            color: Colors.white,
                          )),
                    ),
                  ],
                  expandedHeight: 200,
                  pinned: true,
                  floating: true,
                  snap: true,
                  title: const Text(
                    "Tournaments",
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
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
                    centerTitle: true,
                  ),
                  centerTitle: true,
                  bottom: const TabBar(
                      indicatorColor: Colors.orange,
                      indicatorWeight: 5,
                      unselectedLabelColor: Color.fromARGB(255, 194, 203, 208),
                      labelColor: Colors.white,
                      isScrollable: true,
                      labelStyle: TextStyle(fontSize: 20),
                      tabs: [
                        Text("football"),
                        Text("Basketball"),
                        Text("volleyball"),
                        Text("tabletennis"),
                        Text("Cricket"),
                        Text("Hockey"),
                      ]),
                )
              ],
              body: const TabBarView(children: [
                playertourfootball(),
                playertourbasketball(),
                playertourcricket(),
                playertourtabletenis(),
                playertourhockey(),
                playertourvulleyball()
              ]),
            ),
          ),
        ),
      ));
}
