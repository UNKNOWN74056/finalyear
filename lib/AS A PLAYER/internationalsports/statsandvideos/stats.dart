import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';

class stats extends StatefulWidget {
  const stats({super.key});
  @override
  State<stats> createState() => _statsState();
}

class _statsState extends State<stats> {

  
  //final current = FirebaseAuth.instance.currentUser!.uid;
  final user = FirebaseFirestore.instance.collection("users").doc(FirebaseAuth.instance.currentUser!.uid).snapshots();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
          //stream: ,
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                shrinkWrap: true,
                itemBuilder: (context, i) {
                  var data = snapshot.data!.docs[i];
                  return Text(data['firstname'] + " " + data['lastname']);
                },
              );
            } else {
              return const Padding(
                  padding: EdgeInsets.all(30.0), child: Text("loading ...."));
            }
          }),
    );
  }
}
