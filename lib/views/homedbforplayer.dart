import 'package:finalyear/utils/Routes_Name.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class homeforplayer extends StatefulWidget {
  const homeforplayer({super.key});

  @override
  State<homeforplayer> createState() => _homeforplayerState();
}

class _homeforplayerState extends State<homeforplayer> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: () async {
          SystemNavigator.pop();
          return true;
        },
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Sports'),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                          context, Routesname.Player_International_Dashborad);
                    },
                    child: Container(
                      margin: const EdgeInsets.only(bottom: 16.0),
                      height: 200,
                      decoration: BoxDecoration(
                        image: const DecorationImage(
                          image: AssetImage('assets/interna.jpeg'),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Center(
                        child: Text(
                          'International Sports',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                          context, Routesname.Player_Culture_Dashborad);
                    },
                    child: Container(
                      height: 200,
                      decoration: BoxDecoration(
                        image: const DecorationImage(
                          image: AssetImage('assets/culture.jpeg'),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Center(
                        child: Text(
                          'Culture Sports',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
