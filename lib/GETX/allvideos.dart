import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finalyear/model/videomodel.dart';
import 'package:get/get.dart';

class FetchVideoFirebase extends GetxController {
  RxList videolist = <video>[].obs;

  // get all the data of users from firebase
  Getallvideos() async {
    await FirebaseFirestore.instance
        .collection("videos")
        .get()
        .then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((f) {
        videolist.add(video(videolink: f['videourl']));
      });
    });
    print(videolist[0].videolink.toString());
  }
}
