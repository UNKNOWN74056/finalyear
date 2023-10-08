import 'package:finalyear/views/AS%20A%20PLAYER/internationalsports/Details/coachdetail.dart';
import 'package:finalyear/components/data/User-Data-Card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../GETX/getdatafromfirebase.dart';

class tabletenis extends StatefulWidget {
  const tabletenis({super.key});

  @override
  State<tabletenis> createState() => _tabletenisState();
}

class _tabletenisState extends State<tabletenis> {
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
                        e.sport == "TableTennis" && e.profession == "Coache")
                    .map((element) => CustomCard(
                          fullName: element.fullname,
                          imageUrl: element.image_Url,
                          city: element.city,
                          rating: element.rating,
                           isVarified: element.varificaiton,
                          onTap: () => Get.to(() => coachdetail(post: element)),
                        ))
                    .toList()),
          );
        },
      ),
    ));
  }
}
