import 'package:chewie/chewie.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
import 'package:flutter_badged/flutter_badge.dart';

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
              child: Obx(() => ListView(
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
                                padding: const EdgeInsets.all(20),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        CircleAvatar(
                                          radius: 45.0,
                                          backgroundImage:
                                              NetworkImage(element.image_Url),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(width: 16.0),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 20),
                                      child: Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                Text(
                                                  element.fullname,
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 20,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(
                                              height: 8.0,
                                            ),
                                            Row(
                                              children: [
                                                const Text(
                                                  "Gender: ",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
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
                                                const Text(
                                                  "Favorite sport: ",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
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
                                                const Text(
                                                  "Location: ",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
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
                                                const Text(
                                                  "Profession: ",
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
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
                                                  child: ReusableElevatedButton(
                                                    onTap: () {
                                                      Get.to(
                                                          const CustomBottomSheet());
                                                    },
                                                    icon: Icons.edit,
                                                    child: const Text("Edit"),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
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
                              //video section
                              GridView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: vidcontroller.videolist
                                    .where((e) => e.email == currentuser)
                                    .length,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  mainAxisSpacing: 8.0,
                                  crossAxisSpacing: 8.0,
                                ),
                                itemBuilder: (BuildContext context, int index) {
                                  final video = vidcontroller.videolist
                                      .where((e) =>
                                          e.email ==
                                          FirebaseAuth
                                              .instance.currentUser!.email)
                                      .toList()[index];
                                  final controller =
                                      VideoPlayerController.network(
                                          video.videolink);
                                  _controllers.add(controller);

                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => Scaffold(
                                            body: Chewie(
                                              controller: ChewieController(
                                                videoPlayerController:
                                                    controller,
                                                autoPlay: true,
                                                looping: false,
                                                errorBuilder:
                                                    (context, errorMessage) {
                                                  return Center(
                                                    child: Text(
                                                      errorMessage,
                                                      style: const TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                  );
                                                },
                                                placeholder: Container(
                                                  color: Colors.grey[200],
                                                ),
                                                materialProgressColors:
                                                    ChewieProgressColors(
                                                  playedColor: Colors.red,
                                                  handleColor: Colors.red,
                                                  backgroundColor:
                                                      const Color.fromARGB(
                                                          78, 158, 158, 158),
                                                  bufferedColor: Colors.grey,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                    onLongPress: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                          title: const Text('Delete Video'),
                                          content: const Text(
                                              'Are you sure you want to delete this video?'),
                                          actions: [
                                            TextButton(
                                              onPressed: () =>
                                                  Navigator.pop(context),
                                              child: const Text('Cancel'),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                final videoToDelete =
                                                    vidcontroller.videolist
                                                        .firstWhere(
                                                            (e) =>
                                                                e.email ==
                                                                FirebaseAuth
                                                                    .instance
                                                                    .currentUser!
                                                                    .email,
                                                            orElse: () => null);
                                                if (videoToDelete != null) {
                                                  FirebaseFirestore.instance
                                                      .collection("videos")
                                                      .doc(videoToDelete.id)
                                                      .delete();
                                                }
                                                Navigator.pop(context);
                                              },
                                              child: const Text('Delete'),
                                            ),
                                          ],
                                        ),
                                      );
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.all(8.0),
                                      decoration: BoxDecoration(
                                        color: Colors.white70,
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.5),
                                            spreadRadius: 1,
                                            blurRadius: 5,
                                            offset: const Offset(0, 3),
                                          ),
                                        ],
                                      ),
                                      child: FutureBuilder(
                                        future: controller.initialize(),
                                        builder: (BuildContext context,
                                            AsyncSnapshot snapshot) {
                                          if (snapshot.connectionState ==
                                              ConnectionState.done) {
                                            return AspectRatio(
                                              aspectRatio: 16 / 9,
                                              child: VideoPlayer(controller),
                                            );
                                          } else if (snapshot.hasError) {
                                            return const Text(
                                                'Error loading video');
                                          } else {
                                            return Container(
                                              height: 200.0,
                                              color: Colors.grey[200],
                                            );
                                          }
                                        },
                                      ),
                                    ),
                                  );
                                },
                              )
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
