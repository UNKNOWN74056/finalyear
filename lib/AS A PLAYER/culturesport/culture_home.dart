import 'package:finalyear/AS%20A%20PLAYER/culturesport/tabbar/archery.dart';
import 'package:finalyear/AS%20A%20PLAYER/culturesport/tabbar/gymnastic.dart';
import 'package:finalyear/AS%20A%20PLAYER/culturesport/tabbar/kabaddi.dart';
import 'package:finalyear/AS%20A%20PLAYER/culturesport/tabbar/tent_pagging.dart';
import 'package:finalyear/wedgets/search_engine_for_user.dart';
import "package:get/get.dart";
import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';

class culturehome extends StatefulWidget {
  const culturehome({super.key});

  @override
  State<culturehome> createState() => _culturehomeState();
}

class _culturehomeState extends State<culturehome>
//with TickerProviderStateMixin
{
  var images = [
    'assets/culture1.jpg',
    'assets/culture2.jpg',
    'assets/culture3.jpg',
    'assets/culture4.jpg',
  ];

  @override
  Widget build(BuildContext context) =>

      // TabController _TabController = TabController(length: 6, vsync: this);
      SafeArea(
        child: DefaultTabController(
          length: 4,
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
                            Get.to(usersearchengine());
                          },
                          icon: const Icon(Icons.search)),
                    ),
                  ],
                  automaticallyImplyLeading: false,
                  expandedHeight: 200,
                  pinned: true,
                  floating: true,
                  snap: true,
                  title: const Text(
                    "CULTURE",
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
                      itemCount: 4,
                    ),
                  ),
                  bottom: const TabBar(
                      indicatorColor: Colors.orange,
                      indicatorWeight: 5,
                      isScrollable: true,
                      labelStyle: TextStyle(fontSize: 20),
                      tabs: [
                        Text("Archery"),
                        Text("Kabaddi"),
                        Text("Tent pagging"),
                        Text("Gymnastic"),
                      ]),
                )
              ],
              body: const TabBarView(
                  children: [archery(), kabaddi(), tentpagging(), gymnastic()]),
            ),
          ),
        ),
      );
}
