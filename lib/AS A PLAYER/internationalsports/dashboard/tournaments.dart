import 'package:finalyear/AS%20A%20PLAYER/internationalsports/tournamentsregistration/registration.dart';
import 'package:finalyear/AS%20A%20PLAYER/internationalsports/tournmaents%20tabs/basketballtour.dart';
import 'package:finalyear/AS%20A%20PLAYER/internationalsports/tournmaents%20tabs/crickettour.dart';
import 'package:finalyear/AS%20A%20PLAYER/internationalsports/tournmaents%20tabs/footballtour.dart';
import 'package:finalyear/AS%20A%20PLAYER/internationalsports/tournmaents%20tabs/hockeytour.dart';
import 'package:finalyear/AS%20A%20PLAYER/internationalsports/tournmaents%20tabs/tabletanistour.dart';
import 'package:finalyear/AS%20A%20PLAYER/internationalsports/tournmaents%20tabs/vulleyballtour.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class tournaments extends StatefulWidget {
  const tournaments({super.key});

  @override
  State<tournaments> createState() => _tournamentsState();
}

class _tournamentsState extends State<tournaments>
//with TickerProviderStateMixin
{
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
                actions: [
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: IconButton(
                        onPressed: () => Get.to(() => (const registration())),
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


 // Scaffold(
    //     appBar: PreferredSize(
    //         preferredSize: Size.fromHeight(100),
    //         child: AppBar(
    //           centerTitle: true,
    //           title: const Text(
    //             "Tournaments",
    //             style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
    //           ),
    //           actions: [
    //             Padding(
    //               padding: const EdgeInsets.only(left: 20),
    //               child: IconButton(onPressed: () {}, icon: Icon(Icons.search)),
    //             ),
    //           ],
    //           shape: const RoundedRectangleBorder(
    //               borderRadius: BorderRadius.only(
    //                   bottomLeft: Radius.circular(25),
    //                   bottomRight: Radius.circular(25))),
    //         )),
    //     body: Column(children: [
    //       const SizedBox(
    //         height: 15,
    //       ),
    //       Container(
    //         child: TabBar(
    //           indicator: BoxDecoration(
    //               borderRadius: BorderRadius.circular(50), // Creates border
    //               color: Colors.teal),
    //           isScrollable: true,
    //           controller: _TabController,
    //           labelColor: Colors.black,
    //           unselectedLabelColor: Colors.teal,
    //           tabs: const [
    //             Tab(
    //               text: "Football",
    //             ),
    //             Tab(
    //               text: "Basketball",
    //             ),
    //             Tab(
    //               text: "vulleyball",
    //             ),
    //             Tab(
    //               text: "tabletenis",
    //             ),
    //             Tab(
    //               text: "Cricket",
    //             ),
    //             Tab(
    //               text: "Hockey",
    //             ),
    //           ],
    //         ),
    //       ),
    //       Expanded(
    //         child: Container(
    //           width: double.maxFinite,
    //           child: TabBarView(controller: _TabController, children: const [
    //             footballtour(),
    //             basketballtour(),
    //             vulleyballtour(),
    //             crickettour(),
    //             tabletanistour(),
    //             hockeytour(),
    //           ]),
    //         ),
    //       )
    //     ])
    //     );