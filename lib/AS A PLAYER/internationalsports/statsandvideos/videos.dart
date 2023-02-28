import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finalyear/AS%20A%20PLAYER/internationalsports/statsandvideos/api.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:video_player/video_player.dart';
import 'package:file_picker/file_picker.dart';

class videos extends StatefulWidget {
  const videos({super.key});

  @override
  State<videos> createState() => _videosState();
}

UploadTask? task;
File? _video;
final picker = ImagePicker();

class _videosState extends State<videos> {
  final currentuser = FirebaseAuth.instance.currentUser!.email;
  //function to pick vedios form gallery
  Future pickvideo() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: true);
    if (result == null) return null;

    final path = result.files.single.path;

    setState(() => _video = File(path!));
    if (_video == null) return;
    final location = 'file/$currentuser';
    task = FirebaseApi.uploadfile(location, _video!);
    if (task == null) return;
    final snapshot = await task!.whenComplete(() {});
    final urldownload = await snapshot.ref.getDownloadURL();
    FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.email)
        .update({'vediourl': urldownload});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Videos"),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                  child: InkWell(
                      child: FloatingActionButton.extended(
                onPressed: () {
                  pickvideo();
                },
                label: const Text("ADD VIDEOS"),
                icon: const Icon(Icons.add),
              ))),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ));
  }
}
