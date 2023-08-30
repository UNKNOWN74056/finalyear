import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../model/tournamentmodel.dart';
import 'package:intl/intl.dart';

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
            startdate: f['startdate'] != null
                ? DateFormat('MMMM d, y, hh:mm a')
                    .format(f['startdate'].toDate())
                : null,
            enddate: f['enddate'] != null
                ? DateFormat('MMMM d, y, hh:mm a').format(f['enddate'].toDate())
                : null,
            price: f['price'],
            email: f['email']));
      }
    });
  }
}
