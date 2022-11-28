import 'package:finalyear/AS%20A%20COACH/international-sports/intertournaments/player-tour-basketball.dart';
import 'package:finalyear/AS%20A%20COACH/international-sports/intertournaments/player-tour-cricket.dart';
import 'package:finalyear/AS%20A%20COACH/international-sports/intertournaments/player-tour-football.dart';
import 'package:finalyear/AS%20A%20COACH/international-sports/intertournaments/player-tour-hockey.dart';
import 'package:finalyear/AS%20A%20COACH/international-sports/intertournaments/player-tour-vulleyball.dart';
import 'package:finalyear/AS%20A%20COACH/international-sports/intertournaments/player-your-tabletenis.dart';
import 'package:flutter/material.dart';

class intertournaments extends StatefulWidget {
  const intertournaments({super.key});

  @override
  State<intertournaments> createState() => _intertournamentsState();
}

class _intertournamentsState extends State<intertournaments> {
  @override
  Widget build(BuildContext context) =>
      //TabController _TabController = TabController(length: 6, vsync: this);
      SafeArea(
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
