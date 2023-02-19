import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finalyear/wedgets/commentspage.dart';
import 'package:finalyear/wedgets/reusraw.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';

class coachdetail extends StatefulWidget {
  final DocumentSnapshot post;

  const coachdetail({super.key, required this.post});

  @override
  State<coachdetail> createState() => _coachdetailState();
}

class _coachdetailState extends State<coachdetail> {
  //controller
  final TextEditingController _commentcontroler = TextEditingController();
  //bool function
  bool _showComments = false;

//toggle button to show button
  void _toggleComments() {
    setState(() {
      _showComments = !_showComments;
    });
  }

  double rating = 0;
  @override
  Widget build(BuildContext context) {
    double _rating;

    return SafeArea(
      child: Scaffold(
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
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: _toggleComments,
                    child: const Text(
                      'Comments',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  if (_showComments)
                    Container(
                      width: MediaQuery.of(context).size.width - 55,
                      child: Card(
                        margin:
                            const EdgeInsets.only(left: 9, right: 2, bottom: 8),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(9)),
                        color: Colors.white60,
                        child: TextFormField(
                          cursorColor: Colors.black,
                          cursorHeight: 20,
                          controller: _commentcontroler,
                          textAlignVertical: TextAlignVertical.center,
                          keyboardType: TextInputType.multiline,
                          maxLines: 5,
                          minLines: 2,
                          decoration: InputDecoration(
                              hintText: "Write your comment....",
                              prefixIcon: Padding(
                                padding: const EdgeInsets.only(right: 20),
                                child: CircleAvatar(
                                  radius: 30,
                                  backgroundImage:
                                      NetworkImage(widget.post['Imageurl']),
                                ),
                              ),
                              suffixIcon: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  GestureDetector(
                                    onTap: (() {
                                      //    addcommnet();
                                    }),
                                    child: const Icon(
                                        FontAwesomeIcons.solidPaperPlane,
                                        color: Colors.red),
                                  ),
                                ],
                              ),
                              contentPadding: const EdgeInsets.all(5)),
                        ),
                      ),
                    )
                ],
              ),
              const SizedBox(
                height: 20,
              )
            ],
          ),
        ),
      ),
    );
  }
}
