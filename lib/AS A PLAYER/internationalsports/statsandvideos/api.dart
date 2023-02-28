import 'package:flutter/material.dart';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseApi {
  static UploadTask? uploadfile(String location, File filename) {
    try {
      final ref = FirebaseStorage.instance.ref(location);
      return ref.putFile(filename);
    } on FirebaseException catch (e) {
      return null;
    }
  }
}
