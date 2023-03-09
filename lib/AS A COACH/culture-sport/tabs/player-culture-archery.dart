import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../AS A PLAYER/internationalsports/Details/coachdetail.dart';
import '../../../GETX/getdatafromfirebase.dart';

class playerculturearchery extends StatefulWidget {
  const playerculturearchery({super.key});

  @override
  State<playerculturearchery> createState() => _playerculturearcheryState();
}

class _playerculturearcheryState extends State<playerculturearchery> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GetBuilder(
      init: FetchDataFirebase(),
      builder: (controller) {
        return ListView(
            children: controller.mylist
                .where((e) => e.sport == "Archery" && e.profession == "Player")
                .map((element) => Card(
                      color: Colors.grey.shade300,
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(
                            color: Color.fromARGB(255, 25, 9, 117), width: 1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ListTile(
                          title: Text(element.fullname,
                              style: const TextStyle(fontSize: 20)),
                          leading: CircleAvatar(
                              radius: 35,
                              backgroundImage: NetworkImage(element.image_Url),
                              backgroundColor: Colors.white),
                          trailing: const Icon(
                            Icons.arrow_forward,
                          ),
                          onTap: () => Get.to(coachdetail(post: element)),
                          subtitle: Text(element.city,
                              style: const TextStyle(fontSize: 15))),
                    ))
                .toList());
      },
    ));
  }
}
