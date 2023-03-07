import 'package:finalyear/main.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finalyear/wedgets/reusraw.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
//import 'package:http/http.dart' as http;

class coachdetail extends StatefulWidget {
  final DocumentSnapshot post;

  const coachdetail({super.key, required this.post});

  @override
  State<coachdetail> createState() => _coachdetailState();
}

class _coachdetailState extends State<coachdetail> {
  //controller
  final TextEditingController _commentcontroler = TextEditingController();
  //add comment in firestore
  Future addcommnet(String name, String image, String comment) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(widget.post['email'])
        .collection("comments")
        .doc(comment)
        .set({
      'image': image,
      'commented_on': widget.post['email'],
      'name': name,
      'time': DateTime.now(),
      'commenter': currentuser.toString(),
      'comment': _commentcontroler.text.toString(),
    }).whenComplete(() {
      _commentcontroler.clear();
    });
  }

//rating funtion
  Future addrating() async {
    double totalrating = 0;
    await FirebaseFirestore.instance
        .collection("users")
        .doc(widget.post['email'])
        .collection("ratings")
        .doc(currentuser)
        .set({
      'email': widget.post['email'],
      'rating': rating,
    });

    var querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(widget.post['email'])
        .collection("ratings")
        .where('email', isEqualTo: widget.post['email'])
        .get();

    int numRatings = querySnapshot.docs.length;
    for (var doc in querySnapshot.docs) {
      totalrating += doc.data()['rating'] as double;
    }
    double ratingavg = totalrating / numRatings;
    print('Average rating: $ratingavg');
    await FirebaseFirestore.instance
        .collection("users")
        .doc(widget.post['email'])
        .collection("ratings")
        .doc(currentuser)
        .update({
      'rating': ratingavg,
    });
    await FirebaseFirestore.instance
        .collection("users")
        .doc(widget.post['email'])
        .update({
      'rating': ratingavg,
    });
  }

  final currentuser = FirebaseAuth.instance.currentUser!.email;

  //dispose
  @override
  void dispose() {
    _commentcontroler.dispose();
    super.dispose();
  }

  double rating = 0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.black,
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
                            .collection("users")
                            .doc(widget.post['email'])
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
                                    Timestamp timestamp = data['time'];
                                    DateTime dateTime = timestamp.toDate();

                                    return Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.25,
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
                                            Container(
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
                                                    child: Container(
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
                                    final _namecontroller = data['fullname'];
                                    final image = data['Imageurl'];
                                    return Padding(
                                      padding: EdgeInsets.only(
                                          bottom: MediaQuery.of(context)
                                              .viewInsets
                                              .bottom),
                                      child: Padding(
                                        padding: EdgeInsets.all(15),
                                        child: TextFormField(
                                          cursorColor: Colors.black,
                                          cursorWidth: 5,
                                          cursorHeight: 20,
                                          controller: _commentcontroler,
                                          textAlignVertical:
                                              TextAlignVertical.center,
                                          keyboardType: TextInputType.multiline,
                                          maxLines: 3,
                                          minLines: 2,
                                          decoration: InputDecoration(
                                            filled: true,
                                            isDense: true,
                                            contentPadding:
                                                const EdgeInsets.symmetric(
                                                    vertical: 10),
                                            fillColor: Colors.white70,
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            hintText: "Write your comment....",
                                            suffixIcon: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                GestureDetector(
                                                  onTap: (() {
                                                    addcommnet(
                                                        _namecontroller
                                                            .toString(),
                                                        image.toString(),
                                                        _commentcontroler.text
                                                            .toString());
                                                  }),
                                                  child: const Icon(
                                                      FontAwesomeIcons
                                                          .solidPaperPlane,
                                                      size: 20,
                                                      color: Color.fromARGB(
                                                          255, 0, 1, 5)),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  });
                            }
                            return const Center(
                                child: CircularProgressIndicator());
                          }),
                    ],
                  );
                });
          },
          child: const Icon(
            FontAwesomeIcons.commentDots,
          ),
        ),
        appBar: AppBar(
          title: const Text("Profile"),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundImage: NetworkImage(widget.post['Imageurl']),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                width: 200,
                height: 26,
                child: StreamBuilder(
                  stream: FirebaseFirestore.instance
                      .collection("users")
                      .where("email", isEqualTo: widget.post["email"])
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: (context, i) {
                          var data = snapshot.data!.docs[i];
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "Rating:",
                                style: TextStyle(fontSize: 17),
                              ),
                              Text(data['rating'].toString())
                            ],
                          );
                        },
                      );
                    }
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ),
              ),
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
              reusableraw(
                  title: "Name",
                  value: widget.post["fullname"],
                  icondata: FontAwesomeIcons.solidUser),
              reusableraw(
                  title: "City:",
                  value: widget.post["city"],
                  icondata: FontAwesomeIcons.locationDot),
              reusableraw(
                  title: "Gender:",
                  value: widget.post["gender"],
                  icondata: FontAwesomeIcons.phone),
              reusableraw(
                  title: "Email:",
                  value: widget.post["email"],
                  icondata: FontAwesomeIcons.solidEnvelope),
              reusableraw(
                  title: "Contect:",
                  value: widget.post["phoneNumber"],
                  icondata: FontAwesomeIcons.phone),
              reusableraw(
                  title: "Sport:",
                  value: widget.post["sport"],
                  icondata: Icons.sports),
              reusableraw(
                  title: "Profession:",
                  value: widget.post["profession"],
                  icondata: FontAwesomeIcons.userTie),
              const SizedBox(
                height: 8,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
