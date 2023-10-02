import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finalyear/components/comment-widgets/commentshimmer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get_time_ago/get_time_ago.dart';

import 'comenttextfield.dart';
import 'customesendbutton.dart';

class commentclublist extends StatelessWidget {
  final _commentcontroller = TextEditingController();
  final String postEmail; // Add this variable

  commentclublist({required this.postEmail});

  //add comment in firestore
  Future addcomment(String name, String image, String comment) async {
    await FirebaseFirestore.instance
        .collection('clubs')
        .doc(postEmail)
        .collection("comments")
        .add({
      'image': image,
      'commented_on': postEmail,
      'name': name,
      'time': DateTime.now(),
      'commenter': currentuser.toString(),
      'comment': comment, // Use the passed comment argument directly
    }).then((newCommentDoc) {
      Get.snackbar("Message", "comment posted.",
          backgroundColor: Colors.green, colorText: Colors.white);
      _commentcontroller.clear();
    }).catchError((error) {
      Get.snackbar("Error", "Error while posting comment.",
          backgroundColor: Colors.red, colorText: Colors.white);
    });
  }

  //cureent user
  final currentuser = FirebaseAuth.instance.currentUser!.email;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.9,
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 40),
            child: Text(
              "Comments",
              style: TextStyle(fontSize: 20),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Divider(
            // Add a Divider here
            color: Colors.grey, // Adjust the color as needed
            height: 0.5, // Adjust the height as needed
          ),
          // Comment list using StreamBuilder
          StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("clubs")
                .doc(postEmail)
                .collection("comments")
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Expanded(
                  child: ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      shrinkWrap: true,
                      itemBuilder: (context, i) {
                        var data = snapshot.data!.docs[i];
                        Timestamp date = snapshot.data!.docs[i]['time'];
                        var finaldate =
                            DateTime.parse(date.toDate().toString());

                        return SizedBox(
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                            children: [
                              Slidable(
                                endActionPane: ActionPane(
                                    motion: const ScrollMotion(),
                                    children: [
                                      SlidableAction(
                                        onPressed: (context) {
                                          if (data['commenter'] ==
                                              currentuser) {
                                            data.reference.delete();
                                          } else {
                                            null;
                                          }
                                        },
                                        backgroundColor: const Color.fromARGB(
                                            255, 252, 6, 6),
                                        foregroundColor: Colors.white,
                                        icon: FontAwesomeIcons.trash,
                                        label: 'Delete',
                                      )
                                    ]),
                                child: ListTile(
                                  leading: CircleAvatar(
                                    backgroundImage:
                                        NetworkImage(data['image']),
                                    radius: 20,
                                  ),
                                  title: Row(
                                    children: [
                                      Text(
                                        data['name'],
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(
                                          width:
                                              10), // Add some space between name and timestamp
                                      Text(
                                        GetTimeAgo.parse(finaldate),
                                        style: const TextStyle(
                                          color: Colors.grey,
                                          fontSize:
                                              12, // Adjust the font size as needed
                                        ),
                                      ),
                                    ],
                                  ),
                                  subtitle: Text(
                                    data['comment'],
                                    style: const TextStyle(),
                                  ),
                                ),
                              ),
                              Divider(
                                color: Colors.grey.shade300,
                                thickness: 0.8,
                                height: 0,
                              ),
                            ],
                          ),
                        );
                      }),
                );
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                // Show shimmer effect while loading
                return ShimmerLoadingWidget();
              } else {
                return const Center(
                  child:
                      Text("Error loading data"), // Handle error case as needed
                );
              }
            },
          ),
          // Comment text field
          StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("users")
                  .where("email", isEqualTo: currentuser)
                  .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      shrinkWrap: true,
                      itemBuilder: (context, i) {
                        var data = snapshot.data!.docs[i];
                        final namecontroller = data['fullname'];
                        final image = data['Imageurl'];
                        return Padding(
                            padding: EdgeInsets.only(
                                bottom:
                                    MediaQuery.of(context).viewInsets.bottom),
                            child: Padding(
                              padding: const EdgeInsets.all(15),
                              child: Row(
                                children: [
                                  Expanded(
                                      child: Stack(
                                    children: [
                                      // Text field
                                      commenttextfield(
                                        controller: _commentcontroller,
                                      ),

                                      // Positioned "Send" button
                                      Positioned(
                                        right:
                                            8, // Adjust the position as needed
                                        bottom:
                                            3, // Adjust the position as needed
                                        child: CustomSendButton(
                                          onPressed: () {
                                            final commenttext =
                                                _commentcontroller.text;
                                            if (commenttext.isNotEmpty) {
                                              addcomment(
                                                namecontroller.toString(),
                                                image.toString(),
                                                _commentcontroller.text
                                                    .toString(),
                                              );
                                            } else {
                                              // Show a message to the user that they need to enter a comment
                                              Get.snackbar("Message",
                                                  "please enter your comment first.",
                                                  backgroundColor: Colors.red,
                                                  colorText: Colors.white);
                                            }
                                          },
                                        ),
                                      ),
                                    ],
                                  ))
                                ],
                              ),
                            ));
                      });
                }
                return const Center(child: Text("Loading..."));
              }),
        ],
      ),
    );
  }
}
