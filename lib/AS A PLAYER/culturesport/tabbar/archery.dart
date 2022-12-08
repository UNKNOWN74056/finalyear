import 'package:finalyear/AS%20A%20PLAYER/internationalsports/Details/coachdetail.dart';
import 'package:finalyear/model/coachmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class archery extends StatefulWidget {
  const archery({super.key});

  @override
  State<archery> createState() => _archeryState();
}

class _archeryState extends State<archery> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 28, 32, 47),
      body: Column(children: [
        const SizedBox(height: 20),
        Expanded(
            child: ListView.builder(
                itemCount: coachdata.length,
                itemBuilder: (BuildContext context, index) {
                  return Container(
                    height: 80,
                    child: Card(
                      color: Colors.blueGrey,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      child: ListTile(
                        title: Text(
                          coachdata[index].name,
                          style: const TextStyle(fontSize: 20),
                        ),
                        leading: const CircleAvatar(
                            radius: 35,
                            backgroundImage: AssetImage("assets/mech.jpg"),
                            backgroundColor: Colors.green),
                        subtitle: Text(coachdata[index].discription,
                            style: const TextStyle(fontSize: 15)),
                        trailing: const Icon(Icons.arrow_forward),
                        onTap: () {
                          navigator?.push(MaterialPageRoute(
                              builder: ((context) => const coachdetail())));
                        },
                      ),
                    ),
                  );
                })),
      ]),
    );
  }
}
