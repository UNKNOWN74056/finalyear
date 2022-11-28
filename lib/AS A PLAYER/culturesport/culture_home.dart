import 'package:finalyear/AS%20A%20PLAYER/culturesport/tabbar/archery.dart';
import 'package:finalyear/AS%20A%20PLAYER/culturesport/tabbar/gymnastic.dart';
import 'package:finalyear/AS%20A%20PLAYER/culturesport/tabbar/kabaddi.dart';
import 'package:finalyear/AS%20A%20PLAYER/culturesport/tabbar/tent_pagging.dart';
import 'package:finalyear/AS%20A%20PLAYER/internationalsports/dashboard/homedb.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class culturehome extends StatefulWidget {
  const culturehome({super.key});

  @override
  State<culturehome> createState() => _culturehomeState();
}

class _culturehomeState extends State<culturehome>
//with TickerProviderStateMixin
{
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
                          onPressed: () => Get.to(() => (const Homedb())),
                          icon: const Icon(Icons.search)),
                    ),
                    Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: IconButton(
                          onPressed: () => Get.to(() => (const Homedb())),
                          icon: const Icon(Icons.camera_alt),
                        ))
                  ],
                  expandedHeight: 200,
                  pinned: true,
                  floating: true,
                  snap: true,
                  title: const Text(
                    "Culture sport",
                    style: TextStyle(fontWeight: FontWeight.bold),
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
//  Scaffold(
    //   appBar: PreferredSize(
    //       preferredSize: Size.fromHeight(100),
    //       child: AppBar(
    //         centerTitle: true,
    //         title: const Text("Culture Sports"),
    //         actions: [
    //           Padding(
    //             padding: const EdgeInsets.only(left: 20),
    //             child: IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
    //           ),
    //           Padding(
    //               padding: const EdgeInsets.all(8.0),
    //               child: IconButton(
    //                 onPressed: () {},
    //                 icon: const Icon(Icons.camera_alt),
    //               ))
    //         ],
    //         shape: const RoundedRectangleBorder(
    //             borderRadius: BorderRadius.only(
    //                 bottomLeft: Radius.circular(25),
    //                 bottomRight: Radius.circular(25))),
    //       )),
    //   body: Column(
    //     children: [
    //       const SizedBox(
    //         height: 25,
    //       ),
    //       Container(
    //         child: TabBar(
    //           indicator: BoxDecoration(
    //               borderRadius: BorderRadius.circular(50), // Creates border
    //               color: Colors.greenAccent),
    //           isScrollable: true,
    //           controller: _TabController,
    //           labelColor: Colors.black,
    //           unselectedLabelColor: Colors.green,
    //           tabs: const [
    //             Tab(
    //               text: "Archery",
    //             ),
    //             Tab(
    //               text: "Kabaddi",
    //             ),
    //             Tab(
    //               text: "Tent pagging",
    //             ),
    //             Tab(
    //               text: "Gymnastic",
    //             ),
    //           ],
    //         ),
    //       ),
    //       Expanded(
    //         child: Container(
    //           width: double.maxFinite,
    //           height: double.maxFinite,
    //           child: TabBarView(controller: _TabController, children: const [
    //             archery(),
    //             kabaddi(),
    //             tentpagging(),
    //             gymnastic()
    //           ]),
    //         ),
    //       )
    //     ],
    //   ),
    // );
