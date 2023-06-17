import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../model/tournamentmodel.dart';

class tournamentdata extends GetxController {
  RxList tournamentlist = <tournament>[].obs;
  @override
  void onInit() {
    super.onInit();
    Gettournamentdata();
  }

  // Function to refresh tournament
  Future<void> refresh_tournament() async {
    await Gettournamentdata();
  }

  Gettournamentdata() async {
    tournamentlist.clear();
    await FirebaseFirestore.instance
        .collection("tournaments")
        .get()
        .then((QuerySnapshot snapshot) {
      for (var f in snapshot.docs) {
        tournamentlist.add(tournament(
            tournamentimage: f['tournamentimage'],
            tournamentlocation: f['tournamentlocation'],
            tournamentname: f['tournamentname'],
            tournamentsport: f['tournamentsport'],
            startdate: f['startdate'],
            enddate: f['enddate'],
            price: f['price']));
      }
    });
  }
}
