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

  // Function to refresh videolist
  Future<void> refresh_videos() async {
    await Gettournamentdata();
  }

  Gettournamentdata() async {
    tournamentlist.clear();
    await FirebaseFirestore.instance
        .collection("tournaments")
        .get()
        .then((QuerySnapshot snapshot) {
      for (var c in snapshot.docs) {
        tournamentlist.add(tournament(
            tournamentimage: c['tournamentimage'],
            tournamentlocation: c['tournamentlocation'],
            tournamentsport: c['tournamentsport'],
            tournamentname: c['tournamentname'],
            enddate: c['enddate'],
            startdate: c['startdate'],
            price: c['price']));
      }
    });
  }
}
