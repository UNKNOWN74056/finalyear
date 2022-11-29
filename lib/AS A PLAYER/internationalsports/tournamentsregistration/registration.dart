import 'dart:ffi';

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
          const Padding(
            padding: EdgeInsets.only(
              top: 25,
            ),
            child: Text(
              "Registration Form",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          const Text(
            "Team Name:",
            style: TextStyle(fontSize: 20),
          ),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            decoration: InputDecoration(
                label: const Text("Enter Team Name"),
                hintText: "Enter Team Name",
                prefixIcon: const Icon(Icons.person),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                )),
          ),
          const SizedBox(
            height: 10,
          ),
          const Text("Captain Name:", style: TextStyle(fontSize: 20)),
          const SizedBox(
            height: 10,
          ),
          TextFormField(
            decoration: InputDecoration(
                label: const Text("Enter Captain Name"),
                hintText: "Enter Captain Name",
                prefixIcon: const Icon(Icons.person),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                )),
          ),
        ],
      )),
    ));
  }
}
