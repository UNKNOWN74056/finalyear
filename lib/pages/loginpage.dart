import 'package:finalyear/AS%20A%20PLAYER/internationalsports/dashboard/homedb.dart';
import 'package:finalyear/pages/forgotpassword.dart';
import 'package:finalyear/pages/signuppage.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class loginpage extends StatefulWidget {
  const loginpage({super.key});
  @override
  State<loginpage> createState() => _loginpageState();
}

class _loginpageState extends State<loginpage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: SingleChildScrollView(
      child: Form(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Container(
                child: const Text(
                  "LOGIN ",
                  style: TextStyle(fontSize: 30),
                ),
              ),
            ),
            const Center(
              child: Padding(
                padding: EdgeInsets.only(top: 40),
                child: CircleAvatar(
                  radius: 80,
                  backgroundImage: AssetImage("assets/mixsport.jpeg"),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: [
                  const TextForm(
                    lable: "EMAIL",
                    hint: "Enter your email",
                    icon: Icon(Icons.person),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  TextForm(
                    lable: "PASSWORD",
                    hint: "Enter your password",
                    icon: Icon(Icons.lock),
                    iccon: GestureDetector(
                      onTap: () {
                        setState(() {});
                      },
                      child: const Icon(Icons.visibility_off),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 13),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: ((context) =>
                                    const forgotpassword())));
                      },
                      child: const Text("Forgot password"))
                ],
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.only(left: 30, right: 30),
                child: ElevatedButton(
                    // i use there also get
                    onPressed: () => Get.to(() => (const Homedb())),
                    child: const Text("LOGIN")),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 25, right: 25),
              child: SizedBox(
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                      primary: Colors.teal,
                      onPrimary: Colors.black,
                      minimumSize: const Size(double.infinity, 40)),
                  icon: const FaIcon(FontAwesomeIcons.google),
                  label: const Text(
                    "Sign in with google",
                    style: TextStyle(color: Colors.black),
                  ),
                  onPressed: () {},
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Do not have an account!"),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const signuppage()));
                    },
                    child: const Text("SIGNUP"))
              ],
            ),
          ],
        ),
      ),
    )));
  }
}

class TextForm extends StatelessWidget {
  const TextForm({
    required this.lable,
    required this.hint,
    required this.icon,
    this.iccon,
    Key? key,
  }) : super(key: key);
  final lable;
  final hint;
  final icon;
  final iccon;

  @override
  Widget build(BuildContext context) {
    var obscureText = true;
    return TextFormField(
        //obscureText: obscureText,
        style: const TextStyle(color: Colors.black),
        decoration: InputDecoration(
          labelText: lable,
          hintText: hint,
          prefixIcon: icon,
          suffixIcon: iccon,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.black),
            borderRadius: BorderRadius.circular(20),
          ),
        ));
  }
}
