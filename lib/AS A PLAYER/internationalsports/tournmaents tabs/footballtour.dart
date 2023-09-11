import 'package:finalyear/API/footballApi/soccer.dart';
import 'package:finalyear/GETX/tournamentdata.dart';
import 'package:finalyear/wedgets/data/Tournament-Data.dart';
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
      init: tournamentdata(), // Create an instance of the controller class
      builder: (controller) {
        return RefreshIndicator(
          onRefresh: () async {
            await controller
                .Gettournamentdata(); // Use await to wait for the data to be fetched
          },
          child: Obx(
            () => ListView(
              children: controller.tournamentlist
                  .where((e) => e.tournamentsport == 'football')
                  .map((element) => GestureDetector(
                        onTap: () {
                          Get.to(() => const SoccerApp());
                        },
                        child: TournamentCard(
                          tournamentName: element.tournamentname,
                          tournamentlocation: element.tournamentlocation,
                          startDate: element.startdate,
                          endDate: element.enddate,
                          price: element.price,
                          tournamentimage: element.tournamentimage,
                        ),
                      ))
                  .toList(),
            ),
          ),
        );
      },
    ));
  }
}
