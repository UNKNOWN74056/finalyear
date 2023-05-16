import 'package:finalyear/AS%20A%20PLAYER/internationalsports/tournamentsregistration/registration.dart';
import 'package:finalyear/GETX/tournamentdata.dart';
import 'package:finalyear/model/tournamentmodel.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class footballtour extends StatefulWidget {
  const footballtour({super.key});

  @override
  State<footballtour> createState() => _footballtourState();
}

class _footballtourState extends State<footballtour> {
  //getx controller
  final controller = Get.put(tournamentdata());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GetBuilder(
            init: tournamentdata(),
            builder: (controller) {
              return ListView(
                  children: controller.tournamentlist
                      // .where((e) => e.tournamentsport == "football")
                      .map(
                        (element) => Column(
                          children: [
                            const SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 10, right: 10),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.grey.shade300,
                                    border: Border.all(),
                                    borderRadius: BorderRadius.circular(15)),
                                height:
                                    MediaQuery.of(context).size.height * 0.20,
                                width: MediaQuery.of(context).size.width,
                                child: Column(
                                  children: [
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 10),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          CircleAvatar(
                                            radius: 25,
                                            backgroundImage: NetworkImage(
                                                element.tournamentimage),
                                          ),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 10),
                                                child: Text(
                                                  element.tournamentname,
                                                  style: const TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 0),
                                                child: Text(
                                                    element.tournamentlocation),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 10, top: 10),
                                          child: Row(
                                            children: [
                                              const Text(
                                                "Start At:",
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text(element.startdate),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 10),
                                          child: Row(
                                            children: [
                                              const Text(
                                                "End At: ",
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text(element.enddate)
                                            ],
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                      .toList());
            }));
  }
}
