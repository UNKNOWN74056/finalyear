import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:finalyear/AS%20A%20PLAYER/internationalsports/dashboard/profile.dart';
import 'package:finalyear/GETX/allvideos.dart';
import 'package:finalyear/functions/functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';

class videos extends StatefulWidget {
  const videos({
    super.key,
  });

  @override
  State<videos> createState() => _videosState();
}

class _videosState extends State<videos> {
  final controller = Get.put(FetchVideoFirebase());
  final currentuser = FirebaseAuth.instance.currentUser!.email;
  File? _videoFile;
  UploadTask? task;
  late VideoPlayerController _controller;

  final picker = ImagePicker();
  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  //picked upload function
  Future<void> _pickVideo() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(type: FileType.video);
    if (result != null) {
      setState(() {
        _videoFile = File(result.files.single.path!);
      });
    }
    if (_videoFile == null) return;
    String fileName = _videoFile!.path.split('/').last;
    Reference reference = FirebaseStorage.instance.ref().child(fileName);
    UploadTask uploadTask = reference.putFile(_videoFile!);
    TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
    final downloadURL = await taskSnapshot.ref.getDownloadURL();

    //adding download link to firestore database
    FirebaseFirestore.instance.collection("videos").add({
      "videourl": downloadURL,
    });
    Get.to(const profile());
  }

  @override
  void initState() {
    super.initState();

    _controller = VideoPlayerController.network("")
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          setState(() {
            _controller.value.isPlaying
                ? _controller.pause()
                : _controller.play();
          });
        },
        child: Icon(
          _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
        ),
      ),
      appBar: AppBar(
        title: const Text("Videos"),
        centerTitle: true,
        actions: [
          GestureDetector(
            onTap: () {
              _pickVideo();
            },
            child: const Icon(Icons.add),
          )
        ],
      ),
      body:
          //  _controller.value.isInitialized
          //     ? AspectRatio(
          //         aspectRatio: 16 / 9,
          //         child: VideoPlayer(_controller),
          //       )
          //     : Container(),

          //   Column(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: [
          //       if (_videoFile != null) Text(_videoFile!.path),
          //     ],
          //   ),
          // ),
          StreamBuilder(
              stream:
                  FirebaseFirestore.instance.collection("videos").snapshots(),
              builder: ((context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, i) {
                        var data = snapshot.data!.docs[i];
                        return _controller.value.isInitialized
                            ? AspectRatio(
                                aspectRatio: 16 / 9,
                                child: VideoPlayer(_controller),
                              )
                            : Container();
                      });
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              })),
    );
  }
}
