import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ClubCard extends StatefulWidget {
  final String clubname;
  final String clubimage;
  final String location;
  final Function() onTap;

  const ClubCard({
    required this.clubname,
    required this.clubimage,
    required this.location,
    required this.onTap,
  });

  @override
  _ClubCardState createState() => _ClubCardState();
}

class _ClubCardState extends State<ClubCard> {
  bool isLoading = true; // Initially set to true for shimmer loading

  @override
  void initState() {
    super.initState();
    // Simulate data loading delay
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        isLoading = false; // Set to false when data is loaded
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      // Show shimmer loading when isLoading is true
      return Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Card(
          // Shimmer loading card content
          color: Colors.grey.shade300,
          shape: RoundedRectangleBorder(
            side: const BorderSide(
              color: Color.fromARGB(255, 25, 9, 117),
              width: 1,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: ListTile(
            title: Container(
              width: double.infinity,
              height: 20.0,
              color: Colors.grey[300],
            ),
            leading: const CircleAvatar(
              radius: 35,
              backgroundColor: Colors.white,
            ),
            subtitle: Container(
              width: double.infinity,
              height: 16.0,
              color: Colors.grey[300],
            ),
            trailing: const Icon(
              FontAwesomeIcons.arrowRight,
              color: Color.fromARGB(201, 224, 224, 224),
            ),
            onTap: () {},
          ),
        ),
      );
    } else {
      // Show the actual card content
      return Card(
        color: Colors.grey.shade300,
        shape: RoundedRectangleBorder(
          side: const BorderSide(
            color: Color.fromARGB(255, 25, 9, 117),
            width: 1,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: ListTile(
          title: Text(widget.clubname, style: const TextStyle(fontSize: 20)),
          leading: CircleAvatar(
            radius: 35,
            backgroundImage: NetworkImage(widget.clubimage),
            backgroundColor: Colors.white,
          ),
          subtitle: Text(widget.location, style: const TextStyle(fontSize: 15)),
          trailing: const Icon(
            FontAwesomeIcons.arrowRight,
          ),
          onTap: widget.onTap,
        ),
      );
    }
  }
}
