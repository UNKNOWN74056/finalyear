import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finalyear/GETX/imageGetx.dart';
import 'package:finalyear/components/colors.dart';
import 'package:finalyear/components/reusebletextfield.dart';
import 'package:finalyear/components/savebutton.dart';
import 'package:finalyear/components/userdataprofileedit.dart';
import 'package:finalyear/utils/Utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../GETX/updataprofile.dart';

class CustomBottomSheet extends StatefulWidget {
  final editprofiledata data;
  const CustomBottomSheet({Key? key, required this.data}) : super(key: key);

  @override
  _CustomBottomSheetState createState() => _CustomBottomSheetState();
}

class _CustomBottomSheetState extends State<CustomBottomSheet> {
  final TextEditingController fullnameupdate = TextEditingController();
  final TextEditingController citynameupdate = TextEditingController();
  final TextEditingController phoneupdate = TextEditingController();
  final TextEditingController clubupdate = TextEditingController();
  final imagecontroller = Get.put(ImageController());
  final ImagePicker picker = ImagePicker();
  final updateprofilecontroller = Get.put(updateuserprofile());
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

    if (pickedFile != null) {
      imagecontroller.image = File(pickedFile.path);
    } else {
      print("No Image Selected");
    }
  }

// pick image from camera
  Future getCameraImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      imagecontroller.image = File(pickedFile.path);
    } else {
      print("No Image Selected");
    }
  }

  //update image function
  Future updateimage() async {
    var email = FirebaseAuth.instance.currentUser!.email;
    var refer = await FirebaseStorage.instance
        .ref("/MrSport$email")
        .child('images')
        .putFile(imagecontroller.image!.absolute);
    TaskSnapshot uploadTask = refer;
    await Future.value(uploadTask);
    var newUrl = await refer.ref.getDownloadURL();

    FirebaseFirestore.instance
        .collection("users")
        .doc(email)
        .update({'Imageurl': newUrl});
  }

  @override
  void initState() {
    super.initState();
    // Set initial values for the controllers
    fullnameupdate.text = widget.data.fullname;
    citynameupdate.text = widget.data.city;
    phoneupdate.text = widget.data.phoneNumber;
    clubupdate.text = widget.data.club;
  }

  // update profile function
  Future updateprofile() async {
    if (imagecontroller.image != null) {
      // Only update the image if a new image is selected
      var email = FirebaseAuth.instance.currentUser!.email;
      var refer = await FirebaseStorage.instance
          .ref("/MrSport$email")
          .child('images')
          .putFile(imagecontroller.image!.absolute);
      TaskSnapshot uploadTask = refer;
      await Future.value(uploadTask);
      var newUrl = await refer.ref.getDownloadURL();

      // Update profile with the new image URL
      await FirebaseFirestore.instance
          .collection("users")
          .doc(FirebaseAuth.instance.currentUser!.email)
          .update({'Imageurl': newUrl.toString()});
    }

    // Update other profile information
    await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.email)
        .update({
      'fullname': fullnameupdate.text.toString(),
      'city': citynameupdate.text.toString(),
      'phoneNumber': phoneupdate.text.toString(),
      'club': clubupdate.text.toString()
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Edit profile'),
        ),
        body: Container(
          margin: const EdgeInsets.all(20),
          padding: const EdgeInsets.all(8),
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Form(
                key: updateprofilecontroller.keyForm,
                child: Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(right: 150),
                      child: Text(
                        "Fill Your Details",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    GestureDetector(
                      onTap: () async {
                        dialogAlert(context);
                        setState(
                            () {}); // Trigger a rebuild when the image is changed
                      },
                      child: Container(
                        child: imagecontroller.image ==
                                null // Check if a new image is selected
                            ? (widget.data.image_Url.isEmpty
                                ? CircleAvatar(
                                    radius: 60,
                                    child: Image.asset(
                                      "assets/logo.png",
                                      height: 90,
                                      fit: BoxFit.cover,
                                    ),
                                  )
                                : Image.network(
                                    widget.data.image_Url,
                                    height: 100,
                                    width: 100,
                                    fit: BoxFit.cover,
                                  ))
                            : Image.file(
                                // Display the new selected image
                                imagecontroller.image!,
                                height: 100,
                                width: 100,
                                fit: BoxFit.cover,
                              ),
                      ),
                    ),

                    const SizedBox(
                      height: 10,
                    ),
                    // Textfields with dialog
                    reusebletextfield(
                      controller: fullnameupdate,
                      initialValue: widget.data.fullname,
                      autoValidateMode: AutovalidateMode.onUserInteraction,
                      keyboard: TextInputType.name,
                      validator: (Value) {
                        return updateprofilecontroller.validfullname(Value!);
                      },
                      icon: const Icon(FontAwesomeIcons.clipboardUser),
                      labelText: "Enter full name",
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    reusebletextfield(
                      controller: citynameupdate,
                      initialValue: widget.data.city,
                      autoValidateMode: AutovalidateMode.onUserInteraction,
                      keyboard: TextInputType.text,
                      validator: (Value) {
                        return updateprofilecontroller.validlocation(Value!);
                      },
                      icon: const Icon(FontAwesomeIcons.locationDot),
                      labelText: "Enter location",
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    reusebletextfield(
                      controller: phoneupdate,
                      initialValue: widget.data.phoneNumber,
                      autoValidateMode: AutovalidateMode.onUserInteraction,
                      keyboard: TextInputType.phone,
                      validator: (Value) {
                        return updateprofilecontroller.validphone(Value!);
                      },
                      icon: const Icon(FontAwesomeIcons.phone),
                      labelText: "+ code phone number",
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    reusebletextfield(
                      controller: clubupdate,
                      initialValue: widget.data.club ?? " ",
                      autoValidateMode: AutovalidateMode.onUserInteraction,
                      keyboard: TextInputType.emailAddress,
                      validator: (Value) {
                        return updateprofilecontroller.validfullname(Value!);
                      },
                      icon: const Icon(FontAwesomeIcons.cloud),
                      labelText: "Enter your club",
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    // Button to add the clubs and save in database

                    savebutton(
                      onTap: () async {
                        updateprofilecontroller.checkbottomsheet();
                        if (updateprofilecontroller.isformValidated == true) {
                          try {
                            await updateprofile();
                            Get.back();
                            utils.flutter_toast(
                                "Profile has been updated.", AppColors.green);
                          } catch (error) {
                            utils.flutter_toast(
                                "Failed to update profile.", AppColors.red);
                          }
                        }
                      },
                      child: const Text("Save changes"),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
