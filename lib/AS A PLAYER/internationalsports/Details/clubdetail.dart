import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class clubdetail extends StatefulWidget {
  const clubdetail({super.key});

  @override
  State<clubdetail> createState() => _clubdetailState();
}

class _clubdetailState extends State<clubdetail> {
  double rating = 0;

  @override
  Widget build(BuildContext context) {
    double _rating;
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(children: [
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Row(
            children: const [
              Padding(
                padding: EdgeInsets.only(top: 100),
                child: Center(
                  child: Text(
                    "Club name",
                    style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ]),
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            CircleAvatar(
              radius: 90,
              backgroundImage: AssetImage("assets/stadium.jpg"),
            ),
          ],
        ),
        const SizedBox(
          height: 20,
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
            minRating: 1,
            itemBuilder: (context, _) => const Icon(Icons.star),
            updateOnDrag: true,
            onRatingUpdate: (rating) => setState(() {
              this.rating = rating;
            }),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Container(
          height: 250,
          width: 500,
          color: Colors.grey,
          child: Center(
            child: Column(
              children: const [
                Text(
                  "Deatails",
                  style: TextStyle(fontSize: 25),
                ),
                Text(
                  "Location:peshawar.",
                  style: TextStyle(fontSize: 25),
                ),
                Text(
                  "Address: near to iqra school.",
                  style: TextStyle(fontSize: 25),
                ),
                Text(
                  "Motivation: We provide best trainning.",
                  style: TextStyle(fontSize: 25),
                ),
                Text(
                  "Contect: 0325343535",
                  style: TextStyle(fontSize: 25),
                ),
                Text(
                  "Email : hama@gmail.com",
                  style: TextStyle(fontSize: 25),
                )
              ],
            ),
          ),
        )
      ]),
    ));
  }
}
