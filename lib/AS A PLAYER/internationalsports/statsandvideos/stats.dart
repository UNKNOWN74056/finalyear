import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class stats extends StatefulWidget {
  const stats({super.key});

  @override
  State<stats> createState() => _statsState();
}

class _statsState extends State<stats> {
  //final currentUser = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<DocumentSnapshot<Map>>(
      stream: FirebaseFirestore.instance
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .snapshots(),
      builder: (context, AsyncSnapshot<DocumentSnapshot<Map>> snapshot) {
        if (snapshot.hasData) {
          return Column(
            children: <Widget>[
              Text(
                  "Name: ${snapshot.data!.data()!.containsKey("firstname") ?
                   snapshot.data!.get("firstname") : "null"}"),
              // Text("Email: ${snapshot.data!['email']}"),
              // Text("Contect: ${snapshot.data!['phoneNumber']}"),
            ],
          );
        } else {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
      },
    ));
  }
}
