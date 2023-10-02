import 'package:finalyear/GETX/getdatafromfirebase.dart';
import 'package:finalyear/functions/functions.dart';
import 'package:finalyear/components/data/Profile-Shimmer-Ui.dart';
import 'package:finalyear/components/nutification/coachnitification/adminapprove.dart';
import 'package:finalyear/components/videospagecode.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import '../../../../GETX/allvideos.dart';
import '../../components/editbutton.dart';
import '../../components/editprofilewidget.dart';
import '../../components/userdataprofileedit.dart';

class playerprofile extends StatefulWidget {
  const playerprofile({super.key});

  @override
  State<playerprofile> createState() => _profileState();
}

class _profileState extends State<playerprofile> {
  //getx controller
  final vidcontroller = Get.put(FetchVideoFirebase());
  final currentuser = FirebaseAuth.instance.currentUser!.email;
  bool isLoading = true; // Initially set to true for shimmer loading

  @override
  void initState() {
    super.initState();
    // Simulate data loading delay
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        isLoading = false; // Set to false when data is loaded
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: Colors.blueGrey,
          onPressed: () {
            functions.pickVideo(context);
          },
          icon: const Icon(
            FontAwesomeIcons.video,
            color: Colors.red,
          ),
          label: const Text("Add videos"),
        ),
        appBar: PreferredSize(
          preferredSize:
              const Size.fromHeight(65), // Adjust this value as needed
          child: AppBar(
            automaticallyImplyLeading: false,
            elevation: 0,
            backgroundColor: Colors.white,
            titleSpacing: 0,
            title: const Padding(
              padding: EdgeInsets.only(left: 40),
              child: Text(
                "Profile",
                style: TextStyle(color: Colors.black, fontSize: 30),
              ),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 25),
                child: InkWell(
                  onTap: () async {
                    functions.transfer_request_email();
                  },
                  child: const Icon(
                    FontAwesomeIcons.rightLeft,
                    color: Colors.black,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: InkWell(
                  onTap: () {
                    Get.to(() => const adminapprove());
                  },
                  child: const Icon(
                    FontAwesomeIcons.bell,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
        body: GetBuilder(
          init: FetchDataFirebase(),
          builder: (controller) {
            if (isLoading) {
              return ShimmerProfileWidget();
            } else {
              return RefreshIndicator(
                onRefresh: () async {
                  vidcontroller.Getallvideos();
                  controller.GetDataFirebase();
                },
                child: Obx(() => ListView(
                      children: controller.mylist
                          .where((e) =>
                              e.email ==
                              FirebaseAuth.instance.currentUser!.email)
                          .map(
                            (element) => Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(20),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                      Expanded(
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 20),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  Text(
                                                    element.fullname,
                                                    style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
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
                                                  const Text(
                                                    "Phone: ",
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Text(
                                                    element.phoneNumber,
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
                                                        Get.to(CustomBottomSheet(
                                                            data: editprofiledata(
                                                          fullname:
                                                              element.fullname,
                                                          city: element.city,
                                                          image_Url:
                                                              element.image_Url,
                                                          phoneNumber: element
                                                              .phoneNumber,
                                                        )));
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

                                const Padding(
                                  padding: EdgeInsets.only(left: 15),
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
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
                                videopagegridview()
                              ],
                            ),
                          )
                          .toList(),
                    )),
              );
            }
          },
        ),
      ),
    );
  }
}
