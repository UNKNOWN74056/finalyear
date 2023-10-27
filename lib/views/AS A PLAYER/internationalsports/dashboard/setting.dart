import 'package:finalyear/components/colors.dart';
import 'package:finalyear/functions/functions.dart';
import 'package:finalyear/utils/Routes_Name.dart';
import 'package:finalyear/components/savebutton.dart';
import 'package:finalyear/utils/Utils.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import '../../../../components/reusebletextfield.dart';

class setting extends StatefulWidget {
  const setting({super.key});

  @override
  State<setting> createState() => _settingState();
}

class _settingState extends State<setting> {
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
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Settings",
                style: TextStyle(fontSize: 35),
              ),
              const SizedBox(
                height: 10,
              ),
              const Divider(
                color: Colors.black,
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
                            content: const Text(
                                "Are you sure you want to request for deletion?"),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text("Cancel")),
                              TextButton(
                                  onPressed: () {
                                    functions
                                        .submitDeletionRequestWithUserData();
                                    utils.flutter_toast(
                                        "YYour request has been sent to admin.",
                                        AppColors.green);

                                    Navigator.of(context).pop();
                                    // Navigator.pushNamed(
                                    //     context, Routesname.login);
                                  },
                                  child: const Text("Yes")),
                            ],
                          );
                        });
                  },
                  child: _buildListTile(context, "Delete",
                      FontAwesomeIcons.trashCan, Colors.red)),
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
                                  utils.flutter_toast(
                                      "You have successfully logout.",
                                      AppColors.green);

                                  Navigator.pushNamed(
                                      context, Routesname.login);
                                },
                                child: const Text("Yes")),
                          ],
                        );
                      });
                },
                child: _buildListTile(context, "Logout",
                    FontAwesomeIcons.rightFromBracket, Colors.green),
              ),
              // const SizedBox(height: 10),
              // _buildSwitchListTile(
              //   context,
              //   'Dark mode',
              //   false,
              //   (bool value) {},
              // ),
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
                  showModalBottomSheet(
                      isScrollControlled: true,
                      shape: const RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.vertical(top: Radius.circular(10))),
                      context: context,
                      builder: (context) => Container(
                            margin: const EdgeInsets.all(20),
                            padding: const EdgeInsets.all(8),
                            child: Padding(
                              padding: EdgeInsets.only(
                                  bottom:
                                      MediaQuery.of(context).viewInsets.bottom),
                              child: Form(
                                key: functions.chacontroller.keyForm,
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      const SizedBox(
                                        height: 40,
                                      ),
                                      const Text(
                                          "Please enter your new password"),
                                      const SizedBox(
                                        height: 20,
                                      ),

                                      const SizedBox(
                                        height: 10,
                                      ),
                                      //textfields with dailog
                                      reusebletextfield(
                                          controller: functions
                                              .chacontroller.passwordController,
                                          autoValidateMode: AutovalidateMode
                                              .onUserInteraction,
                                          keyboard: TextInputType.emailAddress,
                                          validator: (Value) {
                                            return functions.chacontroller
                                                .validPassword(Value!);
                                          },
                                          icon:
                                              const Icon(FontAwesomeIcons.lock),
                                          labelText: "Enter your password"),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      savebutton(
                                          onTap: () {
                                            functions.chacontroller
                                                .checkPassword();
                                            if (functions.chacontroller
                                                    .isformValidated ==
                                                true) {
                                              functions.passwordchange();
                                              Get.back();
                                              utils.flutter_toast(
                                                  "Your password has been change",
                                                  AppColors.green);
                                            }
                                          },
                                          child: const Text("Save Changes"))
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ));
                },
                child: _buildListTile(context, 'Change password',
                    Icons.lock_outline, Colors.green),
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
              _buildListTile(context, 'Privacy policy',
                  Icons.privacy_tip_outlined, Colors.red),
              _buildListTile(context, 'Terms of service',
                  Icons.description_outlined, Colors.green),
            ],
          ),
        ),
      ),
    ));
  }

  // these are widgets
  Widget _buildListTile(
      BuildContext context, String title, IconData icon, Color IconColor) {
    return ListTile(
      leading: Icon(
        icon,
        color: IconColor,
      ),
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
