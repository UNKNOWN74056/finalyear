import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finalyear/model/usersModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class FetchDataFirebase extends GetxController {
  RxList mylist = <Users>[].obs;

  GetDataFirebase() async {
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
