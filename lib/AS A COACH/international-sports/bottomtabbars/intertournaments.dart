import 'package:finalyear/AS%20A%20COACH/international-sports/intertournaments/player-tour-basketball.dart';
import 'package:finalyear/AS%20A%20COACH/international-sports/intertournaments/player-tour-cricket.dart';
import 'package:finalyear/AS%20A%20COACH/international-sports/intertournaments/player-tour-football.dart';
import 'package:finalyear/AS%20A%20COACH/international-sports/intertournaments/player-tour-hockey.dart';
import 'package:finalyear/AS%20A%20COACH/international-sports/intertournaments/player-tour-vulleyball.dart';
import 'package:finalyear/AS%20A%20COACH/international-sports/intertournaments/player-your-tabletenis.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

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
        child: Scaffold(
          body: NestedScrollView(
            floatHeaderSlivers: true,
            headerSliverBuilder: (context, innerBoxIsScrolled) => [
              SliverAppBar(
                expandedHeight: 200,
                pinned: true,
                floating: true,
                snap: true,
                title: const Text(
                  "Tournaments",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
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
              playertourfootball(),
              playertourbasketball(),
              playertourcricket(),
              playertourtabletenis(),
              playertourhockey(),
              playertourvulleyball()
            ]),
          ),
        ),
      ));
}
