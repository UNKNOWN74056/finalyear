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
        title: const Text(
          "REGISTRATION",
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
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Team Name:",
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                decoration: InputDecoration(
                    label: const Text(
                      "Enter Team Name",
                    ),
                    prefixIcon: const Icon(Icons.group),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    )),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Captain Name:",
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                decoration: InputDecoration(
                    label: const Text(
                      "Enter Captain Name",
                    ),
                    prefixIcon: const Icon(Icons.person),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    )),
              ),
              const Text(
                "Address",
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                decoration: InputDecoration(
                    label: const Text(
                      "Enter your address here",
                    ),
                    prefixIcon: const Icon(Icons.location_on),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    )),
              ),
              const Text(
                "City",
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                decoration: InputDecoration(
                    label: const Text(
                      "Enter your city here",
                    ),
                    prefixIcon: const Icon(Icons.location_city),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    )),
              ),
              const Text("Contact Email",
                  style: TextStyle(
                    fontSize: 20,
                  )),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                decoration: InputDecoration(
                    label: const Text(
                      "Enter your email",
                    ),
                    prefixIcon: const Icon(Icons.mail),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    )),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                      onPressed: () {}, child: const Text("submitt")))
            ],
          ),
        ),
      )),
    ));
  }
}
