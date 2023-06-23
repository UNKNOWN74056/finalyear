import 'package:finalyear/AS%20A%20COACH/international-sports/bottomtabbars/interclub.dart';
import 'package:finalyear/AS%20A%20COACH/international-sports/bottomtabbars/interhome.dart';
import 'package:finalyear/AS%20A%20COACH/international-sports/bottomtabbars/intertournaments.dart';
import 'package:finalyear/AS%20A%20COACH/profile.dart';
import 'package:finalyear/AS%20A%20PLAYER/internationalsports/dashboard/setting.dart';
import 'package:flutter/material.dart';

class playerdashboeard extends StatefulWidget {
  static const String routname = "playerdashboard";
  const playerdashboeard({super.key});

  @override
  State<playerdashboeard> createState() => _playerdashboeardState();
}

class _playerdashboeardState extends State<playerdashboeard> {
  int currentIndex = 0;

  final screens = const [
    interhome(),
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
            selectedItemColor: Colors.teal,
            unselectedItemColor: Colors.black87,
            currentIndex: currentIndex,
            onTap: (value) => setState(() => currentIndex = value),
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: "Home",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.cloud),
                label: "Clubs",
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
