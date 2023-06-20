import 'package:finalyear/AS%20A%20COACH/details_page/user_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../GETX/getdatafromfirebase.dart';

class playerfootball extends StatefulWidget {
  const playerfootball({super.key});

  @override
  State<playerfootball> createState() => _playerfootballState();
}

class _playerfootballState extends State<playerfootball> {
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
                        e.sport == "FootBall" && e.profession == "Player")
                    .map((element) => Card(
                          color: Colors.grey.shade300,
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(
                                color: Color.fromARGB(255, 25, 9, 117),
                                width: 1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: ListTile(
                              title: Text(element.fullname,
                                  style: const TextStyle(fontSize: 20)),
                              leading: CircleAvatar(
                                  radius: 35,
                                  backgroundImage:
                                      NetworkImage(element.image_Url),
                                  backgroundColor: Colors.white),
                              trailing: const Icon(
                                Icons.arrow_forward,
                              ),
                              onTap: () =>
                                  Get.to(user_detail_page(post: element)),
                              subtitle: Text(element.city,
                                  style: const TextStyle(fontSize: 15))),
                        ))
                    .toList()),
          );
        },
      ),
    ));
  }
}
