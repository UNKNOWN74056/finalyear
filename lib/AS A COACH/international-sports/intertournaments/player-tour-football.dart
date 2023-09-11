import 'package:finalyear/API/footballApi/soccer.dart';
import 'package:finalyear/wedgets/data/Tournament-Data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../GETX/tournamentdata.dart';

class playertourfootball extends StatefulWidget {
  const playertourfootball({super.key});

  @override
  State<playertourfootball> createState() => _playertourfootballState();
}

class _playertourfootballState extends State<playertourfootball> {
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
                          Get.to(SoccerApp());
                        },
                        child: TournamentCard(
                            tournamentName: element.tournamentName,
                            tournamentlocation: element.tournamentlocation,
                            startDate: element.startDate,
                            endDate: element.endDate,
                            price: element.price,
                            tournamentimage: element.tournamentimage),
                      ))
                  .toList(),
            ),
          ),
        );
      },
    ));
  }
}
