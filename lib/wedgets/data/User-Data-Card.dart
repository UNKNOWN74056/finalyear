import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CustomCard extends StatefulWidget {
  final String fullName;
  final String imageUrl;
  final String city;
  final Function() onTap;

  const CustomCard({
    super.key,
    required this.fullName,
    required this.imageUrl,
    required this.city,
    required this.onTap,
  });

  @override
  _CustomCardState createState() => _CustomCardState();
}

class _CustomCardState extends State<CustomCard> {
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
      return Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        child: Card(
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
            trailing: Icon(
              Icons.arrow_forward,
              color: Colors.grey[300],
            ),
            onTap: () {},
            subtitle: Container(
              width: double.infinity,
              height: 16.0,
              color: Colors.grey[300],
            ),
          ),
        ),
      );
    } else {
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
          title: Text(widget.fullName, style: const TextStyle(fontSize: 20)),
          leading: CircleAvatar(
            radius: 35,
            backgroundImage: NetworkImage(widget.imageUrl),
            backgroundColor: Colors.white,
          ),
          trailing: const Icon(
            Icons.arrow_forward,
          ),
          onTap: widget.onTap,
          subtitle: Text(widget.city, style: const TextStyle(fontSize: 15)),
        ),
      );
    }
  }
}
