import 'package:flutter/material.dart';

class registration extends StatefulWidget {
  const registration({super.key});

  @override
  State<registration> createState() => _registrationState();
}

class _registrationState extends State<registration> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Registration"),
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          Row(
            children: const [
              Padding(
                padding: EdgeInsets.only(top: 25, left: 20),
                child: Text(
                  "Registration Form",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ],
      )),
    ));
  }
}
