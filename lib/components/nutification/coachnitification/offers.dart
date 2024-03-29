import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import '../../../model/offerrequest.dart';
import 'package:flutter/material.dart';

class offers extends StatefulWidget {
  const offers({super.key});

  @override
  State<offers> createState() => _offersState();
}

class _offersState extends State<offers> {
  final currentuser = FirebaseAuth.instance.currentUser!.email;
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('offers')
          .where('sentby', isEqualTo: currentuser)
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
              return Slidable(
                endActionPane:
                    ActionPane(motion: const ScrollMotion(), children: [
                  SlidableAction(
                    onPressed: (context) async {
                      await FirebaseFirestore.instance
                          .collection('offers')
                          .doc(request.document) // Use the document ID here
                          .delete()
                          .then((_) {
                        Get.snackbar("Message",
                            "Your offer has been canceled succefully.");
                      }).catchError((error) {
                        Get.snackbar(
                            " Error", "Error accure while canceling offer.");
                      });
                    },
                    backgroundColor: const Color.fromARGB(255, 236, 75, 26),
                    foregroundColor: Colors.white,
                    icon: FontAwesomeIcons.trash,
                    label: 'Cancel',
                  )
                ]),
                child: Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListTile(
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    title: Text(
                      'Coach: ${request.name}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 4),
                        Text(
                          'Sent to: ${request.email}',
                          style: const TextStyle(fontSize: 14),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Offer Amount: ${request.amount}',
                          style: const TextStyle(fontSize: 14),
                        ),
                        const SizedBox(height: 4),
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
                            ),
                          )
                        : Container(
                            width: 36,
                            height: 36,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.red,
                            ),
                            child: const Icon(
                              Icons.clear,
                              color: Colors.white,
                            ),
                          ),
                  ),
                ),
              );
            },
          );
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return const Center(
            child: SpinKitFadingCircle(
              color: Colors.green, // Set the color of the SpinKit indicator
              size: 50.0, // Set the size of the indicator as needed
            ),
          );
        }
      },
    );
  }
}
