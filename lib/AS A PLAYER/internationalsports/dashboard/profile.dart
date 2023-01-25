import 'package:finalyear/AS%20A%20PLAYER/internationalsports/statsandvideos/editprofile.dart';
import 'package:finalyear/AS%20A%20PLAYER/internationalsports/statsandvideos/stats.dart';
import 'package:finalyear/AS%20A%20PLAYER/internationalsports/statsandvideos/transferform.dart';
import 'package:finalyear/AS%20A%20PLAYER/internationalsports/statsandvideos/videos.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class profile extends StatefulWidget {
  const profile({super.key});

  @override
  State<profile> createState() => _profileState();
}

class _profileState extends State<profile> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    //contriller for tabs
    TabController _tabController = TabController(length: 2, vsync: this);

    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              title: const Text(
                "Profile",
                style: TextStyle(fontSize: 30),
              ),
              centerTitle: true,
              actions: [
                Padding(
                  padding: EdgeInsets.only(right: 15),
                  child: InkWell(
                    onTap: () {
                      Get.to(transferform());
                    },
                    child: const Icon(FontAwesomeIcons.rightLeft),
                  ),
                )
              ],
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 25,
                  ),
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                    GestureDetector(
                        onTap: () async {},
                        child: Container(
                            child: CircleAvatar(
                          radius: 70,
                          backgroundColor: Colors.pink,
                          child: Image.asset("assets/mixsport.jpeg"),
                        ))),
                  ]),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.to(editprofile());
                        },
                        child: const Text(
                          "Edit",
                          style: TextStyle(fontSize: 18, color: Colors.blue),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Container(
                    child: TabBar(
                        labelColor: Colors.black,
                        unselectedLabelColor: Colors.green,
                        controller: _tabController,
                        tabs: const [
                          Tab(
                            text: "Stats",
                          ),
                          Tab(
                            text: "Videos",
                          )
                        ]),
                  ),
                  Container(
                    width: double.maxFinite,
                    height: 500,
                    child: TabBarView(controller: _tabController, children: [
                      stats(),
                      videos(),
                    ]),
                  )
                ],
              ),
            )));
  }
}
