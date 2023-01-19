import 'package:flutter/material.dart';

class reusableraw extends StatelessWidget {
  final String title, value;
  final IconData icondata;
  const reusableraw(
      {super.key,
      required this.title,
      required this.value,
      required this.icondata});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text(
            title,
            style: TextStyle(fontSize: 20),
          ),
          leading: Icon(
            icondata,
            color: Color.fromARGB(255, 4, 45, 119),
          ),
          trailing: Text(value),
        ),
        const Divider(
          color: Colors.black,
        )
      ],
    );
  }
}
