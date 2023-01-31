import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finalyear/AS%20A%20PLAYER/internationalsports/statsandvideos/editprofile.dart';
import 'package:finalyear/AS%20A%20PLAYER/internationalsports/statsandvideos/transferform.dart';
import 'package:finalyear/wedgets/reusraw.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class profile extends StatefulWidget {
  const profile({super.key});

  @override
  State<profile> createState() => _profileState();
}

class _profileState extends State<profile> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    //contriller for tabs
    //TabController _tabController = TabController(length: 2, vsync: this);

    final currentUser = FirebaseAuth.instance;

    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              title: const Text(
                "Profile",
                style: TextStyle(fontSize: 30),
              ),
              centerTitle: true,
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: InkWell(
                    onTap: () {
                      Get.to(const transferform());
                    },
                    child: const Icon(FontAwesomeIcons.rightLeft),
                  ),
                )
              ],
            ),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  StreamBuilder(
                      stream: FirebaseFirestore.instance
                          .collection('users')
                          .where('email',
                              isEqualTo: currentUser.currentUser!.email)
                          .snapshots(),
                      builder:
                          (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasData) {
                          return ListView.builder(
                            itemCount: snapshot.data!.docs.length,
                            shrinkWrap: true,
                            itemBuilder: (context, i) {
                              var data = snapshot.data!.docs[i];
                              return Column(
                                children: [
                                  const SizedBox(
                                    height: 15,
                                  ),
                                  CircleAvatar(
                                    radius: 70,
                                    backgroundImage:
                                        NetworkImage(data['Imageurl']),
                                    backgroundColor: Colors.white,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          Get.to(const editprofile());
                                        },
                                        child: const Text(
                                          "Edit",
                                          style: TextStyle(
                                              fontSize: 18, color: Colors.blue),
                                        ),
                                      )
                                    ],
                                  ),
                                  reusableraw(
                                    title: "Name:",
                                    value: data["firstname"],
                                    icondata: FontAwesomeIcons.solidUser,
                                  ),
                                  reusableraw(
                                      title: "City:",
                                      value: data["city"],
                                      icondata: FontAwesomeIcons.locationDot),
                                  reusableraw(
                                      title: "Gender:",
                                      value: data["gender"],
                                      icondata: FontAwesomeIcons.phone),
                                  reusableraw(
                                      title: "Email:",
                                      value: data["email"],
                                      icondata: FontAwesomeIcons.solidEnvelope),
                                  reusableraw(
                                      title: "Contect:",
                                      value: data["phoneNumber"],
                                      icondata: FontAwesomeIcons.phone),
                                  reusableraw(
                                      title: "Sport:",
                                      value: data["sport"],
                                      icondata: Icons.sports),
                                  reusableraw(
                                      title: "Profession:",
                                      value: data["profession"],
                                      icondata: FontAwesomeIcons.userTie),
                                ],
                              );
                            },
                          );
                        } else {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                      }),
                ],
              ),
            )));
  }
}
// StreamBuilder(
//     stream: FirebaseFirestore.instance
//         .collection('users')
//         .where('email', isEqualTo: currentUser.currentUser!.email)
//         .snapshots(),
//     builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
//       if (snapshot.hasData) {
//         return ListView.builder(
//             itemCount: snapshot.data!.docs.length,
//             shrinkWrap: true,
//             itemBuilder: (context, i) {
//               var data = snapshot.data!.docs[i];
//               return SingleChildScrollView(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     const SizedBox(
//                       height: 30,
//                     ),
//                     Container(
//                         child: CircleAvatar(
//                       radius: 70,
//                       child: Image.network(data['Imageurl']),
//                     )),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         GestureDetector(
//                           onTap: () {
//                             Get.to(const editprofile());
//                           },
//                           child: const Text(
//                             "Edit",
//                             style: TextStyle(
//                                 fontSize: 18, color: Colors.blue),
//                           ),
//                         )
//                       ],
//                     ),
//                     reusableraw(
//                       title: "Name:",
//                       value: data["firstname"],
//                       icondata: FontAwesomeIcons.solidUser,
//                     ),
//                     reusableraw(
//                         title: "City:",
//                         value: data["city"],
//                         icondata: FontAwesomeIcons.locationDot),
//                     reusableraw(
//                         title: "Gender:",
//                         value: data["gender"],
//                         icondata: FontAwesomeIcons.phone),
//                     reusableraw(
//                         title: "Email:",
//                         value: data["email"],
//                         icondata: FontAwesomeIcons.solidEnvelope),
//                     reusableraw(
//                         title: "Contect:",
//                         value: data["phoneNumber"],
//                         icondata: FontAwesomeIcons.phone),
//                     reusableraw(
//                         title: "Sport:",
//                         value: data["sport"],
//                         icondata: Icons.sports),
//                     reusableraw(
//                         title: "Profession:",
//                         value: data["profession"],
//                         icondata: FontAwesomeIcons.userTie),
//                   ],
//                 ),
//               );
//             });
//       } else {
//         return const Center(child: CircularProgressIndicator());
//       }
//     }),
