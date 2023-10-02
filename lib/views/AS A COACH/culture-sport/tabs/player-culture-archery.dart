import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../AS A PLAYER/internationalsports/Details/coachdetail.dart';
import '../../../../GETX/getdatafromfirebase.dart';
import '../../../../components/data/User-Data-Card.dart';

class playerculturearchery extends StatefulWidget {
  const playerculturearchery({super.key});

  @override
  State<playerculturearchery> createState() => _playerculturearcheryState();
}

class _playerculturearcheryState extends State<playerculturearchery> {
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
                        (e) => e.sport == "Archery" && e.profession == "Player")
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
