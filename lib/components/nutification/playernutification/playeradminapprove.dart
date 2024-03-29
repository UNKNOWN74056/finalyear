import 'package:finalyear/components/nutification/playernutification/Deletion_Request.dart';
import 'package:finalyear/components/nutification/playernutification/playeroffer.dart';
import 'package:finalyear/components/nutification/playernutification/playerregistration.dart';
import 'package:flutter/material.dart';

class playeradminapprove extends StatefulWidget {
  const playeradminapprove({super.key});

  @override
  State<playeradminapprove> createState() => _adminapproveState();
}

class _adminapproveState extends State<playeradminapprove> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 3,
        child: SafeArea(
          child: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: const Text("Notification"),
              bottom: const TabBar(
                indicatorColor: Colors.black,
                indicatorWeight: 3,
                tabs: [Text("Registration"), Text("Offers"), Text("Deletion")],
              ),
            ),
            body: const TabBarView(children: [
              playerregidtration(),
              playeroffer(),
              Deletion_Request()
            ]),
          ),
        ));
  }
}
