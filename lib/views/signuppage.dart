import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finalyear/GETX/SignupGetX.dart';
import 'package:finalyear/GETX/dropdown.dart';
import 'package:finalyear/views/loginpage.dart';
import 'package:finalyear/service/internet_connection.dart';
import 'package:finalyear/components/loginbutton.dart';
import 'package:finalyear/components/reusebletextfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class signuppage extends StatefulWidget {
  static const String routname = 'sign_up_page';
  const signuppage({super.key});

  @override
  State<signuppage> createState() => _signuppageState();
}

class _signuppageState extends State<signuppage> {
  //GETX contoller
  final controller = Get.put(sighnupcontroller());
  final dropcontroller = Get.put(dropdownmanu());
  File? _image;
  final ImagePicker picker = ImagePicker();
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

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      controller.citycontroller.text = "";
      controller.confirmpasswordcontroller.text = "";
      controller.emailController.text = "";
      controller.fullnamecontroller.text = "";
      controller.passwordcontroller.text = "";
      controller.phonenumbercontroller.text = "";
      dropcontroller.Frofession.value = " ";
      dropcontroller.Gender.value = "";
      dropcontroller.Sport.value = "";
    });
  }

  //options for profession
  List profession = ['Coache', 'Player'];
  String? profession1;

  //options for gender
  List gender = ['Male', 'Female', 'Other'];
  String? gender1;

  //initial rating of a player
  var rating = 0;

  //options for type of sports
  List sports = [
    'FootBall',
    'BasketBall',
    'VolleyBall',
    'TableTennis',
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
              child: SpinKitFadingCircle(
                color: Colors.green, // Set the color of the SpinKit indicator
                size: 50.0, // Set the size of the indicator as needed
              ),
            );
          });

      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: controller.email.value,
        password: controller.password.value,
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
        dropcontroller.Frofession.value,
        dropcontroller.Gender.value,
        dropcontroller.Sport.value,
        controller.citycontroller.value.text,
        controller.emailController.value.text,
        controller.passwordcontroller.value.text,
        controller.phonenumbercontroller.value.text,
        newUrl.toString(),
        rating.toString(),
      );
      Get.snackbar(
        "Registration",
        "Your account has been register succefully please login again.",
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
      Navigator.of(context).pop();
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) => const loginpage()),
          (Route<dynamic> route) => false);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Get.snackbar(
          "Password weak",
          "Password is too weak!",
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
        Navigator.of(context).pop();
      } else if (e.code == 'email-already-in-use') {
        Get.snackbar(
          "Email",
          "This email is already in use please try a valid email!",
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
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
    String rating,
  ) async {
    await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.email)
        .set({
      'fullname': fullname,
      'profession': dropcontroller.Frofession.value,
      'gender': dropcontroller.Gender.value,
      'sport': dropcontroller.Sport.value,
      'city': city,
      'email': email,
      'Imageurl': url,
      'password': password,
      'phoneNumber': phone,
      'rating': rating,
    });
  }

  //bool function to confirm password
  void passwrodconfirm() {
    if (controller.passwordcontroller.text.trim() ==
        controller.confirmpasswordcontroller.text.trim()) {
      return;
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
          key: controller.signupkeyForm,
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
                    dropcontroller.Frofession.value = newvalue.toString();
                  },
                  items: profession
                      .map(
                        (e) => DropdownMenuItem(
                          value: e,
                          child: Text(e),
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
                      dropcontroller.Gender.value = newvalue.toString();
                    },
                    items: gender
                        .map(
                          (e) => DropdownMenuItem(
                            value: e,
                            child: Text(e),
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
                    onChanged: (newvalue) {
                      dropcontroller.Sport.value = newvalue.toString();
                    },
                    items: sports
                        .map(
                          (e) => DropdownMenuItem(
                            value: e,
                            child: Text(e),
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
                    obscureText: true,
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
                      return controller.validconfirmPassword(
                        Value!,
                        controller.passwordcontroller.text,
                      );
                    },
                    obscureText: true,
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
                  onTap: () async {
                    controller.checksignup();
                    if (_image == null) {
                      // Show an error message that the user needs to select an image first.
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text("Please select an image first."),
                        ),
                      );
                    } else if (controller.isformValidated) {
                      signup();
                    }
                  },
                  child: const Text(
                    "Sign up",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),

                //login button if u have account
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(right: 3),
                      child: Text("All ready have an account!"),
                    ),
                    GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, loginpage.routname);
                        },
                        child: const Text(
                          "LOGIN",
                          style: TextStyle(color: Colors.blue),
                        )),
                    const SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ]),
    )));
  }
}
