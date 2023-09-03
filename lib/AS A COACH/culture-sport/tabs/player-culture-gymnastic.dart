import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../AS A PLAYER/internationalsports/Details/coachdetail.dart';
import '../../../GETX/getdatafromfirebase.dart';
import '../../../wedgets/data/User-Data-Card.dart';

class playerculturegymnastic extends StatefulWidget {
  const playerculturegymnastic({super.key});

  @override
  State<playerculturegymnastic> createState() => _playerculturegymnasticState();
}

class _playerculturegymnasticState extends State<playerculturegymnastic> {
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
                        e.sport == "Gymnastic" && e.profession == "Player")
                    .map((element) => CustomCard(
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
