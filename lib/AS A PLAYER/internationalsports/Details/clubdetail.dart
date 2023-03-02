import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finalyear/wedgets/reusraw.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class clubdetail extends StatefulWidget {
  final DocumentSnapshot post;

  const clubdetail({super.key, required this.post});

  @override
  State<clubdetail> createState() => _clubdetailState();
}

class _clubdetailState extends State<clubdetail> {
  double rating = 0;
  @override
  Widget build(BuildContext context) {
    double _rating;

    return SafeArea(
      child: Scaffold(
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
                    backgroundImage: NetworkImage(widget.post['Clubimage']),
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
                  title: "Club Name",
                  value: widget.post["Clubname"],
                  icondata: FontAwesomeIcons.solidUser),
              reusableraw(
                  title: "Location:",
                  value: widget.post["Location"],
                  icondata: FontAwesomeIcons.locationDot),
              reusableraw(
                  title: "Email:",
                  value: widget.post["Email"],
                  icondata: FontAwesomeIcons.solidEnvelope),
              reusableraw(
                  title: "Contect:",
                  value: widget.post["Phone"],
                  icondata: FontAwesomeIcons.phone),
              reusableraw(
                  title: "Sport:",
                  value: widget.post["sport"],
                  icondata: FontAwesomeIcons.futbol),
            ],
          ),
        ),
      ),
    );
  }
}
