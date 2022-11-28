import 'package:finalyear/AS%20A%20PLAYER/internationalsports/Details/coachdetail.dart';
import 'package:finalyear/model/coachmodel.dart';
import 'package:flutter/material.dart';

class playerfootball extends StatefulWidget {
  const playerfootball({super.key});

  @override
  State<playerfootball> createState() => _playerfootballState();
}

class _playerfootballState extends State<playerfootball> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        // const Padding(
        //   padding: EdgeInsets.only(right: 20, top: 5),
        //   child: Center(
        //     child: Text(
        //       "Coaches",
        //       style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
        //     ),
        //   ),
        // ),
        const SizedBox(height: 20),
        Expanded(
            // child: Container(
            //     height: 550,
            //     decoration: const BoxDecoration(
            //         borderRadius: BorderRadius.only(
            //             topRight: Radius.circular(25.0),
            //             topLeft: Radius.circular(25.0)),
            //         color: Colors.grey),
            child: ListView.builder(
                itemCount: coachdata.length,
                itemBuilder: (BuildContext context, index) {
                  return Container(
                    height: 80,
                    child: Card(
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
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const coachdetail()));
                        },
                      ),
                    ),
                  );
                })),
      ]),
    );
  }
}
