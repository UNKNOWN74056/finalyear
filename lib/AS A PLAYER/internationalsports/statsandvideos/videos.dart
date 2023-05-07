import 'dart:io';
import 'package:chewie/chewie.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:finalyear/GETX/allvideos.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
  //getx controller
  final vidcontroller = Get.put(FetchVideoFirebase());
  final currentuser = FirebaseAuth.instance.currentUser!.email;
  File? _videoFile;
  UploadTask? task;
  final picker = ImagePicker();
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
    String fileName = _videoFile!.path.split('/videos').last;
    Reference reference = FirebaseStorage.instance.ref().child(fileName);
    UploadTask uploadTask = reference.putFile(_videoFile!);
    TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
    final downloadURL = await taskSnapshot.ref.getDownloadURL();

    //adding download link to firestore database
    FirebaseFirestore.instance.collection("videos").add({
      "videourl": downloadURL.toString(),
      "email": currentuser,
    });
    Get.snackbar("Message", "Your video has been uploaded");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        body: RefreshIndicator(
          onRefresh: () async {
            vidcontroller.Getallvideos();
          },
          child: GetBuilder(
            init: FetchVideoFirebase(),
            builder: (controller) {
              return Obx(
                () => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                    itemCount: controller.videolist
                        .where((e) => e.email == currentuser)
                        .length,
                    itemBuilder: (BuildContext context, int index) {
                      final video = controller.videolist
                          .where((e) =>
                              e.email ==
                              FirebaseAuth.instance.currentUser!.email)
                          .toList()[index];
                      final VideoPlayerController _controller =
                          VideoPlayerController.network(video.videolink);
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Scaffold(
                                body: Chewie(
                                  controller: ChewieController(
                                    videoPlayerController: _controller,
                                    autoPlay: true,
                                    looping: false,
                                    additionalOptions: (context) {
                                      return <OptionItem>[
                                        OptionItem(
                                            onTap: () {},
                                            iconData: FontAwesomeIcons.trash,
                                            title: "Delete")
                                      ];
                                    },
                                    errorBuilder: (context, errorMessage) {
                                      return Center(
                                        child: Text(
                                          errorMessage,
                                          style: const TextStyle(
                                              color: Colors.white),
                                        ),
                                      );
                                    },
                                    placeholder: Container(
                                      color: Colors.grey[200],
                                    ),
                                    materialProgressColors:
                                        ChewieProgressColors(
                                      playedColor: Colors.red,
                                      handleColor: Colors.red,
                                      backgroundColor: const Color.fromARGB(
                                          78, 158, 158, 158),
                                      bufferedColor: Colors.grey,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            color: Colors.white70,
                            borderRadius: BorderRadius.circular(8.0),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 1,
                                blurRadius: 5,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: FutureBuilder(
                            future: _controller.initialize(),
                            builder:
                                (BuildContext context, AsyncSnapshot snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.done) {
                                return AspectRatio(
                                  aspectRatio: 16 / 9,
                                  child: VideoPlayer(_controller),
                                );
                              } else {
                                return Container(
                                  height: 200.0,
                                  color: Colors.grey[200],
                                );
                              }
                            },
                          ),
                        ),
                      );
                    },
                  ),
                ),
              );
            },
          ),
        ));
  }
}
