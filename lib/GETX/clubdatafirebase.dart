import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../model/clubsModel.dart';

class Getclubdata extends GetxController {
  RxList clublist = <Clubs>[].obs;

  //get data for clubs from firebase
  Getclubdatafirebase() async {
    await FirebaseFirestore.instance
        .collection("clubs")
        .get()
        .then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((c) {
        clublist.add(Clubs(
          clubimage: c['Clubimage'],
          clubname: c['Clubname'],
          email: c['Email'],
          location: c['Location'],
          phonenumber: c['Phone'],
          rating: c['rating'],
          sport: c['sport'],
        ));
      });
    });
  }
}
