import 'package:cloud_firestore/cloud_firestore.dart';

class offerrequest {
  String document;
  bool isApproved;
  String amount;
  String email;
  String sentby;
  String name;
  String profession;
  String sport;

  offerrequest({
    required this.document,
    this.isApproved = false,
    required this.amount,
    required this.email,
    required this.sentby,
    required this.name,
    required this.profession,
    required this.sport,
  });

  factory offerrequest.fromFirestore(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>;
    return offerrequest(
        document: data['document'], // Retrieve document ID
        isApproved: data['isApproved'],
        amount: data['amount'],
        email: data['email'],
        sentby: data['sentby'],
        name: data['coach'],
        profession: data['profession'],
        sport: data['sport']);
  }
}
