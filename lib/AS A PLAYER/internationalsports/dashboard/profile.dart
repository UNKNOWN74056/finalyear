import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finalyear/AS%20A%20PLAYER/internationalsports/statsandvideos/editprofile.dart';
import 'package:finalyear/AS%20A%20PLAYER/internationalsports/statsandvideos/transferform.dart';
import 'package:finalyear/wedgets/reusebletextfield.dart';
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

final currentUser = FirebaseAuth.instance;

final TextEditingController updatefirstname = TextEditingController();

Future<void> updateuserdailog(BuildContext Context, String firstname) async {
  updatefirstname.text = firstname;
  return showDialog(
      context: Context,
      builder: (context) {
        return AlertDialog(
          title: const Text("updat User Name"),
          content: SingleChildScrollView(
            child: Column(
              children: [
                reusebletextfield(
                    labelText: "username",
                    icon: const Icon(FontAwesomeIcons.solidUser),
                    controller: updatefirstname,
                    validator: (Value) {
                      return Value.isEmpty ? "enter your email" : null;
                    },
                    autoValidateMode: AutovalidateMode.onUserInteraction,
                    autovalidateMode: AutovalidateMode.onUserInteraction),
              ],
            ),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Cancel")),
            TextButton(
                onPressed: () {
                  final update = FirebaseFirestore.instance
                      .collection("users")
                      .doc(currentUser.currentUser!.email);
                  update.update({
                    'firstname': updatefirstname.text.toString()
                  }).then((value) => {updatefirstname.clear()});
                  Navigator.pop(context);
                },
                child: const Text("Ok"))
          ],
        );
      });
}

class _profileState extends State<profile>{
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
                          GestureDetector(
                            onTap: () {
                              Get.to(
                                  updateuserdailog(context, data['firstname']));
                            },
                            child: reusableraw(
                              title: "Name:",
                              value: data["firstname"],
                              icondata: FontAwesomeIcons.solidUser,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Get.to(updateuserdailog(context, data['city']));
                            },
                            child: reusableraw(
                                title: "City:",
                                value: data["city"],
                                icondata: FontAwesomeIcons.locationDot),
                          ),
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
