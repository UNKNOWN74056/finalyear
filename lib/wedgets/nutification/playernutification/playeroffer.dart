import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../model/offerrequest.dart';
import 'package:flutter/material.dart';

class playeroffer extends StatefulWidget {
  const playeroffer({super.key});

  @override
  State<playeroffer> createState() => _offersState();
}

class _offersState extends State<playeroffer> {
  final currentuser = FirebaseAuth.instance.currentUser!.email;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('offers')
          .where("email", isEqualTo: currentuser)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final requests = snapshot.data!.docs
              .map((doc) => offerrequest.fromFirestore(doc))
              .toList();

          return ListView.builder(
            itemCount: requests.length,
            itemBuilder: (context, index) {
              final request = requests[index];
              return Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListTile(
                      title: Text(
                        'Sent by: ${request.sentby}',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Offer Amount: ${request.amount}',
                            style: const TextStyle(fontSize: 14),
                          ),
                        ],
                      ),
                      trailing: request.isApproved
                          ? Container(
                              width: 36,
                              height: 36,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.green,
                              ),
                              child: const Icon(
                                Icons.check,
                                color: Colors.white,
                              ))
                          : Container(
                              width: 36,
                              height: 36,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.red,
                                  width: 2,
                                ),
                              ),
                              child: IconButton(
                                icon: const Icon(
                                  Icons.clear,
                                  color: Colors.red,
                                ),
                                onPressed: () {
                                  _updateApprovalStatus(request);
                                },
                              ))));
            },
          );
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return const Center(child: Text("Loading..."));
        }
      },
    );
  }

  void _updateApprovalStatus(offerrequest request) {
    final documentRef =
        FirebaseFirestore.instance.collection('offers').doc(request.document);

    documentRef.update({'isApproved': true}).then((_) {
      // Approval status updated successfully
    }).catchError((error) {
      // Error updating approval status
    });
  }
}
