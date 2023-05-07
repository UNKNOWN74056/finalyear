import 'package:finalyear/AS%20A%20PLAYER/internationalsports/Details/coachdetail.dart';
import 'package:finalyear/functions/functions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../GETX/getdatafromfirebase.dart';

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
                        e.sport == "VulleyBall" && e.profession == "Coache")
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
                              onTap: () => Get.to(coachdetail(post: element)),
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
