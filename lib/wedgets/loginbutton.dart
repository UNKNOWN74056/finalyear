import 'package:flutter/material.dart';

class loginbutton extends StatelessWidget {
  final Function()? onTap;
  final child;

  const loginbutton({super.key, required this.onTap, required this.child});

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
          child: child,
        ),
      ),
    );
  }
}
