import 'package:flutter/material.dart';

class videos extends StatefulWidget {
  const videos({super.key});

  @override
  State<videos> createState() => _videosState();
}

class _videosState extends State<videos> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
            child: InkWell(
                child: FloatingActionButton.extended(
          onPressed: () {},
          label: const Text("ADD VIDEOS"),
          icon: const Icon(Icons.add),
        )))
      ],
    ));
  }
}
