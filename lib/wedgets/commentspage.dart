import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';

class commentpage extends StatefulWidget {
  const commentpage({
    super.key,
  });

  @override
  State<commentpage> createState() => _commentpageState();
}

final TextEditingController _commentcontroler = TextEditingController();

class _commentpageState extends State<commentpage> {
  Future addcommnet() async {
    await FirebaseFirestore.instance
        .collection("comments")
        .doc(FirebaseAuth.instance.currentUser!.email)
        .set({
      'email': FirebaseAuth.instance.currentUser!.email,
      'comment': _commentcontroler.text.toString(),
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Comments"),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: [
            ListView(),
            Form(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Row(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width - 55,
                      child: Card(
                        margin:
                            const EdgeInsets.only(left: 9, right: 2, bottom: 8),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(9)),
                        color: Colors.blueGrey,
                        child: TextFormField(
                          cursorColor: Colors.white,
                          controller: _commentcontroler,
                          textAlignVertical: TextAlignVertical.center,
                          keyboardType: TextInputType.multiline,
                          maxLines: 5,
                          minLines: 2,
                          decoration: InputDecoration(
                              hintText: "Write your comment....",
                              prefixIcon: const CircleAvatar(
                                child:
                                    Image(image: AssetImage("assets/logo.png")),
                              ),
                              suffixIcon: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  GestureDetector(
                                    onTap: (() {
                                      addcommnet();
                                    }),
                                    child: const Icon(
                                        FontAwesomeIcons.solidPaperPlane,
                                        color: Colors.red),
                                  ),
                                ],
                              ),
                              contentPadding: const EdgeInsets.all(5)),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
