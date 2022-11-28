import 'package:finalyear/model/tournamentmodel.dart';
import 'package:flutter/material.dart';

class tourarchery extends StatefulWidget {
  const tourarchery({super.key});

  @override
  State<tourarchery> createState() => _tourarcheryState();
}

class _tourarcheryState extends State<tourarchery> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // const Padding(
          //   padding: EdgeInsets.only(right: 20, top: 5),
          //   child: Center(
          //     child: Text(
          //       "Todays Matches",
          //       style: TextStyle(
          //         fontSize: 40,
          //         fontWeight: FontWeight.bold,
          //       ),
          //     ),
          //   ),
          // ),
          const SizedBox(
            height: 20,
          ),
          Expanded(
            child: ListView.builder(
                itemCount: tourdata.length,
                itemBuilder: (BuildContext context, index) {
                  return Container(
                    height: 80,
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(left: 20),
                            child: CircleAvatar(
                              radius: 25,
                              backgroundImage: AssetImage("assets/Arsenal.png"),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Text(
                              tourdata[index].name,
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(left: 20),
                            child: Text(
                              "0:0",
                              style: TextStyle(
                                  fontSize: 30, fontWeight: FontWeight.bold),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Text(
                              tourdata[index].name2,
                              style: const TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.only(left: 20),
                            child: CircleAvatar(
                              radius: 25,
                              backgroundImage:
                                  AssetImage("assets/RealMadrid.png"),
                            ),
                          )
                        ],
                      ),
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}
