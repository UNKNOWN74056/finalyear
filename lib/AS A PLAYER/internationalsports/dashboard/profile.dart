import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finalyear/AS%20A%20PLAYER/internationalsports/statsandvideos/transferform.dart';
import 'package:finalyear/wedgets/reusraw.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../../wedgets/update_page.dart';

class profile extends StatefulWidget {
  const profile({super.key});

  @override
  State<profile> createState() => _profileState();
}

final currentUser = FirebaseAuth.instance;

final TextEditingController updatefirstname = TextEditingController();
final TextEditingController updatecity = TextEditingController();
final TextEditingController updategender = TextEditingController();

class _profileState extends State<profile> {
  @override
  Widget build(BuildContext context) {
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
        body: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('users')
                .where('email', isEqualTo: currentUser.currentUser!.email)
                .snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  shrinkWrap: true,
                  itemBuilder: (context, i) {
                    var data = snapshot.data!.docs[i];
                    return Container(
                      margin: const EdgeInsets.all(10),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 15,
                          ),
                          CircleAvatar(
                            radius: 70,
                            backgroundImage: NetworkImage(data['Imageurl']),
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
                                  //  Get.to(const editprofile());
                                },
                                child: const Text(
                                  "Edit",
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.blue),
                                ),
                              )
                            ],
                          ),
                          GestureDetector(
                            onTap: () {
                              usernameupdate(context, data['firstname']);
                            },
                            child: reusableraw(
                              title: "Name:",
                              value: data["firstname"],
                              icondata: FontAwesomeIcons.solidUser,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Get.to(cityupdate(context, data['city']));
                            },
                            child: reusableraw(
                                title: "City:",
                                value: data["city"],
                                icondata: FontAwesomeIcons.locationDot),
                          ),
                          GestureDetector(
                            onTap: () {
                              Get.to(genderupdate(context, data['gender']));
                            },
                            child: reusableraw(
                                title: "Gender:",
                                value: data["gender"],
                                icondata: FontAwesomeIcons.venusMars),
                          ),
                          reusableraw(
                              title: "Email:",
                              value: data["email"],
                              icondata: FontAwesomeIcons.solidEnvelope),
                          GestureDetector(
                            onTap: () {
                              Get.to(phoneupdate(context, data['phoneNumber']));
                            },
                            child: reusableraw(
                                title: "Contect:",
                                value: data["phoneNumber"],
                                icondata: FontAwesomeIcons.phone),
                          ),
                          GestureDetector(
                            onTap: () {
                              //  Get.to(sportupdate(context, data['sport']));
                            },
                            child: reusableraw(
                                title: "Sport:",
                                value: data["sport"],
                                icondata: Icons.sports),
                          ),
                          reusableraw(
                              title: "Profession:",
                              value: data["profession"],
                              icondata: FontAwesomeIcons.userTie),
                        ],
                      ),
                    );
                  },
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            }),
      ),
    );
  }
}
