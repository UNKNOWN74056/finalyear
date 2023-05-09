import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:finalyear/functions/functions.dart';
import 'package:finalyear/pages/loginpage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import '../../../wedgets/reusebletextfield.dart';

class setting extends StatefulWidget {
  const setting({super.key});

  @override
  State<setting> createState() => _settingState();
}

class _settingState extends State<setting> {
  //text controller
  final TextEditingController changepassword = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
             const  SizedBox(
                height: 20,
              ),
              const Text(
                "Settings",
                style: TextStyle(fontSize: 40),
              ),
              const SizedBox(
                height: 15,
              ),
              const Text(
                'General',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 10),
              GestureDetector(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text("Delete Account"),
                            content:
                                const Text("Are you sure you want to delete?"),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text("Cancel")),
                              TextButton(
                                  onPressed: () {
                                    functions.delete();
                                    Navigator.pushNamed(
                                        context, loginpage.routname);
                                  },
                                  child: const Text("Yes")),
                            ],
                          );
                        });
                  },
                  child: _buildListTile(
                      context, "Delete", FontAwesomeIcons.trashCan)),
              const SizedBox(height: 10),
              GestureDetector(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text("Signout Account"),
                          content:
                              const Text("Are you sure you want to Signout?"),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: const Text("Cancel")),
                            TextButton(
                                onPressed: () {
                                  functions.signout();
                                  Navigator.pushNamed(
                                      context, loginpage.routname);
                                },
                                child: const Text("Yes")),
                          ],
                        );
                      });
                },
                child: _buildListTile(
                    context, "Logout", FontAwesomeIcons.rightFromBracket),
              ),
              const SizedBox(height: 10),
              _buildSwitchListTile(
                context,
                'Dark mode',
                false,
                (bool value) {},
              ),
              const SizedBox(height: 20),
              const Text(
                'Account',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 10),
              GestureDetector(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: const Text("Change Password"),
                          content: SingleChildScrollView(
                            child: Column(
                              children: [
                                reusebletextfield(
                                  labelText: "Password",
                                  icon: const Icon(FontAwesomeIcons.solidUser),
                                  controller: changepassword,
                                  validator: (Value) {
                                    return Value.isEmpty
                                        ? "Enter your password"
                                        : null;
                                  },
                                  autoValidateMode:
                                      AutovalidateMode.onUserInteraction,
                                  keyboard: TextInputType.text,
                                ),
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
                                      .doc(FirebaseAuth
                                          .instance.currentUser!.email)
                                      .update({
                                    'password': changepassword.text.toString()
                                  }).then((value) => {
                                            changepassword.clear(),
                                            Get.snackbar("Message",
                                                "Your passwrod has been changed")
                                          });

                                  Navigator.pop(context);
                                },
                                child: const Text("Ok"))
                          ],
                        );
                      });
                },
                child: _buildListTile(
                  context,
                  'Change password',
                  Icons.lock_outline,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'About',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              const SizedBox(height: 10),
              _buildListTile(
                context,
                'Privacy policy',
                Icons.privacy_tip_outlined,
              ),
              _buildListTile(
                context,
                'Terms of service',
                Icons.description_outlined,
              ),
            ],
          ),
        ),
      ),
    ));
  }

  // these are widgets
  Widget _buildListTile(BuildContext context, String title, IconData icon) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
    );
  }

  Widget _buildSwitchListTile(
    BuildContext context,
    String title,
    bool value,
    Function(bool) onChanged,
  ) {
    return SwitchListTile(
      title: Text(title),
      value: value,
      onChanged: onChanged,
    );
  }
}
