import 'package:finalyear/AS%20A%20PLAYER/culturesport/culture_dashboard.dart';
import 'package:finalyear/AS%20A%20PLAYER/internationalsports/tabbar/Basketball.dart';
import 'package:finalyear/AS%20A%20PLAYER/internationalsports/tabbar/Cricket.dart';
import 'package:finalyear/AS%20A%20PLAYER/internationalsports/tabbar/Football.dart';
import 'package:finalyear/AS%20A%20PLAYER/internationalsports/tabbar/Hockey.dart';
import 'package:finalyear/AS%20A%20PLAYER/internationalsports/tabbar/tabletenis.dart';
import 'package:finalyear/AS%20A%20PLAYER/internationalsports/tabbar/vulleyball.dart';
import 'package:finalyear/wedgets/search_engine_for_user.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

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
                        icon: const Icon(Icons.search),
                      ),
                    ),
                    PopupMenuButton(
                      position: PopupMenuPosition.under,
                      icon: const Icon(Icons.more_horiz),
                      itemBuilder: ((context) => [
                            PopupMenuItem(
                                child: GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, culturedashboard.routname);
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
                        Text("FootBall"),
                        Text("BasketBall"),
                        Text("VulleyBall"),
                        Text("TableTenis"),
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

class CustomSearchDelegate extends SearchDelegate {
  List<String> searchiterms = [
    "ali",
    "hamza",
    "fahad",
    "faizan",
  ];
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = "";
          },
          icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, null);
        },
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    List<String> matchquery = [];
    for (var friuts in searchiterms) {
      if (friuts.toLowerCase().contains(query.toLowerCase())) {
        matchquery.add(friuts);
      }
    }
    return ListView.builder(
        itemCount: matchquery.length,
        itemBuilder: (context, index) {
          var result = matchquery[index];
          return ListTile(
            title: Text(result),
          );
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> matchquery = [];
    for (var friuts in searchiterms) {
      if (friuts.toLowerCase().contains(query.toLowerCase())) {
        matchquery.add(friuts);
      }
    }
    return ListView.builder(
        itemCount: matchquery.length,
        itemBuilder: (context, index) {
          var result = matchquery[index];
          return ListTile(
            title: Text(result),
          );
        });
  }
}
