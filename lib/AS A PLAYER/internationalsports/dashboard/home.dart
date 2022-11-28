import 'package:finalyear/AS%20A%20PLAYER/internationalsports/tabbar/Basketball.dart';
import 'package:finalyear/AS%20A%20PLAYER/internationalsports/tabbar/Cricket.dart';
import 'package:finalyear/AS%20A%20PLAYER/internationalsports/tabbar/Football.dart';
import 'package:finalyear/AS%20A%20PLAYER/internationalsports/tabbar/Hockey.dart';
import 'package:finalyear/AS%20A%20PLAYER/internationalsports/tabbar/tabletenis.dart';
import 'package:finalyear/AS%20A%20PLAYER/internationalsports/tabbar/vulleyball.dart';
import 'package:finalyear/as%20a%20player/internationalsports/dashboard/homedb.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> //with TickerProviderStateMixin
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
                    "Internation sport",
                    style: TextStyle(fontWeight: FontWeight.bold),
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
 //Scaffold(
//       appBar: PreferredSize(
//           preferredSize: Size.fromHeight(100),
//           child: AppBar(
//             centerTitle: true,
//             title: const Text(
//               "International Sports",
//               style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//             ),
//             actions: [
//               Padding(
//                 padding: const EdgeInsets.only(left: 20),
//                 child: IconButton(onPressed: () {}, icon: Icon(Icons.search)),
//               ),
//               Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: IconButton(
//                     onPressed: () {},
//                     icon: const Icon(Icons.camera_alt),
//                   ))
//             ],
//             shape: const RoundedRectangleBorder(
//                 borderRadius: BorderRadius.only(
//                     bottomLeft: Radius.circular(25),
//                     bottomRight: Radius.circular(25))),
//           )),
//       body: Column(
//         children: [
//           const SizedBox(
//             height: 25,
//           ),
//           Container(
//             child: TabBar(
//               indicator: BoxDecoration(
//                   borderRadius: BorderRadius.circular(50), // Creates border
//                   color: Colors.teal),
//               isScrollable: true,
//               controller: _TabController,
//               labelColor: Colors.black,
//               unselectedLabelColor: Colors.teal,
//               tabs: const [
//                 Tab(
//                   text: "Football",
//                 ),
//                 Tab(
//                   text: "Basketball",
//                 ),
//                 Tab(
//                   text: "vulleyball",
//                 ),
//                 Tab(
//                   text: "tabletenis",
//                 ),
//                 Tab(
//                   text: "Cricket",
//                 ),
//                 Tab(
//                   text: "Hockey",
//                 ),
//               ],
//             ),
//           ),
//           Expanded(
//             child: Container(
//               width: double.maxFinite,
//               height: double.maxFinite,
//               child: TabBarView(controller: _TabController, children: const [
//                 Football(),
//                 Basketball(),
//                 vulleyball(),
//                 tabletenis(),
//                 Cricket(),
//                 Hockey()
//               ]),
//             ),
//           )
//         ],
//       ),
//     );
//   }
