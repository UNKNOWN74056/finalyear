import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finalyear/AS%20A%20PLAYER/internationalsports/Details/coachdetail.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';

class Football extends StatefulWidget {
  const Football({super.key});

  @override
  State<Football> createState() => _FootballState();
}

navigatetodetail(DocumentSnapshot post) {
  Get.to(coachdetail(post: post));
}

class _FootballState extends State<Football> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: FirebaseFirestore.instance
              .collection("users")
              .where("sport", isEqualTo: "FootBall")
              .where("profession", isEqualTo: "Coache")
              .snapshots(),
          builder: ((BuildContext context,
              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
            return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot users = snapshot.data!.docs[index];
                  if (snapshot.hasData) {
                    return Column(
                      children: [
                        Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)),
                            child: ListTile(
                                title: Text(users["firstname"],
                                    style: const TextStyle(fontSize: 20)),
                                leading: CircleAvatar(
                                    radius: 35,
                                    backgroundImage:
                                        NetworkImage(users['Imageurl']),
                                    backgroundColor: Colors.green),
                                subtitle: Text(users["city"],
                                    style: const TextStyle(fontSize: 15)),
                                trailing: const Icon(Icons.arrow_forward),
                                onTap: () => navigatetodetail(users))),
                      ],
                    );
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                });
          })),
    );
  }
}
