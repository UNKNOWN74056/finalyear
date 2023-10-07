import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../AS A PLAYER/internationalsports/Details/coachdetail.dart';
import '../../../../GETX/getdatafromfirebase.dart';
import '../../../../components/data/User-Data-Card.dart';

class playerculturetentpagging extends StatefulWidget {
  const playerculturetentpagging({super.key});

  @override
  State<playerculturetentpagging> createState() =>
      _playerculturetentpaggingState();
}

class _playerculturetentpaggingState extends State<playerculturetentpagging> {
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
                        e.sport == "Tent pagging" && e.profession == "Player")
                    .map((element) => CustomCard(
                          fullName: element.fullname,
                          imageUrl: element.image_Url,
                          city: element.city,
                          rating: element.rating,
                          onTap: () => Get.to(coachdetail(post: element)),
                        ))
                    .toList()),
          );
        },
      ),
    ));
  }
}
