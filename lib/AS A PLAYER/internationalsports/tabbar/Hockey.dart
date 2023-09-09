import 'package:finalyear/AS%20A%20PLAYER/internationalsports/Details/coachdetail.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../GETX/getdatafromfirebase.dart';
import '../../../wedgets/data/User-Data-Card.dart';

class Hockey extends StatefulWidget {
  const Hockey({super.key});

  @override
  State<Hockey> createState() => _HockeyState();
}

class _HockeyState extends State<Hockey> {
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
                        (e) => e.sport == "Hockey" && e.profession == "Coache")
                    .map((element) => CustomCard(
                          fullName: element.fullname,
                          imageUrl: element.image_Url,
                          city: element.city,
                          onTap: () => Get.to(() => coachdetail(post: element)),
                        ))
                    .toList()),
          );
        },
      ),
    ));
  }
}
