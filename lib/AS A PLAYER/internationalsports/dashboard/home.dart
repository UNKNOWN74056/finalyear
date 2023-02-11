import 'package:finalyear/AS%20A%20PLAYER/internationalsports/tabbar/Basketball.dart';
import 'package:finalyear/AS%20A%20PLAYER/internationalsports/tabbar/Cricket.dart';
import 'package:finalyear/AS%20A%20PLAYER/internationalsports/tabbar/Football.dart';
import 'package:finalyear/AS%20A%20PLAYER/internationalsports/tabbar/Hockey.dart';
import 'package:finalyear/AS%20A%20PLAYER/internationalsports/tabbar/tabletenis.dart';
import 'package:finalyear/AS%20A%20PLAYER/internationalsports/tabbar/vulleyball.dart';
import 'package:finalyear/as%20a%20player/internationalsports/dashboard/homedb.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:get/get.dart';

class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
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
                      padding: const EdgeInsets.only(left: 20),
                      child: IconButton(
                          onPressed: () {
                            showSearch(
                                context: context,
                                delegate: CustomSearchDelegate());
                          },
                          icon: const Icon(Icons.search)),
                    ),
                  ],
                  expandedHeight: 200,
                  pinned: true,
                  floating: true,
                  snap: true,
                  title: const Text(
                    "INTERNATIONAL",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  flexibleSpace: FlexibleSpaceBar(
                      // background: Swiper(
                      //   itemBuilder: (BuildContext context, int index) {
                      //     return Image.network(
                      //       "https://in.pinterest.com/pin/684617580854927859/",
                      //       fit: BoxFit.fill,
                      //     );
                      //   },
                      //   itemCount: 3,
                      //   pagination: SwiperPagination(),
                      //   control: SwiperControl(),
                      // ),
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
        icon: Icon(Icons.arrow_back));
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
