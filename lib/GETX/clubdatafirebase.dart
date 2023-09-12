import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../model/clubsModel.dart';

class Getclubdata extends GetxController {
  RxList clublist = <Clubs>[].obs;
  @override
  void onInit() {
    super.onInit();
    Getclubdatafirebase();
  }

  // Function to refresh clubdata
  Future<void> refresh_clubdata() async {
    await Getclubdatafirebase();
  }

  //get data for clubs from firebase
  Getclubdatafirebase() async {
    clublist.clear();
    await FirebaseFirestore.instance
        .collection("clubs")
        .get()
        .then((QuerySnapshot snapshot) {
      for (var c in snapshot.docs) {
        clublist.add(Clubs(
          clubimage: c['Clubimage'],
          clubname: c['Clubname'],
          email: c['Email'],
          location: c['Location'],
          phonenumber: c['Phone'],
          rating: c['rating'],
          sport: c['sport'],
        ));
      }
    });
  }
}
