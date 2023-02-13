import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finalyear/GETX/SignupGetX.dart';
import 'package:finalyear/pages/loginpage.dart';
import 'package:finalyear/service/internet_connection.dart';
import 'package:finalyear/wedgets/loginbutton.dart';
import 'package:finalyear/wedgets/reusebletextfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class signuppage extends StatefulWidget {
  const signuppage({super.key});

  @override
  State<signuppage> createState() => _signuppageState();
}

class _signuppageState extends State<signuppage> {
  //GETX contoller
  final controller = Get.put(sighnupcontroller());

  File? _image;
  final ImagePicker picker = ImagePicker();
  final _formKey = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

//pick image from gallery
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

  final _professioncontroller = TextEditingController();
  final _gendercontroller = TextEditingController();
  final _sportcontroller = TextEditingController();

  // @override
  // void dispose() {
  //   controller.fullnamecontroller.dispose();
  //   _professioncontroller.dispose();
  //   _gendercontroller.dispose();
  //   _sportcontroller.dispose();
  //   controller.citycontroller.dispose();
  //   controller.emailController.dispose();
  //   controller.passwordcontroller.dispose();
  //   controller.confirmpasswordcontroller.dispose();
  //   controller.phonenumbercontroller.dispose();

  //   super.dispose();
  // }

  //options for profession
  List profession = ['Coache', 'Player'];
  String? profession1;

  //options for gender
  List gender = ['Male', 'Female', 'Other'];
  String? gender1;

  //options for type of sports
  List sports = [
    'FootBall',
    'BasketBall',
    'VulleyBall',
    'TableTenis',
    'Cricket',
    'Hockey',
    'Archery',
    'Kabaddi',
    'Tent pagging',
    'Gymnastic'
  ];
  String? sport1;

  //function to create user
  Future signup() async {
    try {
      checkconnectivity();
      passwrodconfirm();
      showDialog(
          context: context,
          builder: (context) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          });

      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: controller.email.value.toString(),
        password: controller.password.value.toString(),
      );
      String email = controller.emailController.text.toString();
      var refer = await FirebaseStorage.instance
          .ref("/MrSport$email")
          .child('images')
          .putFile(_image!.absolute);
      TaskSnapshot uploadTask = refer;
      await Future.value(uploadTask);
      var newUrl = await refer.ref.getDownloadURL();

