import 'package:finalyear/views/AS%20A%20COACH/details_page/user_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../GETX/getdatafromfirebase.dart';
import '../../../../components/data/User-Data-Card.dart';

class playervulleyball extends StatefulWidget {
  const playervulleyball({super.key});

  @override
  State<playervulleyball> createState() => _playervulleyballState();
}

class _playervulleyballState extends State<playervulleyball> {
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
                        e.sport == "VolleyBall" && e.profession == "Player")
                    .map((element) => CustomCard(
                          fullName: element.fullname,
                          imageUrl: element.image_Url,
                          city: element.city,
                          rating: element.rating,
                          isVarified: element.varificaiton,
                          onTap: () => Get.to(user_detail_page(post: element)),
                        ))
                    .toList()),
          );
        },
      ),
    ));
  }
}
