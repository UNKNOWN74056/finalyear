import 'package:chewie/chewie.dart';
import 'package:finalyear/GETX/getdatafromfirebase.dart';
import 'package:finalyear/GETX/offerrequest.dart';
import 'package:finalyear/model/offermodel.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:video_player/video_player.dart';

import '../../../../GETX/allvideos.dart';
import '../../../components/comment-widgets/commentsheetUserUI.dart';

class user_detail_page extends StatefulWidget {
  //object to the wigdet data
  final post;

  const user_detail_page({super.key, required this.post});

  @override
  State<user_detail_page> createState() => _coachdetailState();
}

class _coachdetailState extends State<user_detail_page> {
  //getx controller
  final vidcontroller = Get.put(FetchVideoFirebase());
  final List<VideoPlayerController> _controllers = [];
  final controller = Get.put(FetchDataFirebase());
  //cureent user
  final currentuser = FirebaseAuth.instance.currentUser!.email;
  //rating track
  bool hasRated = false;

//rating funtion
  Future addrating() async {
    double totalrating = 0;
    await FirebaseFirestore.instance
        .collection("users")
        .doc(widget.post.email)
        .collection("ratings")
        .doc(currentuser)
        .set({
      'email': widget.post.email,
      'rating': rating,
      "hasrated": true,
    }).then((_) => {
              setState(() {
                hasRated = true;
              })
            });

    var querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(widget.post.email)
        .collection("ratings")
        .where('email', isEqualTo: widget.post.email)
        .get();

    int numRatings = querySnapshot.docs.length;
    for (var doc in querySnapshot.docs) {
      totalrating += doc.data()['rating'] as double;
    }
    double ratingavg = totalrating / numRatings;
    print('Average rating: $ratingavg');
    await FirebaseFirestore.instance
        .collection("users")
        .doc(widget.post.email)
        .collection("ratings")
        .doc(currentuser)
        .update({
      'rating': ratingavg,
    });
    await FirebaseFirestore.instance
        .collection("users")
        .doc(widget.post.email)
        .update({
      'rating': ratingavg,
    });
    Get.snackbar("Message", "Thanks for rating.",
        colorText: Colors.white, backgroundColor: Colors.green);
  }

  void checkRatingStatus() {
    FirebaseFirestore.instance
        .collection('users')
        .doc(currentuser)
        .collection("ratings")
        .get()
        .then((QuerySnapshot<Map<String, dynamic>> docSnapshot) {
      setState(() {
        hasRated = docSnapshot.size >
            0; // Check if there are any documents in the snapshot
      });
    });
  }

  @override
  void initState() {
    super.initState();
    checkRatingStatus();
  }

