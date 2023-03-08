import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finalyear/AS%20A%20PLAYER/internationalsports/Details/coachdetail.dart';
import 'package:finalyear/GETX/getdatafromfirebase.dart';
import 'package:finalyear/wedgets/reusebletextfield.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';

class Football extends StatefulWidget {
  const Football({super.key});

  @override
  State<Football> createState() => _FootballState();
}

navigatetodetail(DocumentSnapshot post) {
  Get.to(coachdetail(post: post));
}

class _FootballState extends State<Football> {
  final controller = Get.put(FetchDataFirebase());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GetBuilder(
      init: FetchDataFirebase(),
      builder: (controller) {
        return ListView(
            children: controller.mylist
                .map((element) =>
                    Text(controller.mylist[element].fullname.toString()))
                .toList());
      },
    ));
  }
}
