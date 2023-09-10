import 'package:finalyear/AS%20A%20COACH/culture-sport/tournaments/player-tour-archery.dart';
import 'package:finalyear/AS%20A%20COACH/culture-sport/tournaments/player-tour-gymnastic.dart';
import 'package:finalyear/AS%20A%20COACH/culture-sport/tournaments/player-tour-kabaddi.dart';
import 'package:finalyear/AS%20A%20COACH/culture-sport/tournaments/player-tour-tent-pagging.dart';
import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';

class playerculturetournaments extends StatefulWidget {
  const playerculturetournaments({super.key});

  @override
  State<playerculturetournaments> createState() =>
      _playerculturetournamentsState();
}

var images = [
  'assets/culture1.jpg',
  'assets/culture2.jpg',
  'assets/culture3.jpg',
  'assets/culture4.jpg',
];

class _playerculturetournamentsState extends State<playerculturetournaments> {
  @override
  Widget build(BuildContext context) => SafeArea(
          child: DefaultTabController(
        length: 4,
        child: Scaffold(
          body: NestedScrollView(
            floatHeaderSlivers: true,
            headerSliverBuilder: (context, innerBoxIsScrolled) => [
              SliverAppBar(
                automaticallyImplyLeading: false,
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
                    itemCount: 4,
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
                      Text("Archery"),
                      Text("Kabaddi"),
                      Text("Tent Pagging"),
                      Text("Gymnastic"),
                    ]),
              )
            ],
            body: const TabBarView(children: [
              playertourarchery(),
              playertourkabaddi(),
              playertourtentpagging(),
              playertourgymnastic()
            ]),
          ),
        ),
      ));
}