  double rating = 0;
  final offercontroller = Get.put(offerrequestform());
//sending offer to buy the player function
  Future<void> sendoffer(BuildContext context) async {
    // Get the user document of the current user
    final userDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(currentuser.toString())
        .get();

    final name = userDoc.data()?['fullname'] as String?;
    final profession = userDoc.data()?['profession'] as String?;
    final sport = userDoc.data()?['sport'] as String?;

    final request = offerrequest(
        amount: offercontroller.amountcontroller.text,
        sentby: currentuser.toString(),
        email: widget.post.email,
        fullname: widget.post.fullname,
        image: widget.post.image_Url,
        name: name.toString(),
        profession: profession.toString(),
        sport: sport.toString());

    try {
      final collectionRef = FirebaseFirestore.instance.collection("offers");
      final documentRef = await collectionRef.add(request.toJson());

      // Assign the generated document ID to the request
      final generatedId = documentRef.id;
      await documentRef.update({'document': generatedId});
      Get.snackbar("Message", "Your offer has been sent.");
    } catch (error) {
      Get.snackbar("Error", "There was an error while sending the offer.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
            floatingActionButton: FloatingActionButton(
              backgroundColor: Colors.blueGrey,
              onPressed: () {
                showModalBottomSheet(
                    isScrollControlled: true,
                    shape: const RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(10))),
                    context: context,
                    builder: (context) {
                      return CommentListWidget(postEmail: widget.post.email);
                    });
              },
              child: const Icon(
                FontAwesomeIcons.commentDots,
              ),
            ),
            appBar: AppBar(
              title: const Text("Profile"),
              centerTitle: true,
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Offer Amount'),
                            content: Form(
                              key: offercontroller.offerkey,
                              child: TextFormField(
                                controller: offercontroller.amountcontroller,
                                keyboardType: TextInputType.number,
                                validator: (Value) {
                                  return offercontroller.validammount(Value!);
                                },
                                decoration: const InputDecoration(
                                    labelText: 'Enter Amount'),
                              ),
                            ),
                            actions: <Widget>[
                              ElevatedButton(
                                child: const Text('Cancel'),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                              ElevatedButton(
                                child: const Text('Send Offer'),
                                onPressed: () {
                                  offercontroller.checkoffer();
                                  if (offercontroller.isformValidated == true) {
                                    sendoffer(context);
                                    Navigator.of(context).pop();
                                  }
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: const Icon(FontAwesomeIcons.fileContract),
                  ),
                )
              ],
            ),
            body: SingleChildScrollView(
              child: Column(children: [
                Container(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      CircleAvatar(
                        radius: 60.0,
                        backgroundImage: NetworkImage(widget.post.image_Url),
                      ),
                      const SizedBox(height: 10.0),
                      Text(
                        widget.post.fullname,
                        style: const TextStyle(
                          fontSize: 22.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 5.0),
                      Text(
                        widget.post.sport,
                        style: const TextStyle(
                          fontSize: 16.0,
                          color: Colors.grey,
                        ),
                      ),
                      Column(
                        children: [
                          SizedBox(
                              width: 200,
                              height: 26,
                              child: GetBuilder(
                                  init: FetchDataFirebase(),
                                  builder: (controller) {
                                    return ListView(
                                      children: controller.mylist
                                          .where((e) =>
                                              e.email == widget.post.email)
                                          .map((element) => Center(
                                                  child: Text(
                                                element.rating.toString(),
                                                style: const TextStyle(
                                                    fontSize: 18),
                                              )))
                                          .toList(),
                                    );
                                  })),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  child: hasRated
                      ? Container()
                      : RatingBar.builder(
                          minRating: 0,
                          allowHalfRating: true,
                          itemBuilder: (context, _) => const Icon(Icons.star),
                          updateOnDrag: true,
                          onRatingUpdate: (rating) {
                            setState(() {
                              this.rating = rating;
                              addrating();
                            });
                          },
                        ),
                ),
                const SizedBox(height: 10.0),
                ListTile(
                  leading: const Icon(Icons.email),
                  title: Text(widget.post.email),
                ),
                const Divider(),
                ListTile(
                    leading: const Icon(Icons.phone),
                    title: Text(widget.post.phoneNumber)),
                const Divider(),
                ListTile(
                  leading: const Icon(Icons.location_on),
                  title: Text(widget.post.city),
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(FontAwesomeIcons.venusMars),
                  title: Text(widget.post.gender),
                ),
                const Divider(),
                ListTile(
                  leading: const Icon(FontAwesomeIcons.userTie),
                  title: Text(widget.post.profession),
                ),
                Container(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Videos',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: vidcontroller.videolist
                            .where((e) => e.email == widget.post.email)
                            .length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 8.0,
                          crossAxisSpacing: 8.0,
                        ),
                        itemBuilder: (BuildContext context, int index) {
                          final video = vidcontroller.videolist
                              .where((e) => e.email == widget.post.email)
                              .toList()[index];
                          final controller =
                              VideoPlayerController.network(video.videolink);
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
                                        additionalOptions: (context) {
                                          return <OptionItem>[
                                            OptionItem(
                                                onTap: () {},
                                                iconData:
                                                    FontAwesomeIcons.trash,
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
                                future: controller.initialize(),
                                builder: (BuildContext context,
                                    AsyncSnapshot snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.done) {
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
                      ),
                    ],
                  ),
                ),
              ]),
            )));
  }
}
