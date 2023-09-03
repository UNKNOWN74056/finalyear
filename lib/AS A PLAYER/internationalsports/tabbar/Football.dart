import 'package:finalyear/AS%20A%20PLAYER/internationalsports/Details/coachdetail.dart';
import 'package:finalyear/GETX/getdatafromfirebase.dart';
import 'package:finalyear/wedgets/data/User-Data-Card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Football extends StatefulWidget {
  const Football({super.key});

  @override
  State<Football> createState() => _FootballState();
}

class _FootballState extends State<Football> {
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
                          e.sport == "FootBall" && e.profession == "Coache")
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
      ),
    );
  }
}
