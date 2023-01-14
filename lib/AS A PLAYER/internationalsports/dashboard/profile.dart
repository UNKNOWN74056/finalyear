import 'package:finalyear/AS%20A%20PLAYER/internationalsports/statsandvideos/stats.dart';
import 'package:finalyear/AS%20A%20PLAYER/internationalsports/statsandvideos/videos.dart';
import 'package:flutter/material.dart';

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
            body: SingleChildScrollView(
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 20),
            child: Text(
              "Profile",
              style: TextStyle(
                fontSize: 50,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
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
            children: const [
              Text(
                "Your name",
                style: TextStyle(
                  fontSize: 20,
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
            child: TabBarView(controller: _tabController, children: const [
              stats(),
              videos(),
            ]),
          )
        ],
      ),
    )));
  }
}
