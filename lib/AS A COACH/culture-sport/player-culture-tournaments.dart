import 'package:finalyear/AS%20A%20COACH/culture-sport/tournaments/player-tour-archery.dart';
import 'package:finalyear/AS%20A%20COACH/culture-sport/tournaments/player-tour-gymnastic.dart';
import 'package:finalyear/AS%20A%20COACH/culture-sport/tournaments/player-tour-kabaddi.dart';
import 'package:finalyear/AS%20A%20COACH/culture-sport/tournaments/player-tour-tent-pagging.dart';
import 'package:flutter/material.dart';

class playerculturetournaments extends StatefulWidget {
  const playerculturetournaments({super.key});

  @override
  State<playerculturetournaments> createState() =>
      _playerculturetournamentsState();
}

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
                expandedHeight: 200,
                pinned: true,
                floating: true,
                snap: true,
                title: const Text(
                  "Tournaments",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
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
