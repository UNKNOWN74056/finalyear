import 'package:finalyear/AS%20A%20PLAYER/internationalsports/tournamentsregistration/registration.dart';
import 'package:finalyear/AS%20A%20PLAYER/internationalsports/tournmaents%20tabs/basketballtour.dart';
import 'package:finalyear/AS%20A%20PLAYER/internationalsports/tournmaents%20tabs/crickettour.dart';
import 'package:finalyear/AS%20A%20PLAYER/internationalsports/tournmaents%20tabs/footballtour.dart';
import 'package:finalyear/AS%20A%20PLAYER/internationalsports/tournmaents%20tabs/hockeytour.dart';
import 'package:finalyear/AS%20A%20PLAYER/internationalsports/tournmaents%20tabs/tabletanistour.dart';
import 'package:finalyear/AS%20A%20PLAYER/internationalsports/tournmaents%20tabs/vulleyballtour.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class tournaments extends StatefulWidget {
  const tournaments({super.key});

  @override
  State<tournaments> createState() => _tournamentsState();
}

class _tournamentsState extends State<tournaments> {
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
                automaticallyImplyLeading: false,
                actions: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: IconButton(
                        onPressed: () =>
                            Get.to(() => (() => const registration())),
                        icon: const FaIcon(FontAwesomeIcons.trophy)),
                  ),
                ],
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
                      Text("FootBall"),
                      Text("BasketBall"),
                      Text("VolleyBall"),
                      Text("TableTennis"),
                      Text("Cricket"),
                      Text("Hockey"),
                    ]),
              )
            ],
            body: const TabBarView(children: [
              footballtour(),
              basketballtour(),
              vulleyballtour(),
              crickettour(),
              tabletanistour(),
              hockeytour(),
            ]),
          ),
        ),
      ));
}
