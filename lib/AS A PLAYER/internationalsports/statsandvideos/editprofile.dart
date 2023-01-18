import 'package:flutter/material.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class editprofile extends StatefulWidget {
  const editprofile({super.key});

  @override
  State<editprofile> createState() => _editprofileState();
}

final _formKey = GlobalKey<FormState>();

class _editprofileState extends State<editprofile> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                    onTap: () async {},
                    child: Container(
                        child: CircleAvatar(
                      radius: 70,
                      backgroundColor: Colors.pink,
                      child: Image.asset("assets/mixsport.jpeg"),
                    ))),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15)),
                    labelText: "First Name",
                    prefixIcon: const Icon(Icons.person)),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "please enter your firstname";
                  } else {
                    return null;
                  }
                }),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15)),
                    labelText: "Last Name",
                    prefixIcon: const Icon(Icons.person)),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "please enter your last name";
                  } else {
                    return null;
                  }
                }),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15)),
                    labelText: "EMAIL",
                    prefixIcon: const Icon(Icons.email)),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "please enter your email";
                  } else {
                    return null;
                  }
                }),
            const SizedBox(
              height: 20,
            ),
            const SizedBox(
              height: 20,
            ),
            InternationalPhoneNumberInput(
                autoValidateMode: AutovalidateMode.onUserInteraction,
                onInputChanged: (val) {},
                inputDecoration: const InputDecoration(
                  border: InputBorder.none,
                  labelText: "phone number",
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "please enter your phone number";
                  } else {
                    return null;
                  }
                }),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Processing Data')),
                    );
                  }
                },
                child: const Text("Save changes"))
          ]),
        ),
      ),
    ));
  }
}
