import 'package:chewie/chewie.dart';
import 'package:finalyear/GETX/getdatafromfirebase.dart';
import 'package:finalyear/wedgets/comment-widgets/comenttextfield.dart';
import 'package:finalyear/wedgets/comment-widgets/customesendbutton.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get_time_ago/get_time_ago.dart';
import 'package:video_player/video_player.dart';

import '../../../GETX/allvideos.dart';

class coachdetail extends StatefulWidget {
  //object to the wigdet data
  final post;

  const coachdetail({super.key, required this.post});

  @override
  State<coachdetail> createState() => _coachdetailState();
}

class _coachdetailState extends State<coachdetail> {
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
  Future addcomment(String name, String image, String comment) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(widget.post.email)
        .collection("comments")
        .add({
      'image': image,
      'commented_on': widget.post.email,
      'name': name,
      'time': DateTime.now(),
      'commenter': currentuser.toString(),
      'comment': comment, // Use the passed comment argument directly
    }).then((newCommentDoc) {
      print("Comment added with ID: ${newCommentDoc.id}");
      _commentcontroler.clear();
    }).catchError((error) {
      print("Error adding comment: $error");
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
                          //comeent to show stream builder
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
                                          width:
                                              MediaQuery.of(context).size.width,
                                          child: Column(
                                            children: [
                                              Slidable(
                                                endActionPane: ActionPane(
                                                    motion:
                                                        const ScrollMotion(),
                                                    children: [
                                                      SlidableAction(
                                                        onPressed: (context) {
                                                          if (data[
                                                                  'commenter'] ==
                                                              currentuser) {
                                                            data.reference
                                                                .delete();
                                                          } else {
                                                            null;
                                                          }
                                                        },
                                                        backgroundColor:
                                                            const Color
                                                                    .fromARGB(
                                                                255, 252, 6, 6),
                                                        foregroundColor:
                                                            Colors.white,
                                                        icon: FontAwesomeIcons
                                                            .trash,
                                                        label: 'Delete',
                                                      )
                                                    ]),
                                                child: ListTile(
                                                  leading: CircleAvatar(
                                                    backgroundImage:
                                                        NetworkImage(
                                                            data['image']),
                                                    radius: 20,
                                                  ),
                                                  title: Row(
                                                    children: [
                                                      Text(
                                                        data['name'],
                                                        style: const TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold,
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                          width:
                                                              10), // Add some space between name and timestamp
                                                      Text(
                                                        GetTimeAgo.parse(
                                                            finaldate),
                                                        style: const TextStyle(
                                                          color: Colors.grey,
                                                          fontSize:
                                                              12, // Adjust the font size as needed
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  subtitle: Text(
                                                    data['comment'],
                                                    style: const TextStyle(),
                                                  ),
                                                ),
                                              ),
                                              Divider(
                                                color: Colors.grey.shade300,
                                                thickness: 0.8,
                                                height: 0,
                                              ),
                                            ],
                                          ),
                                        );
                                      }),
                                );
                              }
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            },
                          ),
                          //comment textfield
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
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                      child: commenttextfield(
                                                          controller:
                                                              _commentcontroler)),
                                                  const SizedBox(width: 8),
                                                  CustomSendButton(
                                                      onPressed: () {
                                                    addcomment(
                                                      namecontroller.toString(),
                                                      image.toString(),
                                                      _commentcontroler.text
                                                          .toString(),
                                                    );
                                                  })
                                                ],
                                              ),
                                            ));
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
