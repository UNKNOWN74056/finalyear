import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finalyear/AS%20A%20PLAYER/internationalsports/dashboard/profile.dart';
import 'package:finalyear/wedgets/reusebletextfield.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

Future<void> usernameupdate(BuildContext Context, String firstname) async {
  updatefirstname.text = firstname;
  return showDialog(
      context: Context,
      builder: (context) {
        return AlertDialog(
          title: const Text("updat User Name"),
          content: SingleChildScrollView(
            child: Column(
              children: [
                reusebletextfield(
                    labelText: "Username",
                    icon: const Icon(FontAwesomeIcons.solidUser),
                    controller: updatefirstname,
                    validator: (Value) {
                      return Value.isEmpty ? "enter your name" : null;
                    },
                    autoValidateMode: AutovalidateMode.onUserInteraction,
                    autovalidateMode: AutovalidateMode.onUserInteraction),
              ],
            ),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Cancel")),
            TextButton(
                onPressed: () {
                  FirebaseFirestore.instance
                      .collection("users")
                      .doc(FirebaseAuth.instance.currentUser!.email)
                      .update({'firstname': updatefirstname.text.toString()});

                  Navigator.pop(context);
                },
                child: const Text("Ok"))
          ],
        );
      });
}

Future<void> cityupdate(BuildContext Context, String city) async {
  updatecity.text = city;
  return showDialog(
      context: Context,
      builder: (context) {
        return AlertDialog(
          title: const Text("update city"),
          content: SingleChildScrollView(
            child: Column(
              children: [
                reusebletextfield(
                    labelText: "City",
                    icon: const Icon(FontAwesomeIcons.solidUser),
                    controller: updatecity,
                    validator: (Value) {
                      return Value.isEmpty ? "enter your city" : null;
                    },
                    autoValidateMode: AutovalidateMode.onUserInteraction,
                    autovalidateMode: AutovalidateMode.onUserInteraction),
              ],
            ),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Cancel")),
            TextButton(
                onPressed: () {
                  FirebaseFirestore.instance
                      .collection("users")
                      .doc(FirebaseAuth.instance.currentUser!.email)
                      .update({'city': updatecity.text.toString()});

                  Navigator.pop(context);
                },
                child: const Text("Ok"))
          ],
        );
      });
}

Future<void> genderupdate(BuildContext Context, String gender) async {
  updatecity.text = gender;
  return showDialog(
      context: Context,
      builder: (context) {
        return AlertDialog(
          title: const Text("update gender"),
          content: SingleChildScrollView(
            child: Column(
              children: [
                reusebletextfield(
                    labelText: "gender",
                    icon: const Icon(FontAwesomeIcons.solidUser),
                    controller: updatecity,
                    validator: (Value) {
                      return Value.isEmpty ? "enter your gender" : null;
                    },
                    autoValidateMode: AutovalidateMode.onUserInteraction,
                    autovalidateMode: AutovalidateMode.onUserInteraction),
              ],
            ),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Cancel")),
            TextButton(
                onPressed: () {
                  FirebaseFirestore.instance
                      .collection("users")
                      .doc(FirebaseAuth.instance.currentUser!.email)
                      .update({'gender': updategender.text.toString()});

                  Navigator.pop(context);
                },
                child: const Text("Ok"))
          ],
        );
      });
}

// Future<void> phoneupdate(BuildContext Context, String phone) async {
//   phoneupdate.text = phone;
//   return showDialog(
//       context: Context,
//       builder: (context) {
//         return AlertDialog(
//           title: const Text("update gender"),
//           content: SingleChildScrollView(
//             child: Column(
//               children: [
//                 reusebletextfield(
//                     labelText: "gender",
//                     icon: const Icon(FontAwesomeIcons.solidUser),
//                     controller: updatecity,
//                     validator: (Value) {
//                       return Value.isEmpty ? "enter your gender" : null;
//                     },
//                     autoValidateMode: AutovalidateMode.onUserInteraction,
//                     autovalidateMode: AutovalidateMode.onUserInteraction),
//               ],
//             ),
//           ),
//           actions: [
//             TextButton(
//                 onPressed: () {
//                   Navigator.pop(context);
//                 },
//                 child: const Text("Cancel")),
//             TextButton(
//                 onPressed: () {
//                   FirebaseFirestore.instance
//                       .collection("users")
//                       .doc(FirebaseAuth.instance.currentUser!.email)
//                       .update({'gender': updategender.text.toString()});
//                   Navigator.pop(context);
//                 },
//                 child: const Text("Ok"))
//           ],
//         );
//       });
// }

