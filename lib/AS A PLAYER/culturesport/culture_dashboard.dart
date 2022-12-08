import 'package:finalyear/AS%20A%20PLAYER/culturesport/culture_home.dart';
import 'package:finalyear/AS%20A%20PLAYER/culturesport/culturetournametns.dart';
import 'package:finalyear/AS%20A%20PLAYER/internationalsports/dashboard/profile.dart';
import 'package:finalyear/AS%20A%20PLAYER/internationalsports/dashboard/setting.dart';
import 'package:flutter/material.dart';

class culturedashboard extends StatefulWidget {
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
            selectedItemColor: Colors.blue,
            unselectedItemColor: Colors.black87,
            currentIndex: currentIndex,
            onTap: (value) => setState(() => currentIndex = value),
            items: const [
              BottomNavigationBarItem(
                backgroundColor: Color.fromARGB(255, 28, 32, 47),
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
