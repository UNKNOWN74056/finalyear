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
    // final FirebaseStorage storage = FirebaseStorage.instance;
    // final Reference ref = storage.ref().child('comments');
    // final TaskSnapshot task =
    //     await ref.putString(_commentcontroler.text.toString()).whenComplete(() {
    //   _commentcontroler.clear();
    // });
    // final String commenturl = await task.ref.getDownloadURL();
    // final http.Response response = await http.get(Uri.parse(commenturl));
    // final String commentData = response.body;
    await FirebaseFirestore.instance.collection('comments').doc(comment).set({
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
    await FirebaseFirestore.instance
        .collection("users")
        .doc(widget.post['email'])
        .update({
      'rating': rating,
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
                            .collection("comments")
                            .snapshots(),
                        builder:
                            (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.hasData) {
                            return Expanded(
                              child: ListView.builder(
                                  itemCount: snapshot.data!.docs.length,
                                  shrinkWrap: true,
                                  itemBuilder: (context, i) {
                                    var data = snapshot.data!.docs[i];
                                    return ListTile(
                                      title: Text(data['name']),
                                      leading: CircleAvatar(
                                          radius: 30,
                                          backgroundImage:
                                              NetworkImage(data['image'])),
                                      trailing: GestureDetector(
                                        onTap: () {
                                          if (data['commenter'] ==
                                              currentuser) {
                                            data.reference.delete();
                                          } else {
                                            return null;
                                          }
                                        },
                                        child: const Icon(
                                          FontAwesomeIcons.trash,
                                          color: Colors.red,
                                        ),
                                      ),
                                      subtitle: Text(data['comment']),
                                    );
                                  }),
                            );
                          }
                          return Center(
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
                                      child: TextFormField(
                                        cursorColor: Colors.black,
                                        cursorHeight: 20,
                                        controller: _commentcontroler,
                                        textAlignVertical:
                                            TextAlignVertical.center,
                                        keyboardType: TextInputType.multiline,
                                        maxLines: 5,
                                        minLines: 2,
                                        decoration: InputDecoration(
                                            hintText: "Write your comment....",
                                            prefixIcon: Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 20),
                                              child: CircleAvatar(
                                                radius: 30,
                                                backgroundImage: NetworkImage(
                                                    data['Imageurl']),
                                              ),
                                            ),
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
                                                      color: Color.fromARGB(
                                                          255, 0, 1, 5)),
                                                ),
                                              ],
                                            ),
                                            contentPadding:
                                                const EdgeInsets.all(5)),
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
          child: const Icon(FontAwesomeIcons.solidComment),
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
                height: 5,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Text(
                      "RATING:$rating",
                      style: const TextStyle(fontSize: 25),
                    ),
                  )
                ],
              ),
              Container(
                child: RatingBar.builder(
                  minRating: 0,
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
