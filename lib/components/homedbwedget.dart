import 'package:flutter/material.dart';

class homedbwedget extends StatelessWidget {
  final String imagepath;
  final child;

  const homedbwedget({super.key, required this.imagepath,required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),
      height: 250,
      padding:  EdgeInsets.all(20),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(16),
          image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage(
                imagepath,
              ))),
              child: child,
    );
  }
}
