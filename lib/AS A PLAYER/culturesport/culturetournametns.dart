import 'package:finalyear/AS%20A%20PLAYER/culturesport/tournaments%20tabs/tentpagging.dart';
import 'package:finalyear/AS%20A%20PLAYER/culturesport/tournaments%20tabs/tourarchery.dart';
import 'package:finalyear/AS%20A%20PLAYER/culturesport/tournaments%20tabs/tourgynamstic.dart';
import 'package:finalyear/AS%20A%20PLAYER/culturesport/tournaments%20tabs/tourkabadii.dart';
import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';

class culturetournaments extends StatefulWidget {
  const culturetournaments({super.key});

  @override
  State<culturetournaments> createState() => _culturetournamentsState();
}

var images = [
  'assets/culture1.jpg',
  'assets/culture2.jpg',
  'assets/culture3.jpg',
  'assets/culture4.jpg',
];

class _culturetournamentsState extends State<culturetournaments> {
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
                      Text("Archery"),
                      Text("Kabaddi"),
                      Text("Tent Pagging"),
                      Text("Gymnastic"),
                    ]),
              )
            ],
            body: const TabBarView(children: [
              tourarchery(),
              tourkabaddi(),
              tourtentpagging(),
              tourgymnastic()
            ]),
          ),
        ),
      ));
}
