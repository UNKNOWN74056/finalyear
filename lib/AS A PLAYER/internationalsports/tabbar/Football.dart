import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finalyear/AS%20A%20PLAYER/internationalsports/Details/coachdetail.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Football extends StatefulWidget {
  const Football({super.key});

  @override
  State<Football> createState() => _FootballState();
}

class _FootballState extends State<Football> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection("users")
                .where("sport", isEqualTo: "FootBall")
                .snapshots(),
            builder: ((context, snapshot) {
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
                                  leading: const CircleAvatar(
                                      radius: 35,
                                      backgroundImage:
                                          AssetImage("assets/mech.jpg"),
                                      backgroundColor: Colors.green),
                                  subtitle: Text(users["city"],
                                      style: const TextStyle(fontSize: 15)),
                                  trailing: const Icon(Icons.arrow_forward),
                                  onTap: () {
                                    Get.to(const coachdetail());
                                  })),
                        ],
                      );
                    } else if (snapshot.hasError) {
                      return const Text("Somthing is went wrong");
                    } else {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                  });
            })));
  }
}

// body: Column(children: [

//   const SizedBox(height: 20),
//   Expanded(
//       child: ListView.builder(
//           itemCount: coachdata.length,
//           itemBuilder: (BuildContext context, index) {
//             return Container(
//               height: 80,
//               child: Card(

//                 shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(30)),
//                 child: ListTile(
//                   title: Text(
//                     coachdata[index].name,
//                     style: const TextStyle(fontSize: 20),
//                   ),
//                   leading: const CircleAvatar(
//                       radius: 35,
//                       backgroundImage: AssetImage("assets/mech.jpg"),
//                       backgroundColor: Colors.green),
//                   subtitle: Text(coachdata[index].discription,
//                       style: const TextStyle(fontSize: 15)),
//                   trailing: const Icon(Icons.arrow_forward),
//                   onTap: () {
//                     navigator?.push(MaterialPageRoute(
//                         builder: ((context) => const coachdetail())));
//                   },
//                 ),
//               ),
//             );
//           })),
// ]),
