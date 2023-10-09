import 'package:cloud_firestore/cloud_firestore.dart';

class DeletionRequest {
  final String fullname;
  final String image;
  final String requesterby;
  final String profession;
  final String sport;
  final Timestamp timestamp;

  DeletionRequest(this.fullname, this.image, this.requesterby, this.profession,
      this.sport, this.timestamp);
}
