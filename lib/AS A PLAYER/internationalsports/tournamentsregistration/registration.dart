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
      backgroundColor: Color.fromARGB(255, 28, 32, 47),
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "REGISTRATION",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
          child: Container(
        margin: EdgeInsets.all(10.0),
        child: Form(
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.only(
                  top: 25,
                ),
                child: Text(
                  "Registration Form",
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Team Name:",
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                decoration: InputDecoration(
                    label: const Text(
                      "Enter Team Name",
                      style: TextStyle(color: Colors.white),
                    ),
                    prefixIcon: const Icon(Icons.person),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    )),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text("Captain Name:",
                  style: TextStyle(fontSize: 20, color: Colors.white)),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                decoration: InputDecoration(
                    label: const Text(
                      "Enter Captain Name",
                      style: TextStyle(color: Colors.white),
                    ),
                    prefixIcon: const Icon(Icons.person),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    )),
              ),
            ],
          ),
        ),
      )),
    ));
  }
}
