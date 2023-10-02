import 'package:finalyear/API/footballApi/soccer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../GETX/tournamentdata.dart';

class playertourbasketball extends StatefulWidget {
  const playertourbasketball({super.key});

  @override
  State<playertourbasketball> createState() => _playertourbasketballState();
}

class _playertourbasketballState extends State<playertourbasketball> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GetBuilder(
      init: tournamentdata(), // Create an instance of the controller class
      builder: (controller) {
        return RefreshIndicator(
          onRefresh: () async {
            controller.Gettournamentdata();
          },
          child: ListView(
            children: controller.tournamentlist
                .where((e) => e.tournamentsport == 'basketball')
                .map(
                  (element) => Column(
                    children: [
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: GestureDetector(
                          onTap: () {
                            Get.to(SoccerApp());
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.grey.shade300,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            height: 210,
                            width: MediaQuery.of(context).size.width,
                            child: Padding(
                              padding: const EdgeInsets.all(20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      CircleAvatar(
                                        radius: 25,
                                        backgroundImage: NetworkImage(
                                          element.tournamentimage,
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            element.tournamentname,
                                            style: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            element.tournamentlocation,
                                            style: const TextStyle(
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 20),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.schedule,
                                        color: Colors.blue,
                                      ),
                                      const SizedBox(width: 5),
                                      const Text(
                                        'Start At:',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(width: 5),
                                      Text(element.startdate),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.schedule,
                                        color: Colors.red,
                                      ),
                                      const SizedBox(width: 5),
                                      const Text(
                                        'End At:',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(width: 5),
                                      Text(element.enddate),
                                    ],
                                  ),
                                  const SizedBox(height: 10),
                                  Row(
                                    children: [
                                      const Icon(
                                        Icons.attach_money,
                                        color: Colors.green,
                                      ),
                                      const SizedBox(width: 5),
                                      const Text(
                                        'Price Pool:',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(width: 5),
                                      Text(
                                        element.price,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16,
                                          color: Colors.green,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
                .toList(),
          ),
        );
      },
    ));
  }
}
