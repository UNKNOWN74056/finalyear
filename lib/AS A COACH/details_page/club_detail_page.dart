import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get_time_ago/get_time_ago.dart';

import '../../../GETX/fullscreenphoto.dart';
import '../../wedgets/comment-widgets/comenttextfield.dart';
import '../../wedgets/comment-widgets/customesendbutton.dart';

class club_detail_page extends StatefulWidget {
  final post;

  const club_detail_page({super.key, required this.post});

  @override
  State<club_detail_page> createState() => _clubdetailState();
}

class _clubdetailState extends State<club_detail_page> {
  //controller
  final TextEditingController _commentcontroller = TextEditingController();

  //add comment to firestore
  Future addcomment(String name, String image, String comment) async {
    await FirebaseFirestore.instance
        .collection('clubs')
        .doc(widget.post.email)
        .collection("comments")
        .add({
      'image': image,
      'commented_on': widget.post.email,
      'name': name,
      'time': DateTime.now(),
      'commenter': currentuser.toString(),
      'comment': comment, // Use the passed comment argument directly
    }).then((newCommentDoc) {
      print("Comment added with ID: ${newCommentDoc.id}");
      _commentcontroller.clear();
    }).catchError((error) {
      print("Error adding comment: $error");
    });
  }

  //rating funtion
  Future addrating() async {
    double totalrating = 0;
    await FirebaseFirestore.instance
        .collection("clubs")
        .doc(widget.post.email)
        .collection("ratings")
        .doc(currentuser)
        .set({
      'Email': widget.post.email,
      'rating': rating,
    });

    var querySnapshot = await FirebaseFirestore.instance
        .collection('clubs')
        .doc(widget.post.email)
        .collection("ratings")
        .where('Email', isEqualTo: widget.post.email)
        .get();

    int numRatings = querySnapshot.docs.length;
    for (var doc in querySnapshot.docs) {
      totalrating += doc.data()['rating'] as double;
    }
    double ratingavg = totalrating / numRatings;
    print('Average rating: $ratingavg');
    await FirebaseFirestore.instance
        .collection("clubs")
        .doc(widget.post.email)
        .collection("ratings")
        .doc(currentuser)
        .update({
      'rating': ratingavg.toString(),
    });
    await FirebaseFirestore.instance
        .collection("clubs")
        .doc(widget.post.email)
        .update({
      'rating': ratingavg.toString(),
    });
  }

  //dispose
  @override
  void dispose() {
    _commentcontroller.dispose();
    super.dispose();
  }

  final currentuser = FirebaseAuth.instance.currentUser!.email;

  double rating = 0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            showModalBottomSheet(
                isScrollControlled: true,
                shape: const RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(10))),
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
                            .collection("clubs")
                            .doc(widget.post.email)
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
                                    Timestamp date =
                                        snapshot.data!.docs[i]['time'];
                                    var finaldate = DateTime.parse(
                                        date.toDate().toString());
                                    return SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.30,
                                      width: MediaQuery.of(context).size.width,
                                      child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 10),
                                              child: Row(
                                                children: [
                                                  CircleAvatar(
                                                    backgroundImage:
                                                        NetworkImage(
                                                            data['image']),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 8.0),
                                                    child: Container(
                                                      child: Row(children: [
                                                        Text(
                                                          data['name'],
                                                          style: const TextStyle(
                                                              fontSize: 15,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                        ),
                                                      ]),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            SizedBox(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  1,
                                              child: Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 15),
                                                child: Row(children: [
                                                  const Icon(
                                                    Icons
                                                        .arrow_forward_ios_outlined,
                                                    size: 15,
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 10),
                                                    child: SizedBox(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.75,
                                                      child:
                                                          Text(data['comment']),
                                                    ),
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {
                                                      if (data['commenter'] ==
                                                          currentuser) {
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
                                                ]),
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 20),
                                              child: Row(
                                                children: [
                                                  Text(GetTimeAgo.parse(
                                                      finaldate))
                                                ],
                                              ),
                                            ),
                                            const Divider(
                                              color: Colors.black,
                                            )
                                          ]),
                                    );
                                  }),
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
                          builder:
                              (context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
                                            bottom: MediaQuery.of(context)
                                                .viewInsets
                                                .bottom),
                                        child: Padding(
                                            padding: EdgeInsets.only(
                                                bottom: MediaQuery.of(context)
                                                    .viewInsets
                                                    .bottom),
                                            child: Padding(
                                              padding: const EdgeInsets.all(15),
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                      child: Stack(
                                                    children: [
                                                      // Text field
                                                      commenttextfield(
                                                        controller:
                                                            _commentcontroller,
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
                                                                _commentcontroller
                                                                    .text;
                                                            if (commenttext
                                                                .isNotEmpty) {
                                                              addcomment(
                                                                namecontroller
                                                                    .toString(),
                                                                image
                                                                    .toString(),
                                                                _commentcontroller
                                                                    .text
                                                                    .toString(),
                                                              );
                                                            } else {
                                                              // Show a message to the user that they need to enter a comment
                                                              Get.snackbar(
                                                                  "Message",
                                                                  "please enter your comment first.",
                                                                  backgroundColor:
                                                                      Colors
                                                                          .red,
                                                                  colorText:
                                                                      Colors
                                                                          .white);
                                                            }
                                                          },
                                                        ),
                                                      ),
                                                    ],
                                                  ))
                                                ],
                                              ),
                                            )));
                                  });
                            }
                            return const Center(
                                child: CircularProgressIndicator());
                          }),
                    ],
                  );
                });
          },
          child: const Icon(FontAwesomeIcons.commentDots)),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                height: 200,
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(widget.post.clubimage),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SafeArea(
                child: IconButton(
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.post.clubname,
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      children: [
                        const Icon(Icons.star, color: Colors.amber),
                        const SizedBox(width: 5),
                        Text(
                          widget.post.rating,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const Text("Sports: ", style: TextStyle(fontSize: 18)),
                    Text(
                      widget.post.sport,
                      style: const TextStyle(fontSize: 18),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const Text("Contact: ", style: TextStyle(fontSize: 18)),
                    Text(
                      widget.post.phonenumber,
                      style: const TextStyle(fontSize: 18),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    const Text("Email: ", style: TextStyle(fontSize: 18)),
                    Text(
                      widget.post.email,
                      style: const TextStyle(fontSize: 18),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Container(
                      child: RatingBar.builder(
                        minRating: 0,
                        allowHalfRating: true,
                        itemBuilder: (context, _) => const Icon(Icons.star),
                        updateOnDrag: true,
                        onRatingUpdate: (rating) => setState(() {
                          this.rating = rating;
                          addrating();
                        }),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                const Text(
                  'Photos',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection("clubphoto")
                    .where("Email", isEqualTo: widget.post.email)
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return const Text('Something went wrong');
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: Text("Loading...."));
                  }

                  final photos = snapshot.data!.docs
                      .where((doc) => doc['Email'] == widget.post.email)
                      .map((doc) => {
                            'id': doc.id,
                            'photo': doc['clubphoto'],
                            'Email': doc['Email'],
                          })
                      .toList();

                  return GridView.builder(
                    itemCount: photos.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemBuilder: (BuildContext context, int index) {
                      final photo = photos[index];
                      return InkWell(
                        onTap: () {
                          // Navigate to full-screen photo screen
                          Get.to(FullScreenPhoto(photo: photo['photo']));
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            photo['photo'],
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          )
        ],
      ),
    ));
  }
}
