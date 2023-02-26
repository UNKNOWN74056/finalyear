import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finalyear/AS%20A%20PLAYER/internationalsports/statsandvideos/transferform.dart';
import 'package:finalyear/AS%20A%20PLAYER/internationalsports/statsandvideos/videos.dart';
import 'package:finalyear/wedgets/reusraw.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../wedgets/update_page.dart';

class profile extends StatefulWidget {
  const profile({super.key});

  @override
  State<profile> createState() => _profileState();
}

File? _image;
final ImagePicker picker = ImagePicker();

final currentUser = FirebaseAuth.instance;

final TextEditingController updatefullname = TextEditingController();
final TextEditingController updatecity = TextEditingController();
final TextEditingController updategender = TextEditingController();

class _profileState extends State<profile> {
  //dailog to select photo from camera or gallery
  void dialogAlert(context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            content: SizedBox(
              height: 120,
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      getCameraImage();
                      Navigator.pop(context);
                    },
                    child: const ListTile(
                      leading: Icon(Icons.camera_alt),
                      title: Text("Camera"),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      getImageGallery();
                      Navigator.pop(context);
                    },
                    child: const ListTile(
                      leading: Icon(Icons.photo),
                      title: Text("Gallery"),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  //pick image from galler
  Future getImageGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print("No Image Selected");
      }
    });
  }

// pick image from camera
  Future getCameraImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print("No Image Selected");
      }
    });
  }

  //update image function
  Future updateimage() async {
    var email = FirebaseAuth.instance.currentUser!.email;
    var refer = await FirebaseStorage.instance
        .ref("/MrSport$email")
        .child('images')
        .putFile(_image!.absolute);
    TaskSnapshot uploadTask = refer;
    await Future.value(uploadTask);
    var newUrl = await refer.ref.getDownloadURL();

    FirebaseFirestore.instance
        .collection("users")
        .doc(email)
        .update({'Imageurl': newUrl});
  }

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
                          Stack(
                            children: [
                              CircleAvatar(
                                radius: 70,
                                backgroundImage: NetworkImage(data['Imageurl']),
                                backgroundColor: Colors.white,
                              ),
                              Positioned(
                                  bottom: 0,
                                  right: 0,
                                  child: Container(
                                    decoration: const BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle,
                                    ),
                                    child: GestureDetector(
                                      onTap: (() {
                                        dialogAlert(context);
                                        updateimage();
                                      }),
                                      child: const Icon(
                                        Icons.edit,
                                        size: 30,
                                      ),
                                    ),
                                  )),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          GestureDetector(
                            onTap: () {
                              usernameupdate(context, data['fullname']);
                            },
                            child: reusableraw(
                              title: "Name:",
                              value: data["fullname"],
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
                          GestureDetector(
                              onTap: (() {
                                Get.to(videos());
                              }),
                              child: const Center(child: Text("Videos")))
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
