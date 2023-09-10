import 'package:finalyear/AS%20A%20PLAYER/internationalsports/tabbar/Basketball.dart';
import 'package:finalyear/AS%20A%20PLAYER/internationalsports/tabbar/Cricket.dart';
import 'package:finalyear/AS%20A%20PLAYER/internationalsports/tabbar/Football.dart';
import 'package:finalyear/AS%20A%20PLAYER/internationalsports/tabbar/Hockey.dart';
import 'package:finalyear/AS%20A%20PLAYER/internationalsports/tabbar/tabletenis.dart';
import 'package:finalyear/AS%20A%20PLAYER/internationalsports/tabbar/vulleyball.dart';
import 'package:finalyear/wedgets/search_engine_for_user.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:card_swiper/card_swiper.dart';

class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
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
                        ),
                      ),
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
                      unselectedLabelColor: Color.fromARGB(255, 194, 203, 208),
                      labelColor: Colors.white,
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
                ),
              ],
              body: const TabBarView(children: [
                Football(),
                Basketball(),
                vulleyball(),
                tabletenis(),
                Cricket(),
                Hockey()
              ]),
            ),
          ),
        ),
      );
}
