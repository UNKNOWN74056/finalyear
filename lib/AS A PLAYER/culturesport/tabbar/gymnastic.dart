import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finalyear/AS%20A%20PLAYER/internationalsports/Details/coachdetail.dart';
import 'package:finalyear/AS%20A%20PLAYER/internationalsports/tabbar/Football.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class gymnastic extends StatefulWidget {
  const gymnastic({super.key});

  @override
  State<gymnastic> createState() => _gymnasticState();
}

class _gymnasticState extends State<gymnastic> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:  StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("users")
                .where("sport", isEqualTo: "Gymnastic")
                .where("profession", isEqualTo: "Coache")
                .snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    shrinkWrap: true,
                    itemBuilder: (context, i) {
                      var data = snapshot.data!.docs[i];
                      return Container(
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            Card(
                              color: Colors.grey.shade300,
                              shape: RoundedRectangleBorder(
                                side: const BorderSide(
                                    color: Color.fromARGB(255, 25, 9, 117),
                                    width: 1),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: ListTile(
                                  title: Text(data['firstname'],
                                      style: const TextStyle(fontSize: 20)),
                                  leading: CircleAvatar(
                                      radius: 35,
                                      backgroundImage:
                                          NetworkImage(data['Imageurl']),
                                      backgroundColor: Colors.white),
                                  trailing: const Icon(
                                    Icons.arrow_forward,
                                  ),
                                  onTap: () => navigatetodetail(data),
                                  subtitle: Text(data["city"],
                                      style: const TextStyle(fontSize: 15))),
                            )
                          ],
                        ),
                      );
                    });
              }
              return const Center(child: CircularProgressIndicator());
            }));
  }
}
