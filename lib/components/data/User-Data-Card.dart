import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shimmer/shimmer.dart';

class CustomCard extends StatefulWidget {
  final String fullName;
  final String imageUrl;
  final String city;
  final dynamic rating;
  final bool isVarified; // Add this property
  final Function() onTap;

  const CustomCard({
    Key? key,
    required this.fullName,
    required this.imageUrl,
    required this.city,
    required this.rating,
    required this.isVarified,
    required this.onTap,
  }) : super(key: key);

  @override
  _CustomCardState createState() => _CustomCardState();
}

class _CustomCardState extends State<CustomCard> {
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return ListView.builder(
          itemCount: 5,
          shrinkWrap: true,
          itemBuilder: (context, i) {
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
          });
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
          title: Row(
            children: [
              Text(widget.fullName, style: const TextStyle(fontSize: 20)),
              if (widget.isVarified) // Conditionally display the checkmark icon
                const Icon(
                  FontAwesomeIcons.certificate,
                  color: Colors.blue,
                  size: 16,
                ),
            ],
          ),
          leading: CircleAvatar(
            radius: 35,
            backgroundImage: NetworkImage(widget.imageUrl),
            backgroundColor: Colors.white,
          ),
          trailing: const Icon(
            Icons.arrow_forward,
          ),
          onTap: widget.onTap,
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.star,
                    color: Colors.yellow,
                  ),
                  Text(
                    " ${widget.rating}",
                    style: const TextStyle(fontSize: 15),
                  ),
                ],
              ),
              Text(widget.city, style: const TextStyle(fontSize: 15)),
            ],
          ),
        ),
      );
    }
  }
}
