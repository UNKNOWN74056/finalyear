import 'package:finalyear/views/AS%20A%20PLAYER/internationalsports/Details/coachdetail.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../GETX/getdatafromfirebase.dart';
import '../../../../components/data/User-Data-Card.dart';

class vulleyball extends StatefulWidget {
  const vulleyball({super.key});

  @override
  State<vulleyball> createState() => _vulleyballState();
}

class _vulleyballState extends State<vulleyball> {
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
                        e.sport == "VolleyBall" && e.profession == "Coache")
                    .map((element) => CustomCard(
                          fullName: element.fullname,
                          imageUrl: element.image_Url,
                          city: element.city,
                          rating: element.rating,
                          onTap: () => Get.to(() => coachdetail(post: element)),
                        ))
                    .toList()),
          );
        },
      ),
    ));
  }
}
