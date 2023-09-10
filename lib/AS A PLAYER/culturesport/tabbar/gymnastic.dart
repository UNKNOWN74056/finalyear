import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finalyear/AS%20A%20PLAYER/internationalsports/Details/coachdetail.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../GETX/getdatafromfirebase.dart';
import '../../../wedgets/data/User-Data-Card.dart';

class gymnastic extends StatefulWidget {
  const gymnastic({super.key});

  @override
  State<gymnastic> createState() => _gymnasticState();
}

class _gymnasticState extends State<gymnastic> {
  // getx controller
  final controller = Get.put(FetchDataFirebase());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: RefreshIndicator(
      onRefresh: () async {
        controller.GetDataFirebase();
      },
      child: GetBuilder(
        init: FetchDataFirebase(),
        builder: (controller) {
          return Obx(
            () => ListView(
                children: controller.mylist
                    .where((e) =>
                        e.sport == "Gymnastic" && e.profession == "Coache")
                    .map((element) =>  CustomCard(
                          fullName: element.fullname,
                          imageUrl: element.image_Url,
                          city: element.city,
                          onTap: () => Get.to(coachdetail(post: element)),
                        ))
                    .toList()),
          );
        },
      ),
    ));
  }
}
