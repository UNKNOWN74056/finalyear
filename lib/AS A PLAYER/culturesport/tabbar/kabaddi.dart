import 'package:finalyear/AS%20A%20PLAYER/internationalsports/Details/coachdetail.dart';
import 'package:finalyear/functions/functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../GETX/getdatafromfirebase.dart';
import '../../../wedgets/data/User-Data-Card.dart';

class kabaddi extends StatefulWidget {
  const kabaddi({super.key});

  @override
  State<kabaddi> createState() => _kabaddiState();
}

class _kabaddiState extends State<kabaddi> {
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
                        (e) => e.sport == "Kabaddi" && e.profession == "Coache")
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
