import 'package:finalyear/AS%20A%20PLAYER/culturesport/culture_dashboard.dart';
import 'package:finalyear/AS%20A%20PLAYER/internationalsports/dashboard/dashboard.dart';
import 'package:finalyear/wedgets/homedbwedget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Homedb extends StatefulWidget {
  const Homedb({super.key});

  @override
  State<Homedb> createState() => _HomedbState();
}

class _HomedbState extends State<Homedb> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: const Text("Mr.Sports"),
            centerTitle: true,
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                const Center(
                  child: Text(
                    "What Sports Do You Interests?",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Padding(
                  padding: EdgeInsets.only(right: 130),
                  child: Text(
                    "International Sports",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                //this is the home wedget
                homedbwedget(
                  imagepath: "assets/interna.jpeg",
                  child: InkWell(
                    onTap: () {
                      Get.to(const dashboard());
                    },
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(right: 130),
                  child: Text(
                    "Culture Sports",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                //this is the home wedget
                homedbwedget(
                  imagepath: "assets/culture.jpeg",
                  child: InkWell(
                    onTap: () {
                      Get.to(const culturedashboard());
                    },
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
//Scaffold(
//   appBar: AppBar(
//       automaticallyImplyLeading: false,
//       centerTitle: true,
//       title: const Text("Mr.Sports")),
//   body: Padding(
//     padding: const EdgeInsets.all(8.0),
//     child: Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         const Text(
//           "WHAT SPORT DO YOU INTEREST?",
//           style: TextStyle(
//             fontSize: 30,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         const SizedBox(height: 10),
//         const Text(
//           " International Sports",
//           style: TextStyle(
//             fontWeight: FontWeight.bold,
//             fontSize: 20,
//           ),
//         ),
//         const SizedBox(height: 15.0),
//         InkWell(
//           onTap: () {
//             Get.to(const dashboard());
//           },
//           child: Container(
//             height: 300,
//             width: double.infinity,
//             decoration: const BoxDecoration(
//                 image: DecorationImage(
//                     fit: BoxFit.cover,
//                     image: AssetImage(
//                       "assets/interna.jpeg",
//                     ))),
//           ),
//         ),
//         const SizedBox(height: 30.0),
//         const Text(
//           " Cultural Sports",
//           style: TextStyle(
//             fontWeight: FontWeight.bold,
//             fontSize: 20,
//           ),
//         ),
//         const SizedBox(height: 15.0),
//         Expanded(
//           child: InkWell(
//             onTap: () {
//               Get.to(const culturedashboard());
//             },
//             child: Container(
//               height: 300,
//               width: double.infinity,
//               // color: Colors.amber,
//               decoration: const BoxDecoration(
//                   image: DecorationImage(
//                       fit: BoxFit.cover,
//                       image: AssetImage(
//                         "assets/culture.jpeg",
//                       ))),
//             ),
//           ),
//         ),
//       ],
//     ),
//   ),
// ),
