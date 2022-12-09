import 'package:finalyear/AS%20A%20PLAYER/internationalsports/statsandvideos/transferform.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class stats extends StatefulWidget {
  const stats({super.key});

  @override
  State<stats> createState() => _statsState();
}

class _statsState extends State<stats> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 28, 32, 47),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
                child: InkWell(
                    child: FloatingActionButton.extended(
              onPressed: () => Get.to(() => (const transferform())),
              label: const Text("TRANSFER"),
              icon: const Icon(Icons.arrow_forward),
            )))
          ],
        ));
  }
}
