import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:finalyear/AS%20A%20PLAYER/internationalsports/dashboard/profile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

class videos extends StatefulWidget {
  const videos({super.key});

  @override
  State<videos> createState() => _videosState();
}

UploadTask? task;
final picker = ImagePicker();

class _videosState extends State<videos> {
  final currentuser = FirebaseAuth.instance.currentUser!.email;
  //function to pick vedios form gallery
  // Future pickvideo() async {
  //   final result = await FilePicker.platform.pickFiles(allowMultiple: true);
  //   if (result == null) return null;

  //   final path = result.files.single.path;

  //   setState(() => _video = File(path!));
  //   if (_video == null) return;
  //   final location = 'file/$currentuser';
  //   task = FirebaseApi.uploadfile(location, _video!);
  //   if (task == null) return;
  //   final snapshot = await task!.whenComplete(() {});
  //   final urldownload = await snapshot.ref.getDownloadURL();
  //   FirebaseFirestore.instance
  //       .collection("users")
  //       .doc(FirebaseAuth.instance.currentUser!.email)
  //       .update({'vediourl': urldownload});
  // }
  File? _videoFile;
  Future<void> _pickVideo() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(type: FileType.video);
    if (result != null) {
      setState(() {
        _videoFile = File(result.files.single.path!);
      });
    }
  }

  Future<void> _uploadVideo() async {
    if (_videoFile == null) return;
    String fileName = _videoFile!.path.split('/').last;
    Reference reference = FirebaseStorage.instance.ref().child(fileName);
    UploadTask uploadTask = reference.putFile(_videoFile!);
    TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
    String downloadURL = await taskSnapshot.ref.getDownloadURL().toString();
    FirebaseFirestore.instance.collection("vedios").add({
      "download_link": downloadURL,
    });
    Get.to(const profile());
    print(downloadURL);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Videos"),
        centerTitle: true,
        actions: [
          GestureDetector(
            onTap: () {},
            child: const Icon(Icons.add),
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_videoFile != null) Text(_videoFile!.path),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _pickVideo,
              child: Text('Pick Video'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _uploadVideo,
              child: const Text('Upload Video'),
            ),
          ],
        ),
      ),
    );
  }
}
