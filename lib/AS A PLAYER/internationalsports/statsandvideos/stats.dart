import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finalyear/wedgets/reusraw.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class stats extends StatelessWidget {
  stats({super.key});

  final currentUser = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            StreamBuilder(
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
                          return SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 30,
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
                            ),
                          );
                        });
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                }),
          ],
        ),
      ),
    );
  }
}

