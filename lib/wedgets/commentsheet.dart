import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_time_ago/get_time_ago.dart';

Future<void> buildCommentModalBottomSheet({
  required BuildContext context,
  required String currentuser,
  required TextEditingController commentController,
  required Function(String, String, String) addComment,
  required User user,
}) async {
  await showModalBottomSheet(
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
    ),
    context: context,
    builder: (context) {
      return Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 40),
            child: Text(
              "Comments",
              style: TextStyle(fontSize: 20),
            ),
          ),
          StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("users")
                .doc(user.email)
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
                      var finaldate = DateTime.parse(date.toDate().toString());

                      return SizedBox(
                        height: MediaQuery.of(context).size.height * 0.25,
                        width: MediaQuery.of(context).size.width,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    backgroundImage:
                                        NetworkImage(data['image']),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Container(
                                      child: Row(
                                        children: [
                                          Text(
                                            data['name'],
                                            style: const TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 1,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 15),
                                child: Row(
                                  children: [
                                    const Icon(
                                      Icons.arrow_forward_ios_outlined,
                                      size: 15,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                0.75,
                                        child: Text(data['comment']),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        if (data['commenter'] == currentuser) {
                                          data.reference.delete();
                                        } else {
                                          null;
                                        }
                                      },
                                      child: const Icon(
                                        FontAwesomeIcons.trash,
                                        color: Colors.red,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: Row(
                                children: [
                                  Text(GetTimeAgo.parse(finaldate)),
                                ],
                              ),
                            ),
                            const Divider(
                              color: Colors.black,
                            )
                          ],
                        ),
                      );
                    },
                  ),
                );
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          ),
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
                        bottom: MediaQuery.of(context).viewInsets.bottom,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: TextFormField(
                          cursorColor: Colors.black,
                          cursorWidth: 5,
                          cursorHeight: 20,
                          controller: commentController,
                          textAlignVertical: TextAlignVertical.center,
                          keyboardType: TextInputType.multiline,
                          maxLines: 3,
                          minLines: 2,
                          decoration: InputDecoration(
                            filled: true,
                            isDense: true,
                            contentPadding:
                                const EdgeInsets.symmetric(vertical: 10),
                            fillColor: Colors.white70,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            hintText: "Write your comment....",
                            suffixIcon: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    addComment(
                                      namecontroller.toString(),
                                      image.toString(),
                                      commentController.text.toString(),
                                    );
                                  },
                                  child: const Icon(
                                    FontAwesomeIcons.solidPaperPlane,
                                    size: 20,
                                    color: Color.fromARGB(255, 0, 1, 5),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              }
              return const Center(child: Text("Loading..."));
            },
          ),
        ],
      );
    },
  );
}
