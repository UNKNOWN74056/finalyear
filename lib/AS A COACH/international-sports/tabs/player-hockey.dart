import 'package:finalyear/AS%20A%20COACH/details_page/user_detail_page.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import '../../../GETX/getdatafromfirebase.dart';
import '../../../wedgets/data/User-Data-Card.dart';

class palyerhockey extends StatefulWidget {
  const palyerhockey({super.key});

  @override
  State<palyerhockey> createState() => _palyerhockeyState();
}

class _palyerhockeyState extends State<palyerhockey> {
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
                    .where(
                        (e) => e.sport == "Hockey" && e.profession == "Player")
                    .map((element) => CustomCard(
                          fullName: element.fullname,
                          imageUrl: element.image_Url,
                          city: element.city,
                          onTap: () => Get.to(user_detail_page(post: element)),
                        ))
                    .toList()),
          );
        },
      ),
    ));
  }
}
