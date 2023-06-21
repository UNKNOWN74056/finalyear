import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../model/tournamentregistrationrequest.dart';

class AdminApprovalScreen extends StatelessWidget {
  final currentuser = FirebaseAuth.instance.currentUser!.email;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Approval'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('registrationRequests')
            .where("email", isEqualTo: currentuser)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final requests = snapshot.data!.docs
                .map((doc) => TournamentRegistrationRequest.fromFirestore(doc))
                .toList();

            return ListView.builder(
              itemCount: requests.length,
              itemBuilder: (context, index) {
                final request = requests[index];
                final bool isApproved = request.isApproved;

                return Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListTile(
                    title: Text(
                      'Team Name: ${request.teamName}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Sport: ${request.sportevent}',
                          style: const TextStyle(fontSize: 14),
                        ),
                        Text(
                          'Captain Name: ${request.captainName}',
                          style: const TextStyle(fontSize: 14),
                        ),
                        Text(
                          'Location:${request.city} ',
                          style: const TextStyle(fontSize: 14),
                        ),
                        Text(
                          'Phone:${request.contact} ',
                          style: const TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                    trailing: isApproved
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
                            ),
                          )
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
                            child: const Icon(
                              Icons.clear,
                              color: Colors.red,
                            ),
                          ),
                  ),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            return const Center(child: Text("Loading..."));
          }
        },
      ),
    );
  }
}
