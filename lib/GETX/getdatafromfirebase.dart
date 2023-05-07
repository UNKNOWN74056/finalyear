import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finalyear/model/usersModel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class FetchDataFirebase extends GetxController {
  RxList mylist = <Users>[].obs;

  get videolist => null;
  @override
  void onInit() {
    super.onInit();
    // Call Getallvideos() function when the controller is initialized
    GetDataFirebase();
  }

  // Function to refresh videolist
  Future<void> refresh_videos() async {
    await GetDataFirebase();
  }

  // get all the data of users from firebase
  GetDataFirebase() async {
    mylist.clear();
    await FirebaseFirestore.instance
        .collection("users")
        .get()
        .then((QuerySnapshot snapshot) {
      snapshot.docs.forEach((f) {
        mylist.add(Users(
          image_Url: f['Imageurl'],
          city: f['city'],
          email: f['email'],
          fullname: f['fullname'],
          gender: f['gender'],
          password: f['password'],
          phoneNumber: f['phoneNumber'],
          profession: f['profession'],
          rating: f['rating'],
          sport: f['sport'],
        ));
      });
    });
  }
}
