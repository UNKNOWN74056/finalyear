import 'package:finalyear/AS%20A%20PLAYER/culturesport/culture_home.dart';
import 'package:finalyear/AS%20A%20PLAYER/culturesport/culturetournametns.dart';
import 'package:finalyear/AS%20A%20PLAYER/internationalsports/dashboard/profile.dart';
import 'package:finalyear/AS%20A%20PLAYER/internationalsports/dashboard/setting.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';

class culturedashboard extends StatefulWidget {
  static const String routname = "culturedashboard";
  const culturedashboard({super.key});

  @override
  State<culturedashboard> createState() => _culturedashboardState();
}

class _culturedashboardState extends State<culturedashboard> {
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
