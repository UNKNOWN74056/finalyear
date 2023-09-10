import 'package:finalyear/wedgets/nutification/coachnitification/offers.dart';
import 'package:finalyear/wedgets/nutification/coachnitification/registration.dart';
import 'package:flutter/material.dart';

class adminapprove extends StatefulWidget {
  const adminapprove({super.key});

  @override
  State<adminapprove> createState() => _adminapproveState();
}

class _adminapproveState extends State<adminapprove> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: SafeArea(
          child: Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: const Text("Admin Approve"),
              bottom: const TabBar(
                indicatorColor: Colors.black,
                indicatorWeight: 3,
                tabs: [Text("Registration"), Text("Offers")],
              ),
            ),
            body: const TabBarView(children: [registration(), offers()]),
          ),
        ));
  }
}
