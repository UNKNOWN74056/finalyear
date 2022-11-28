import 'package:finalyear/AS%20A%20COACH/culture-sport/player-culture-home.dart';
import 'package:finalyear/AS%20A%20COACH/culture-sport/player-culture-tournaments.dart';
import 'package:flutter/material.dart';

import '../../AS A PLAYER/internationalsports/dashboard/profile.dart';
import '../../AS A PLAYER/internationalsports/dashboard/setting.dart';

class cultureplayerdb extends StatefulWidget {
  const cultureplayerdb({super.key});

  @override
  State<cultureplayerdb> createState() => _cultureplayerdbState();
}

class _cultureplayerdbState extends State<cultureplayerdb> {
  int currentIndex = 0;

  final screens = const [
    playerculturehome(),
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
            selectedItemColor: Colors.blue,
            unselectedItemColor: Colors.black87,
            currentIndex: currentIndex,
            onTap: (value) => setState(() => currentIndex = value),
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: "Home",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.emoji_events),
                label: "Tournaments",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: "Setting",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: "Profile",
              ),
            ]),
      ),
    );
  }
}
