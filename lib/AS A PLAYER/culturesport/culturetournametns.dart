import 'package:finalyear/AS%20A%20PLAYER/culturesport/tournaments%20tabs/tentpagging.dart';
import 'package:finalyear/AS%20A%20PLAYER/culturesport/tournaments%20tabs/tourarchery.dart';
import 'package:finalyear/AS%20A%20PLAYER/culturesport/tournaments%20tabs/tourgynamstic.dart';
import 'package:finalyear/AS%20A%20PLAYER/culturesport/tournaments%20tabs/tourkabadii.dart';
import 'package:flutter/material.dart';

class culturetournaments extends StatefulWidget {
  const culturetournaments({super.key});

  @override
  State<culturetournaments> createState() => _culturetournamentsState();
}

class _culturetournamentsState extends State<culturetournaments> {
  @override
  Widget build(BuildContext context) => SafeArea(
          child: DefaultTabController(
        length: 4,
        child: Scaffold(
          body: NestedScrollView(
            floatHeaderSlivers: true,
            headerSliverBuilder: (context, innerBoxIsScrolled) => [
              const SliverAppBar(
                expandedHeight: 200,
                pinned: true,
                floating: true,
                snap: true,
                title: Text(
                  "Tournaments",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                centerTitle: true,
                bottom: TabBar(
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
