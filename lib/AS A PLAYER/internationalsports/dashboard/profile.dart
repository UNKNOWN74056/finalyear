import 'dart:io';
import 'package:chewie/chewie.dart';
import 'package:finalyear/GETX/getdatafromfirebase.dart';
import 'package:finalyear/GETX/updataprofile.dart';
import 'package:finalyear/functions/functions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';
import '../../../GETX/allvideos.dart';
import '../../../wedgets/reusebletextfield.dart';
import '../../../wedgets/savebutton.dart';

class profile extends StatefulWidget {
  const profile({super.key});

  @override
  State<profile> createState() => _profileState();
}

File? _image;
final ImagePicker picker = ImagePicker();
final currentUser = FirebaseAuth.instance;

class _profileState extends State<profile> {
  //getx controller
  final vidcontroller = Get.put(FetchVideoFirebase());
  final List<VideoPlayerController> _controllers = [];
  final updateprofilecontroller = Get.put(updateuserprofile());
  final currentuser = FirebaseAuth.instance.currentUser!.email;

  get documentReference => null;
  //dailog to select photo from camera or gallery
  void dialogAlert(context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            content: SizedBox(
              height: 120,
              child: Column(
                children: [
                  InkWell(
                    onTap: () {
                      getCameraImage();
                      Navigator.pop(context);
                    },
                    child: const ListTile(
                      leading: Icon(Icons.camera_alt),
                      title: Text("Camera"),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      getImageGallery();
                      Navigator.pop(context);
                    },
                    child: const ListTile(
                      leading: Icon(Icons.photo),
                      title: Text("Gallery"),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  //pick image from galler
  Future getImageGallery() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print("No Image Selected");
      }
    });
  }

// pick image from camera
  Future getCameraImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print("No Image Selected");
      }
    });
  }

  //update image function
  Future updateimage() async {
    var email = FirebaseAuth.instance.currentUser!.email;
    var refer = await FirebaseStorage.instance
        .ref("/MrSport$email")
        .child('images')
        .putFile(_image!.absolute);
    TaskSnapshot uploadTask = refer;
    await Future.value(uploadTask);
    var newUrl = await refer.ref.getDownloadURL();

    FirebaseFirestore.instance
        .collection("users")
        .doc(email)
        .update({'Imageurl': newUrl});
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    updateprofilecontroller.updatefullnamecontroller.dispose();
    updateprofilecontroller.updatecitycontroller.dispose();
    updateprofilecontroller.updatephonecontroller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            functions.pickVideo();
          },
          icon: const Icon(
            FontAwesomeIcons.video,
            color: Colors.red,
          ),
          label: const Text("Add videos"),
        ),
        body: GetBuilder(
            init: FetchDataFirebase(),
            builder: (controller) {
              return RefreshIndicator(
                  onRefresh: () async {
                    vidcontroller.Getallvideos();
                    controller.GetDataFirebase();
                  },
                  child: Obx(() => Column(children: [
                        Expanded(
                            child: ListView(
                                children: controller.mylist
                                    .where((e) =>
                                        e.email ==
                                        FirebaseAuth
                                            .instance.currentUser!.email)
                                    .map(
                                        (element) => Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      const Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                top: 20,
                                                                left: 10),
                                                        child: Text(
                                                          "Profile",
                                                          style: TextStyle(
                                                              fontSize: 40),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                right: 10,
                                                                top: 10),
                                                        child: InkWell(
                                                          onTap: () async {
                                                            functions
                                                                .transfer_request_email();
                                                          },
                                                          child: const Icon(
                                                              FontAwesomeIcons
                                                                  .rightLeft),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                  Container(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            16.0),
                                                    child: Row(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        CircleAvatar(
                                                          radius: 40.0,
                                                          backgroundImage:
                                                              NetworkImage(element
                                                                  .image_Url),
                                                        ),
                                                        const SizedBox(
                                                            width: 16.0),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  top: 30),
                                                          child: Expanded(
                                                            child: Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Text(
                                                                  element
                                                                      .fullname,
                                                                  style:
                                                                      const TextStyle(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontSize:
                                                                        20,
                                                                  ),
                                                                ),
                                                                const SizedBox(
                                                                    height:
                                                                        8.0),
                                                                Row(
                                                                  children: [
                                                                    const Text(
                                                                        "Gender: "),
                                                                    Text(
                                                                      element
                                                                          .gender,
                                                                      style:
                                                                          TextStyle(
                                                                        color: Colors
                                                                            .grey[600],
                                                                        fontSize:
                                                                            16.0,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                                const SizedBox(
                                                                    height:
                                                                        8.0),
                                                                Row(
                                                                  children: [
                                                                    const Text(
                                                                        "Favorite sport: "),
                                                                    Text(
                                                                      element
                                                                          .sport,
                                                                      style:
                                                                          TextStyle(
                                                                        color: Colors
                                                                            .grey[600],
                                                                        fontSize:
                                                                            16.0,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                                const SizedBox(
                                                                    height:
                                                                        8.0),
                                                                Row(
                                                                  children: [
                                                                    const Text(
                                                                        "Location: "),
                                                                    Text(
                                                                      element
                                                                          .city,
                                                                      style:
                                                                          TextStyle(
                                                                        color: Colors
                                                                            .grey[600],
                                                                        fontSize:
                                                                            16.0,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                                const SizedBox(
                                                                    height:
                                                                        8.0),
                                                                Row(
                                                                  children: [
                                                                    const Icon(
                                                                        Icons
                                                                            .star,
                                                                        color: Colors
                                                                            .yellow),
                                                                    const SizedBox(
                                                                        width:
                                                                            4.0),
                                                                    Text(
                                                                      element
                                                                          .rating,
                                                                      style:
                                                                          const TextStyle(
                                                                        fontSize:
                                                                            16.0,
                                                                      ),
                                                                    ),
                                                                    const SizedBox(
                                                                        width:
                                                                            4.0),
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                              .only(
                                                                          left:
                                                                              40),
                                                                      child:
                                                                          ElevatedButton(
                                                                        onPressed:
                                                                            () {
                                                                          showModalBottomSheet(
                                                                              isScrollControlled: true,
                                                                              shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(10))),
                                                                              context: context,
                                                                              builder: (context) => Container(
                                                                                    margin: const EdgeInsets.all(20),
                                                                                    padding: const EdgeInsets.all(8),
                                                                                    child: Padding(
                                                                                      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                                                                                      child: Form(
                                                                                        key: updateprofilecontroller.keyForm,
                                                                                        child: SingleChildScrollView(
                                                                                          child: Column(
                                                                                            children: [
                                                                                              const SizedBox(
                                                                                                height: 40,
                                                                                              ),
                                                                                              const Text("PLease fill these fields"),
                                                                                              const SizedBox(
                                                                                                height: 20,
                                                                                              ),
                                                                                              GestureDetector(
                                                                                                onTap: () async {
                                                                                                  dialogAlert(context);
                                                                                                },
                                                                                                child: Container(
                                                                                                  child: _image == null
                                                                                                      ? CircleAvatar(
                                                                                                          radius: 60,
                                                                                                          child: Image.asset(
                                                                                                            "assets/logo.png",
                                                                                                            height: 90,
                                                                                                            fit: BoxFit.cover,
                                                                                                          ))
                                                                                                      : Image.file(
                                                                                                          _image!.absolute,
                                                                                                          height: 100,
                                                                                                          width: 100,
                                                                                                          fit: BoxFit.cover,
                                                                                                        ),
                                                                                                ),
                                                                                              ),
                                                                                              const SizedBox(
                                                                                                height: 10,
                                                                                              ),
                                                                                              //textfields with dailog
                                                                                              reusebletextfield(
                                                                                                  controller: updateprofilecontroller.updatefullnamecontroller,
                                                                                                  autoValidateMode: AutovalidateMode.onUserInteraction,
                                                                                                  keyboard: TextInputType.name,
                                                                                                  validator: (Value) {
                                                                                                    return updateprofilecontroller.validfullname(Value!);
                                                                                                  },
                                                                                                  icon: const Icon(FontAwesomeIcons.clipboardUser),
                                                                                                  labelText: "Enter full name"),
                                                                                              const SizedBox(
                                                                                                height: 5,
                                                                                              ),

                                                                                              const SizedBox(
                                                                                                height: 5,
                                                                                              ),
                                                                                              reusebletextfield(
                                                                                                  controller: updateprofilecontroller.updatecitycontroller,
                                                                                                  autoValidateMode: AutovalidateMode.onUserInteraction,
                                                                                                  keyboard: TextInputType.text,
                                                                                                  validator: (Value) {
                                                                                                    return updateprofilecontroller.validlocation(Value!);
                                                                                                  },
                                                                                                  icon: const Icon(FontAwesomeIcons.locationDot),
                                                                                                  labelText: "Enter location"),
                                                                                              const SizedBox(
                                                                                                height: 5,
                                                                                              ),

                                                                                              const SizedBox(
                                                                                                height: 5,
                                                                                              ),
                                                                                              reusebletextfield(
                                                                                                  controller: updateprofilecontroller.updatephonecontroller,
                                                                                                  autoValidateMode: AutovalidateMode.onUserInteraction,
                                                                                                  keyboard: TextInputType.phone,
                                                                                                  validator: (Value) {
                                                                                                    return updateprofilecontroller.validphone(Value!);
                                                                                                  },
                                                                                                  icon: const Icon(FontAwesomeIcons.phone),
                                                                                                  labelText: "+ code phone number"),
                                                                                              const SizedBox(
                                                                                                height: 15,
                                                                                              ),

                                                                                              const SizedBox(
                                                                                                height: 15,
                                                                                              ),

                                                                                              //button to add the clubs and save in database
                                                                                              savebutton(
                                                                                                  onTap: () {
                                                                                                    updateprofilecontroller.checkbottomsheet();
                                                                                                    if (updateprofilecontroller.isformValidated == true) {
                                                                                                      functions.updateprofile();
                                                                                                      Get.back();
                                                                                                      Get.snackbar("Message", "profile has been updated.");
                                                                                                    }
                                                                                                  },
                                                                                                  child: const Text("Save changes"))
                                                                                            ],
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                    ),
                                                                                  ));
                                                                        },
                                                                        child:
                                                                            Row(
                                                                          mainAxisSize:
                                                                              MainAxisSize.min,
                                                                          children: [
                                                                            const Icon(Icons.edit),
                                                                            const SizedBox(width: 4.0),
                                                                            const Text('Edit'),
                                                                          ],
                                                                        ),
                                                                        style: ElevatedButton
                                                                            .styleFrom(
                                                                          primary:
                                                                              Colors.white, // Button background color
                                                                          onPrimary:
                                                                              Colors.black, // Text color
                                                                          shape:
                                                                              RoundedRectangleBorder(
                                                                            borderRadius:
                                                                                BorderRadius.circular(20),
                                                                          ),
                                                                          padding: const EdgeInsets.symmetric(
                                                                              horizontal: 20,
                                                                              vertical: 8.0),
                                                                          elevation:
                                                                              2.0,
                                                                        ),
                                                                      ),
                                                                    )
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              16.0),
                                                      child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            const Text(
                                                              'Videos',
                                                              style: TextStyle(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                fontSize: 20.0,
                                                              ),
                                                            ),
                                                            const SizedBox(
                                                                height: 8.0),
                                                            GridView.builder(
                                                              shrinkWrap: true,
                                                              physics:
                                                                  const NeverScrollableScrollPhysics(),
                                                              itemCount: vidcontroller
                                                                  .videolist
                                                                  .where((e) =>
                                                                      e.email ==
                                                                      currentuser)
                                                                  .length,
                                                              gridDelegate:
                                                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                                                crossAxisCount:
                                                                    2,
                                                                mainAxisSpacing:
                                                                    8.0,
                                                                crossAxisSpacing:
                                                                    8.0,
                                                              ),
                                                              itemBuilder:
                                                                  (BuildContext
                                                                          context,
                                                                      int index) {
                                                                final video = vidcontroller
                                                                    .videolist
                                                                    .where((e) =>
                                                                        e.email ==
                                                                        FirebaseAuth
                                                                            .instance
                                                                            .currentUser!
                                                                            .email)
                                                                    .toList()[index];
                                                                final _controller =
                                                                    VideoPlayerController
                                                                        .network(
                                                                            video.videolink);
                                                                _controllers.add(
                                                                    _controller);
                                                                return GestureDetector(
                                                                  onTap: () {
                                                                    Navigator
                                                                        .push(
                                                                      context,
                                                                      MaterialPageRoute(
                                                                        builder:
                                                                            (context) =>
                                                                                Scaffold(
                                                                          body:
                                                                              Chewie(
                                                                            controller:
                                                                                ChewieController(
                                                                              videoPlayerController: _controller,
                                                                              autoPlay: true,
                                                                              looping: false,
                                                                              additionalOptions: (context) {
                                                                                return <OptionItem>[
                                                                                  OptionItem(
                                                                                    onTap: () async {
                                                                                      // Show confirmation dialog
                                                                                      final confirmed = await showDialog<bool>(
                                                                                        context: context,
                                                                                        builder: (context) => AlertDialog(
                                                                                          title: const Text('Delete video'),
                                                                                          content: const Text('Are you sure you want to delete this video?'),
                                                                                          actions: <Widget>[
                                                                                            TextButton(
                                                                                              onPressed: () => Navigator.of(context).pop(false),
                                                                                              child: const Text('Cancel'),
                                                                                            ),
                                                                                            TextButton(
                                                                                              onPressed: () => Navigator.of(context).pop(true),
                                                                                              child: const Text('Delete'),
                                                                                            ),
                                                                                          ],
                                                                                        ),
                                                                                      );

                                                                                      if (confirmed == true) {
                                                                                        // Delete video document from Firestore
                                                                                        await FirebaseFirestore.instance.collection('videos').doc(video["id"]).delete();

                                                                                        // Remove video controller from list and dispose it
                                                                                        _controllers.remove(_controller);
                                                                                        _controller.dispose();

                                                                                        // Remove video from video list in controller
                                                                                        vidcontroller.videolist.remove(video);

                                                                                        // Refresh GridView
                                                                                        setState(() {});
                                                                                      }
                                                                                    },
                                                                                    iconData: FontAwesomeIcons.trash,
                                                                                    title: 'Delete',
                                                                                  ),
                                                                                ];
                                                                              },
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
                                                                                backgroundColor: const Color.fromARGB(78, 158, 158, 158),
                                                                                bufferedColor: Colors.grey,
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    );
                                                                  },
                                                                  child:
                                                                      Container(
                                                                    padding:
                                                                        const EdgeInsets.all(
                                                                            8.0),
                                                                    decoration:
                                                                        BoxDecoration(
                                                                      color: Colors
                                                                          .white70,
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              8.0),
                                                                      boxShadow: [
                                                                        BoxShadow(
                                                                          color: Colors
                                                                              .grey
                                                                              .withOpacity(0.5),
                                                                          spreadRadius:
                                                                              1,
                                                                          blurRadius:
                                                                              5,
                                                                          offset: const Offset(
                                                                              0,
                                                                              3),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    child:
                                                                        FutureBuilder(
                                                                      future: _controller
                                                                          .initialize(),
                                                                      builder: (BuildContext
                                                                              context,
                                                                          AsyncSnapshot
                                                                              snapshot) {
                                                                        if (snapshot.connectionState ==
                                                                            ConnectionState.done) {
                                                                          return AspectRatio(
                                                                            aspectRatio:
                                                                                16 / 9,
                                                                            child:
                                                                                VideoPlayer(_controller),
                                                                          );
                                                                        } else if (snapshot
                                                                            .hasError) {
                                                                          return Text(
                                                                              'Error loading video');
                                                                        } else {
                                                                          return Container(
                                                                            height:
                                                                                200.0,
                                                                            color:
                                                                                Colors.grey[200],
                                                                          );
                                                                        }
                                                                      },
                                                                    ),
                                                                  ),
                                                                );
                                                              },
                                                            ),
                                                          ]))
                                                ]))
                                    .toList()))
                      ])));
            }),
      ),
    );
  }
}
