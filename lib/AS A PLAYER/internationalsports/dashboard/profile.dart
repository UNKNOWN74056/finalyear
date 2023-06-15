import 'package:finalyear/GETX/getdatafromfirebase.dart';
import 'package:finalyear/functions/functions.dart';
import 'package:finalyear/wedgets/adminapprove.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import '../../../GETX/allvideos.dart';
import '../../../wedgets/editbutton.dart';
import '../../../wedgets/editprofilewidget.dart';

class profile extends StatefulWidget {
  const profile({super.key});

  @override
  State<profile> createState() => _profileState();
}

final currentUser = FirebaseAuth.instance;

class _profileState extends State<profile> {
  //getx controller
  final vidcontroller = Get.put(FetchVideoFirebase());
  final List<VideoPlayerController> _controllers = [];
  final currentuser = FirebaseAuth.instance.currentUser!.email;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            functions.pickVideo();
          },
          icon: const Icon(
            FontAwesomeIcons.video,
            color: Colors.red,
          ),
          label: const Text("Add videos"),
        ),
        body: GetBuilder(
          init: FetchDataFirebase(),
          builder: (controller) {
            return RefreshIndicator(
              onRefresh: () async {
                vidcontroller.Getallvideos();
                controller.GetDataFirebase();
              },
              child: Obx(() => Column(
                    children: controller.mylist
                        .where((e) =>
                            e.email == FirebaseAuth.instance.currentUser!.email)
                        .map(
                          (element) => Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.only(top: 20, left: 10),
                                    child: Text(
                                      "Profile",
                                      style: TextStyle(fontSize: 40),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 130),
                                    child: InkWell(
                                      onTap: () async {
                                        functions.transfer_request_email();
                                      },
                                      child: const Icon(
                                          FontAwesomeIcons.rightLeft),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 10),
                                    child: InkWell(
                                      onTap: () {
                                        Get.to(AdminApprovalScreen());
                                      },
                                      child: const Icon(FontAwesomeIcons.bell),
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                padding: const EdgeInsets.all(16.0),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    CircleAvatar(
                                      radius: 40.0,
                                      backgroundImage:
                                          NetworkImage(element.image_Url),
                                    ),
                                    const SizedBox(width: 16.0),
                                    Expanded(
                                      // Move the Expanded widget here
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              element.fullname,
                                              style: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 20,
                                              ),
                                            ),
                                            const SizedBox(height: 8.0),
                                            Row(
                                              children: [
                                                const Text("Gender: "),
                                                Text(
                                                  element.gender,
                                                  style: TextStyle(
                                                    color: Colors.grey[600],
                                                    fontSize: 16.0,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 8.0),
                                            Row(
                                              children: [
                                                const Text("Favorite sport: "),
                                                Text(
                                                  element.sport,
                                                  style: TextStyle(
                                                    color: Colors.grey[600],
                                                    fontSize: 16.0,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 8.0),
                                            Row(
                                              children: [
                                                const Text("Location: "),
                                                Text(
                                                  element.city,
                                                  style: TextStyle(
                                                    color: Colors.grey[600],
                                                    fontSize: 16.0,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 8.0),
                                            Row(
                                              children: [
                                                const Text("Profession: "),
                                                Text(
                                                  element.profession,
                                                  style: TextStyle(
                                                    color: Colors.grey[600],
                                                    fontSize: 16.0,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 8.0),
                                            Row(
                                              children: [
                                                const Icon(Icons.star,
                                                    color: Colors.yellow),
                                                const SizedBox(width: 4.0),
                                                Text(
                                                  element.rating.toString(),
                                                  style: const TextStyle(
                                                    fontSize: 16.0,
                                                  ),
                                                ),
                                                const SizedBox(width: 4.0),
                                                Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 40),
                                                    child:
                                                        ReusableElevatedButton(
                                                      onTap: () {
                                                        Get.to(
                                                            const CustomBottomSheet());
                                                      },
                                                      icon: Icons.edit,
                                                      child: const Text("Edit"),
                                                    ))
                                              ],
                                            ),
                                          ]),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 15),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: const [
                                      Text(
                                        'Videos',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20.0,
                                        ),
                                      ),
                                      SizedBox(height: 8.0),
                                    ]),
                              ),
                            
                            ],
                          ),
                        )
                        .toList(),
                  )),
            );
          },
        ),
      ),
    );
  }
}
