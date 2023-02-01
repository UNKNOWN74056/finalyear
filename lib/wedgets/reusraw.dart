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
    return Container(
      margin: EdgeInsets.all(5),
      child: Column(
        children: [
          ListTile(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
            tileColor: Colors.white70,
            title: Text(
              title,
              style: const TextStyle(fontSize: 20),
            ),
            leading: Icon(
              icondata,
              color: Color.fromARGB(255, 4, 45, 119),
            ),
            trailing: Text(value),
          ),
          const Divider(
            height: 15,
            color: Colors.black,
          )
        ],
      ),
    );
  }
}