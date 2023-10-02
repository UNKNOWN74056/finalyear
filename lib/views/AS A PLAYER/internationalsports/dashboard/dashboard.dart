import 'package:finalyear/views/AS%20A%20PLAYER/internationalsports/dashboard/clubs.dart';
import 'package:finalyear/views/AS%20A%20PLAYER/internationalsports/dashboard/home.dart';
import 'package:finalyear/views/AS%20A%20PLAYER/internationalsports/dashboard/profile.dart';
import 'package:finalyear/views/AS%20A%20PLAYER/internationalsports/dashboard/setting.dart';
import 'package:finalyear/views/AS%20A%20PLAYER/internationalsports/dashboard/tournaments.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class dashboard extends StatefulWidget {
  static const String routname = "dashboard";

  const dashboard({super.key});

  @override
  State<dashboard> createState() => _dashboardState();
}

class _dashboardState extends State<dashboard> {
  int currentIndex = 0;

  final screens = const [
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
