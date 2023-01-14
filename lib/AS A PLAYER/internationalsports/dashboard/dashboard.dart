import 'package:finalyear/AS%20A%20PLAYER/internationalsports/dashboard/clubs.dart';
import 'package:finalyear/AS%20A%20PLAYER/internationalsports/dashboard/home.dart';
import 'package:finalyear/AS%20A%20PLAYER/internationalsports/dashboard/profile.dart';
import 'package:finalyear/AS%20A%20PLAYER/internationalsports/dashboard/setting.dart';
import 'package:finalyear/AS%20A%20PLAYER/internationalsports/dashboard/tournaments.dart';
import 'package:flutter/material.dart';

class dashboard extends StatefulWidget {
  const dashboard({super.key});

  @override
  State<dashboard> createState() => _dashboardState();
}

class _dashboardState extends State<dashboard> {
  int currentIndex = 0;

  final screens =  [
    home(),
    clubs(),
    tournaments(),
    setting(),
    profile(),
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
