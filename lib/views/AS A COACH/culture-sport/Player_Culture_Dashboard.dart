import 'package:finalyear/views/AS%20A%20COACH/culture-sport/player-culture-home.dart';
import 'package:finalyear/views/AS%20A%20COACH/culture-sport/player-culture-tournaments.dart';
import 'package:flutter/material.dart';
import '../../AS A PLAYER/internationalsports/dashboard/profile.dart';
import '../../AS A PLAYER/internationalsports/dashboard/setting.dart';
import "package:ionicons/ionicons.dart";

class Player_Culture_Dashboard extends StatefulWidget {
  const Player_Culture_Dashboard({super.key});

  @override
  State<Player_Culture_Dashboard> createState() =>
      _Player_Culture_DashboardState();
}

class _Player_Culture_DashboardState extends State<Player_Culture_Dashboard> {
  int currentIndex = 0;

  final screens = const [
    player_culture_home(),
    playerculturetournaments(),
    setting(),
    profile(),
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
