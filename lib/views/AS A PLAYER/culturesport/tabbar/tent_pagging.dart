import 'package:finalyear/views/AS%20A%20PLAYER/internationalsports/Details/coachdetail.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../GETX/getdatafromfirebase.dart';
import '../../../../components/data/User-Data-Card.dart';

class tentpagging extends StatefulWidget {
  const tentpagging({super.key});

  @override
  State<tentpagging> createState() => _tentpaggingState();
}

class _tentpaggingState extends State<tentpagging> {
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
                        e.sport == "Tent pagging" && e.profession == "Coache")
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
