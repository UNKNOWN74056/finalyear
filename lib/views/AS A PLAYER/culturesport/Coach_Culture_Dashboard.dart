import 'package:finalyear/views/AS%20A%20PLAYER/culturesport/culture_home.dart';
import 'package:finalyear/views/AS%20A%20PLAYER/culturesport/culturetournametns.dart';
import 'package:finalyear/views/AS%20A%20PLAYER/internationalsports/dashboard/profile.dart';
import 'package:finalyear/views/AS%20A%20PLAYER/internationalsports/dashboard/setting.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class Coach_culture_Dashboard extends StatefulWidget {
  const Coach_culture_Dashboard({super.key});

  @override
  State<Coach_culture_Dashboard> createState() =>
      _Coach_culture_DashboardState();
}

class _Coach_culture_DashboardState extends State<Coach_culture_Dashboard> {
  int currentIndex = 0;

  final screens = const [
    culturehome(),
    culturetournaments(),
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
