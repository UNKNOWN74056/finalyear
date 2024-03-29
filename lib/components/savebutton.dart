import 'package:flutter/material.dart';

class savebutton extends StatelessWidget {
  final Function()? onTap;
  final Widget child; // Specify the type of the child as Widget

  const savebutton({Key? key, required this.onTap, required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.symmetric(horizontal: 70),
        decoration: BoxDecoration(
            color: Colors.blueGrey, borderRadius: BorderRadius.circular(8)),
        child: Center(
          child: DefaultTextStyle.merge(
            style: const TextStyle(
                color: Colors.white), // Set the text color to white
            child: child,
          ),
        ),
      ),
    );
  }
}
