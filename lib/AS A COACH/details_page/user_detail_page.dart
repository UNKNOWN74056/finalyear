import 'package:chewie/chewie.dart';
import 'package:finalyear/GETX/getdatafromfirebase.dart';
import 'package:finalyear/GETX/offerrequest.dart';
import 'package:finalyear/model/offermodel.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_time_ago/get_time_ago.dart';
import 'package:video_player/video_player.dart';

import '../../../GETX/allvideos.dart';

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
  //controller
  final TextEditingController _commentcontroler = TextEditingController();
  //cureent user
  final currentuser = FirebaseAuth.instance.currentUser!.email;
  //rating track
  bool hasRated = false;
  //add comment in firestore
  Future addcommnet(String name, String image, String comment) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(widget.post.email)
        .collection("comments")
        .doc(comment)
        .set({
      'image': image,
      'commented_on': widget.post.email,
      'name': name,
      'time': DateTime.now(),
      'commenter': currentuser.toString(),
      'comment': _commentcontroler.text.toString(),
    }).whenComplete(() {
      _commentcontroler.clear();
    });
  }

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

  //dispose
  @override
  void dispose() {
    _commentcontroler.dispose();
    super.dispose();
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
    final request = offerrequest(
      amount: offercontroller.amountcontroller.text,
      sentby: currentuser.toString(),
      email: widget.post.email,
    );

    try {
      final collectionRef = FirebaseFirestore.instance.collection("offers");
      final documentRef = await collectionRef.add(request.toJson());

      // Assign the generated document ID to the request
      final generatedId = documentRef.id;
      await documentRef.update({'document': generatedId});
      Get.snackbar("Meassage", "Your offer has been sended.");
    } catch (error) {
      Get.snackbar("Error", "There was an error while sending offer.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                showModalBottomSheet(
                    isScrollControlled: true,
                    shape: const RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(10))),
                    context: context,
                    builder: (context) {
                      return Column(
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(top: 40),
                            child: Text(
                              "Comments",
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                          StreamBuilder(
                            stream: FirebaseFirestore.instance
                                .collection("users")
                                .doc(widget.post.email)
                                .collection("comments")
                                .snapshots(),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return Expanded(
                                  child: ListView.builder(
                                      itemCount: snapshot.data!.docs.length,
                                      shrinkWrap: true,
                                      itemBuilder: (context, i) {
                                        var data = snapshot.data!.docs[i];
                                        Timestamp date =
                                            snapshot.data!.docs[i]['time'];
                                        var finaldate = DateTime.parse(
                                            date.toDate().toString());

                                        return SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.25,
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 10),
                                                  child: Row(
                                                    children: [
                                                      CircleAvatar(
                                                        backgroundImage:
                                                            NetworkImage(
                                                                data['image']),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 8.0),
                                                        child: Container(
                                                          child: Row(children: [
                                                            Text(
                                                              data['name'],
                                                              style: const TextStyle(
                                                                  fontSize: 15,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                            ),
                                                          ]),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                const SizedBox(
                                                  height: 10,
                                                ),
                                                SizedBox(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      1,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 15),
                                                    child: Row(children: [
                                                      const Icon(
                                                        Icons
                                                            .arrow_forward_ios_outlined,
                                                        size: 15,
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(left: 10),
                                                        child: SizedBox(
                                                          width: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.75,
                                                          child: Text(
                                                              data['comment']),
                                                        ),
                                                      ),
                                                      GestureDetector(
                                                        onTap: () {
                                                          if (data[
                                                                  'commenter'] ==
                                                              currentuser) {
                                                            data.reference
                                                                .delete();
                                                          } else {
                                                            null;
                                                          }
                                                        },
                                                        child: const Icon(
                                                          FontAwesomeIcons
                                                              .trash,
                                                          color: Colors.red,
                                                        ),
                                                      ),
                                                    ]),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 20),
                                                  child: Row(
                                                    children: [
                                                      Text(GetTimeAgo.parse(
                                                          finaldate))
                                                    ],
                                                  ),
                                                ),
                                                const Divider(
                                                  color: Colors.black,
                                                )
                                              ]),
                                        );
                                      }),
                                );
                              }
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            },
                          ),
                          StreamBuilder(
                              stream: FirebaseFirestore.instance
                                  .collection("users")
                                  .where("email", isEqualTo: currentuser)
                                  .snapshots(),
                              builder: (context,
                                  AsyncSnapshot<QuerySnapshot> snapshot) {
                                if (snapshot.hasData) {
                                  return ListView.builder(
                                      itemCount: snapshot.data!.docs.length,
                                      shrinkWrap: true,
                                      itemBuilder: (context, i) {
                                        var data = snapshot.data!.docs[i];
                                        final namecontroller = data['fullname'];
                                        final image = data['Imageurl'];
                                        return Padding(
                                          padding: EdgeInsets.only(
                                              bottom: MediaQuery.of(context)
                                                  .viewInsets
                                                  .bottom),
                                          child: Padding(
                                            padding: const EdgeInsets.all(15),
                                            child: TextFormField(
                                              cursorColor: Colors.black,
                                              cursorWidth: 5,
                                              cursorHeight: 20,
                                              controller: _commentcontroler,
                                              textAlignVertical:
                                                  TextAlignVertical.center,
                                              keyboardType:
                                                  TextInputType.multiline,
                                              maxLines: 3,
                                              minLines: 2,
                                              decoration: InputDecoration(
                                                filled: true,
                                                isDense: true,
                                                contentPadding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 10),
                                                fillColor: Colors.white70,
                                                border: OutlineInputBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10)),
                                                hintText:
                                                    "Write your comment....",
                                                suffixIcon: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: [
                                                    GestureDetector(
                                                      onTap: (() {
                                                        addcommnet(
                                                            namecontroller
                                                                .toString(),
                                                            image.toString(),
                                                            _commentcontroler
                                                                .text
                                                                .toString());
                                                      }),
                                                      child: const Icon(
                                                          FontAwesomeIcons
                                                              .solidPaperPlane,
                                                          size: 20,
                                                          color: Color.fromARGB(
                                                              255, 0, 1, 5)),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      });
                                }
                                return const Center(child: Text("Loading..."));
                              }),
                        ],
                      );
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
                          onRatingUpdate: (rating) => setState(() {
                            this.rating = rating;
                            addrating();
                          }),
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
