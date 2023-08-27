import 'package:chewie/chewie.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import "package:flutter/material.dart";
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import '../../../GETX/allvideos.dart';

class videopagegridview extends StatelessWidget {
  //getx controller
  final vidcontroller = Get.put(FetchVideoFirebase());
  final List<VideoPlayerController> _controllers = [];
  final currentuser = FirebaseAuth.instance.currentUser!.email;
  videopagegridview({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount:
          vidcontroller.videolist.where((e) => e.email == currentuser).length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: 8.0,
        crossAxisSpacing: 8.0,
      ),
      itemBuilder: (BuildContext context, int index) {
        final video = vidcontroller.videolist
            .where((e) => e.email == FirebaseAuth.instance.currentUser!.email)
            .toList()[index];
        final controller = VideoPlayerController.network(video.videolink);
        _controllers.add(controller);

        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Scaffold(
                  body: Chewie(
                    controller: ChewieController(
                      videoPlayerController: controller,
                      autoPlay: true,
                      looping: false,
                      errorBuilder: (context, errorMessage) {
                        return Center(
                          child: Text(
                            errorMessage,
                            style: const TextStyle(color: Colors.white),
                          ),
                        );
                      },
                      placeholder: Container(
                        color: Colors.grey[200],
                      ),
                      materialProgressColors: ChewieProgressColors(
                        playedColor: Colors.red,
                        handleColor: Colors.red,
                        backgroundColor:
                            const Color.fromARGB(78, 158, 158, 158),
                        bufferedColor: Colors.grey,
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
          onLongPress: () {
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Delete Video'),
                content:
                    const Text('Are you sure you want to delete this video?'),
                actions: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () async {
                      // Get the video by its ID
                      final videoToDelete = vidcontroller.videolist.firstWhere(
                        (e) => e.id == video.id, // Compare the document ID
                        orElse: () => null,
                      );
                      if (videoToDelete != null) {
                        // Delete the video using the document ID
                        await FirebaseFirestore.instance
                            .collection("videos")
                            .doc(videoToDelete.id)
                            .delete();
                        // Also stop and dispose of the video player
                        controller.pause();
                        controller.dispose();
                        _controllers.remove(controller);
                      }
                      Navigator.pop(context);
                    },
                    child: const Text('Delete'),
                  ),
                ],
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
              future: controller.initialize(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return AspectRatio(
                    aspectRatio: 16 / 9,
                    child: VideoPlayer(controller),
                  );
                } else if (snapshot.hasError) {
                  return const Text('Error loading video');
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
    );
  }
}
