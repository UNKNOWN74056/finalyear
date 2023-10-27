import 'package:finalyear/views/AS%20A%20COACH/international-sports/bottomtabbars/interclub.dart';
import 'package:finalyear/views/AS%20A%20COACH/international-sports/bottomtabbars/interhome.dart';
import 'package:finalyear/views/AS%20A%20COACH/international-sports/bottomtabbars/intertournaments.dart';
import 'package:finalyear/views/AS%20A%20COACH/profile.dart';
import 'package:finalyear/views/AS%20A%20PLAYER/internationalsports/dashboard/setting.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class Player_International_Dashborad extends StatefulWidget {
  const Player_International_Dashborad({super.key});

  @override
  State<Player_International_Dashborad> createState() =>
      _Player_International_DashboradState();
}

class _Player_International_DashboradState
    extends State<Player_International_Dashborad> {
  int currentIndex = 0;

  final screens = const [
    Player_international_home(),
    interclub(),
    intertournaments(),
    
    setting(),
    playerprofile()
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: screens[currentIndex],
        bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.white70,
            selectedItemColor: const Color.fromARGB(255, 17, 0, 0),
            unselectedItemColor: Colors.grey[600],
            currentIndex: currentIndex,
            onTap: (value) => setState(() => currentIndex = value),
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Ionicons.home),
                label: "Home",
              ),
              BottomNavigationBarItem(
                icon: Icon(Ionicons.cloudy),
                label: "Clubs",
              ),
              BottomNavigationBarItem(
                icon: Icon(Ionicons.trophy),
                label: "Events",
              ),
              BottomNavigationBarItem(
                icon: Icon(Ionicons.settings),
                label: "Setting",
              ),
              BottomNavigationBarItem(
                icon: Icon(Ionicons.person),
                label: "Profile",
              ),
            ]),
      ),
    );
  }
}
