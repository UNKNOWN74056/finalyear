import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finalyear/model/usersModel.dart';
import 'package:get/get.dart';

class FetchDataFirebase extends GetxController {
  RxList mylist = <Users>[].obs;

  @override
  void onInit() {
    super.onInit();
    GetDataFirebase();
  }

  // Function to refresh user data
  Future<void> refresh_userdata() async {
    await GetDataFirebase();
  }

  // get all the data of users from firebase
  GetDataFirebase() async {
    // Assuming you have a Users model with the "club" property.

    mylist.clear();
    await FirebaseFirestore.instance
        .collection("users")
        .get()
        .then((QuerySnapshot snapshot) {
      for (var f in snapshot.docs) {
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
          club: f['club'] ?? " ",
          varificaiton: f['varification'],
        ));
      }
    });
  }
}
