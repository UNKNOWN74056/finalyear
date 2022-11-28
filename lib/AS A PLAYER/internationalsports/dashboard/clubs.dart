import 'package:finalyear/AS%20A%20PLAYER/internationalsports/Details/clubdetail.dart';
import 'package:finalyear/AS%20A%20PLAYER/internationalsports/dashboard/homedb.dart';
import 'package:flutter/material.dart';
import 'package:finalyear/model/clubdata.dart';
import 'package:get/get.dart';

class clubs extends StatefulWidget {
  const clubs({super.key});

  @override
  State<clubs> createState() => _clubsState();
}

class _clubsState extends State<clubs> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) => [
                  SliverAppBar(
                    actions: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: IconButton(
                            onPressed: () => Get.to(() => (const Homedb())),
                            icon: const Icon(Icons.search)),
                      ),
                    ],
                    expandedHeight: 200,
                    pinned: true,
                    floating: true,
                    snap: true,
                    title: const Text(
                      "Clubs",
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                    flexibleSpace: FlexibleSpaceBar(
                        background: Image.asset(
                      "assets/mixsport.jpeg",
                      fit: BoxFit.cover,
                    )),
                    centerTitle: true,
                  )
                ],
            body: Column(children: [
              const SizedBox(
                height: 20,
              ),
              Expanded(
                  child: ListView.builder(
                      itemCount: clubdata.length,
                      itemBuilder: (BuildContext context, index) {
                        return Container(
                          height: 90,
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)),
                            child: ListTile(
                              title: Text(
                                clubdata[index].name,
                                style: const TextStyle(fontSize: 25),
                              ),
                              leading: const CircleAvatar(
                                  radius: 30,
                                  backgroundImage:
                                      AssetImage("assets/stadium.jpg"),
                                  backgroundColor: Colors.green),
                              subtitle: Text(clubdata[index].discription,
                                  style: const TextStyle(fontSize: 18)),
                              trailing: const Icon(Icons.arrow_forward),
                              onTap: () {
                                navigator?.push(MaterialPageRoute(
                                    builder: ((context) =>
                                        const clubdetail())));
                              },
                            ),
                          ),
                        );
                      })),
            ])),
      ),
    );
  }
}
 //Scaffold(
    //   appBar: PreferredSize(
    //       preferredSize: Size.fromHeight(100),
    //       child: AppBar(
    //         centerTitle: true,
    //         title: const Text(
    //           "Clubs",
    //           style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
    //         ),
    //         actions: [
    //           Padding(
    //             padding: const EdgeInsets.only(left: 20),
    //             child: IconButton(onPressed: () {}, icon: Icon(Icons.search)),
    //           ),
    //         ],
    //         shape: const RoundedRectangleBorder(
    //             borderRadius: BorderRadius.only(
    //                 bottomLeft: Radius.circular(25),
    //                 bottomRight: Radius.circular(25))),
    //       )
    //       ),
    // // body: Column(children: [
    // //   const SizedBox(
    // //     height: 20,
    // //   ),
    // Expanded(
    //     child: Container(
    //         decoration: BoxDecoration(
    //             borderRadius: BorderRadius.circular(25),
    //             color: Colors.grey),
    //         height: 450,
    //     child: ListView.builder(
    //         itemCount: clubdata.length,
    //         itemBuilder: (BuildContext context, index) {
    //           return Container(
    //             height: 90,
    //             child: Card(
    //               shape: RoundedRectangleBorder(
    //                   borderRadius: BorderRadius.circular(30)),
    //               child: ListTile(
    //                 title: Text(
    //                   clubdata[index].name,
    //                   style: const TextStyle(fontSize: 25),
    //                 ),
    //                 leading: const CircleAvatar(
    //                     radius: 30,
    //                     backgroundImage: AssetImage("assets/stadium.jpg"),
    //                     backgroundColor: Colors.green),
    //                 subtitle: Text(clubdata[index].discription,
    //                     style: const TextStyle(fontSize: 18)),
    //                 trailing: const Icon(Icons.arrow_forward),
    //                 onTap: () {
    //                   navigator?.push(MaterialPageRoute(
    //                       builder: ((context) => const clubdetail())));
    //                 },
    //               ),
    //             ),
    //           );
    //         })),
    //     ]),

    // }
