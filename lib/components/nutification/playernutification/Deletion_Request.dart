import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finalyear/views/AS%20A%20PLAYER/internationalsports/tournamentsregistration/registration.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class Deletion_Request extends StatefulWidget {
  const Deletion_Request({Key? key}) : super(key: key);

  @override
  _Deletion_RequestState createState() => _Deletion_RequestState();
}

class _Deletion_RequestState extends State<Deletion_Request> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<QuerySnapshot>(
        stream: _fetchDeletionRequestsStream(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final documents = snapshot.data!.docs;
            if (documents.isEmpty) {
              return const Center(child: Text('No deletion requests found.'));
            }
            return ListView.builder(
              itemCount: documents.length,
              itemBuilder: (context, index) {
                final request = documents[index];
                return Slidable(
                  endActionPane:
                      ActionPane(motion: const ScrollMotion(), children: [
                    SlidableAction(
                      onPressed: (context) {
                        showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text("Request deletion"),
                                content: const Text(
                                    "Are you sure you want to delete the request?"),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text("Cancel"),
                                  ),
                                  TextButton(
                                    onPressed: () async {
                                      await FirebaseFirestore.instance
                                          .collection('deletionRequests')
                                          .doc(
                                              currentuser) // Use the unique identifier (document ID)
                                          .delete();

                                      Get.snackbar(
                                        "Message",
                                        "The request is deleted",
                                        backgroundColor: Colors.red,
                                        colorText: Colors.white,
                                      );
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text("Yes"),
                                  ),
                                ],
                              );
                            });
                      },
                      backgroundColor: const Color.fromARGB(255, 241, 39, 12),
                      foregroundColor: Colors.white,
                      icon: FontAwesomeIcons.trash,
                    )
                  ]),
                  child: Card(
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(request['image']),
                      ),
                      title: Text(request['fullname']),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(request['sport']),
                          Text(request['profession']),
                        ],
                      ),
                      // Add more widgets as needed to display the data
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }

  Stream<QuerySnapshot> _fetchDeletionRequestsStream() {
    final user = _auth.currentUser;
    if (user != null) {
      return _firestore
          .collection('deletionRequests')
          .where('requesterby', isEqualTo: user.email)
          .snapshots();
    }
    // Return an empty stream if the user is not authenticated.
    return const Stream<QuerySnapshot>.empty();
  }
}

void main() {
  runApp(const MaterialApp(
    home: Deletion_Request(),
  ));
}