      Adduserdeatial(
        controller.fullnamecontroller.value.text,
        _professioncontroller.text.trim(),
        _gendercontroller.text.trim(),
        _sportcontroller.text.trim(),
        controller.citycontroller.value.text,
        controller.emailController.value.text,
        controller.passwordcontroller.value.text,
        controller.phonenumbercontroller.value.text,
        newUrl.toString(),
      );
      Get.snackbar("Registration",
          "Your account has been register succefully please login again.");
      Navigator.of(context).pop();
      Get.to(const loginpage());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Get.snackbar("Password weak", "Password is too weak!");
        Navigator.of(context).pop();
      } else if (e.code == 'email-already-in-use') {
        Get.snackbar(
            "Email", "This email is already in use please try a valid email!");
        Navigator.of(context).pop();
      }
    }
  }

  //add user details to firestore database
  Future Adduserdeatial(
    String fullname,
    String profession,
    String gender,
    String sports,
    String city,
    String email,
    String password,
    String phone,
    String url,
  ) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.email)
        .set({
      'fullname': fullname,
      'profession': profession1,
      'gender': gender1,
      'sport': sport1,
      'city': city,
      'email': email,
      'Imageurl': url,
      'password': password,
      'phoneNumber': phone,
    });
  }

  //bool function to confirm password
  void passwrodconfirm() {
    if (controller.passwordcontroller.text.trim() ==
        controller.confirmpasswordcontroller.text.trim()) {
      return null;
    } else {
      Get.snackbar(
          "Passwrod", "The password and confirm password are not equal");
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: SingleChildScrollView(
      child: Column(children: [
        Padding(
          padding: const EdgeInsets.only(top: 30, left: 10),
          child: Container(
            child: const Text(
              "SIGN UP",
              style: TextStyle(
                fontSize: 40,
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        const Text(
          "Register below with your details",
          style: TextStyle(fontSize: 20),
        ),
        const SizedBox(
          height: 15,
        ),
        Form(
          key: controller.keyForm,
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
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
                  height: 15,
                ),
                reusebletextfield(
                  keyboard: TextInputType.emailAddress,
                  autoValidateMode: AutovalidateMode.onUserInteraction,
                  validator: (Value) {
                    return controller.validfullname(Value!);
                  },
                  labelText: "Full Name",
                  icon: const Icon(
                    FontAwesomeIcons.solidUser,
                    color: Color.fromARGB(255, 4, 45, 119),
                  ),
                  controller: controller.fullnamecontroller,
                ),
                const SizedBox(
                  height: 25,
                ),
                const SizedBox(
                  height: 25,
                ),
                DropdownButtonFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  value: profession1,
                  onChanged: (newvalue) {
                    setState(() {
                      profession1 = newvalue as String;
                    });
                  },
                  items: profession
                      .map(
                        (e) => DropdownMenuItem(
                          child: Text(e),
                          value: e,
                        ),
                      )
                      .toList(),
                  validator: (value) {
                    if (value == null) {
                      return "please enter your profession";
                    } else {
                      return null;
                    }
                  },
                  icon: const Icon(
                    Icons.arrow_drop_down_circle,
                    color: Colors.purple,
                  ),
                  decoration: InputDecoration(
                    filled: true,
                    isDense: true,
                    contentPadding: const EdgeInsets.symmetric(vertical: 22),
                    prefixIcon: const Icon(
                      FontAwesomeIcons.userTie,
                      color: Color.fromARGB(255, 4, 45, 119),
                    ),
                    labelText: "Your profession",
                    hintStyle: const TextStyle(
                      color: Colors.grey,
                    ),
                    enabledBorder: OutlineInputBorder(
                      // borderSide: const BorderSide(
                      //   width: 4,
                      //   //  color: Colors.lightGreen,
                      // ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                DropdownButtonFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    value: gender1,
                    onChanged: (newvalue) {
                      setState(() {
                        gender1 = newvalue as String;
                      });
                    },
                    items: gender
                        .map(
                          (e) => DropdownMenuItem(
                            child: Text(e),
                            value: e,
                          ),
                        )
                        .toList(),
                    icon: const Icon(
                      Icons.arrow_drop_down_circle,
                      color: Colors.purple,
                    ),
                    decoration: InputDecoration(
                      filled: true,
                      isDense: true,
                      contentPadding: const EdgeInsets.symmetric(vertical: 22),
                      prefixIcon: const Icon(
                        FontAwesomeIcons.venusMars,
                        color: Color.fromARGB(255, 4, 45, 119),
                      ),
                      labelText: "Your gender",
                      hintStyle: const TextStyle(
                        color: Colors.grey,
                      ),
                      enabledBorder: OutlineInputBorder(
                        // borderSide: const BorderSide(
                        //   width: 4,
                        //   //  color: Colors.lightGreen,
                        // ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    validator: (value) {
                      if (value == null) {
                        return "please enter your gender";
                      } else {
                        return null;
                      }
                    }),
                const SizedBox(
                  height: 25,
                ),
                DropdownButtonFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    value: sport1,
                    onChanged: (val) {
                      setState(() {
                        sport1 = val as String;
                      });
                    },
                    items: sports
                        .map(
                          (e) => DropdownMenuItem(
                            child: Text(e),
                            value: e,
                          ),
                        )
                        .toList(),
                    icon: const Icon(
                      Icons.arrow_drop_down_circle,
                      color: Colors.purple,
                    ),
                    decoration: InputDecoration(
                      filled: true,
                      isDense: true,
                      contentPadding: const EdgeInsets.symmetric(vertical: 22),
                      prefixIcon: const Icon(
                        FontAwesomeIcons.futbol,
                        color: Color.fromARGB(255, 4, 45, 119),
                      ),
                      labelText: "Your sports",
                      hintStyle: const TextStyle(
                        color: Colors.grey,
                      ),
                      enabledBorder: OutlineInputBorder(
                        // borderSide: const BorderSide(
                        //   width: 4,
                        //   //  color: Colors.lightGreen,
                        // ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    validator: (value) {
                      if (value == null) {
                        return "please enter your sports";
                      } else {
                        return null;
                      }
                    }),
                const SizedBox(
                  height: 25,
                ),
                reusebletextfield(
                  keyboard: TextInputType.emailAddress,
                  autoValidateMode: AutovalidateMode.onUserInteraction,
                  validator: (Value) {
                    return controller.validcity(Value!);
                  },
                  labelText: "City",
                  controller: controller.citycontroller,
                  icon: const Icon(
                    FontAwesomeIcons.locationDot,
                    color: Color.fromARGB(255, 4, 45, 119),
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                reusebletextfield(
                    keyboard: TextInputType.emailAddress,
                    autoValidateMode: AutovalidateMode.onUserInteraction,
                    validator: (Value) {
                      return controller.validEmail(Value!);
                    },
                    controller: controller.emailController,
                    labelText: "EMAIL",
                    icon: const Icon(
                      FontAwesomeIcons.solidEnvelope,
                      color: Color.fromARGB(255, 4, 45, 119),
                    )),
                const SizedBox(
                  height: 25,
                ),
                reusebletextfield(
                    keyboard: TextInputType.emailAddress,
                    autoValidateMode: AutovalidateMode.onUserInteraction,
                    validator: (Value) {
                      return controller.validPassword(Value!);
                    },
                    controller: controller.passwordcontroller,
                    labelText: "PASSWORD",
                    icon: const Icon(Icons.lock,
                        color: Color.fromARGB(255, 4, 45, 119))),
                const SizedBox(
                  height: 25,
                ),
                reusebletextfield(
                    keyboard: TextInputType.emailAddress,
                    autoValidateMode: AutovalidateMode.onUserInteraction,
                    validator: (Value) {
                      return controller.validconfirmPassword(Value!);
                    },
                    controller: controller.confirmpasswordcontroller,
                    labelText: "confirm password",
                    icon: const Icon(Icons.lock,
                        color: Color.fromARGB(255, 4, 45, 119))),
                const SizedBox(
                  height: 25,
                ),
                reusebletextfield(
                  keyboard: TextInputType.phone,
                  labelText: "+ Code phone number",
                  icon: const Icon(FontAwesomeIcons.phone,
                      color: Color.fromARGB(255, 4, 45, 119)),
                  controller: controller.phonenumbercontroller,
                  validator: (Value) {
                    return controller.validphonenumber(Value!);
                  },
                  autoValidateMode: AutovalidateMode.onUserInteraction,
                ),
                const SizedBox(
                  height: 10,
                ),
                //this is signup button to create the user
                loginbutton(
                  onTap: () {
                    controller.checksignup();
                    if (controller.isformValidated == true) {
                      signup();
                    }
                  },
                  child: const Text(
                    "Sign in",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                ),

                //login button if u have account
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("All ready have an account!"),
                    TextButton(
                        // i use get for going to login screen
                        onPressed: () {
                          Get.back();
                        },
                        child: const Text(
                          "LOGIN",
                        ))
                  ],
                ),
                // Obx(() => Text(controller.fullname.value)),
                // Obx(() => Text(controller.city.value)),
                // Obx(() => Text(controller.email.value)),
                // Obx(() => Text(controller.phonenumber.value)),
                // Obx(() => Text(controller.confirmpasswrod.value)),
              ],
            ),
          ),
        ),
      ]),
    )));
  }
}
