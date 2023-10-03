import 'package:finalyear/utils/Routes_Name.dart';
import 'package:finalyear/view_model/splashscreen/splash_screen.dart';
import 'package:finalyear/views/AS%20A%20COACH/culture-sport/Player_Culture_Dashboard.dart';
import 'package:finalyear/views/AS%20A%20COACH/international-sports/Player_International_Dashboard.dart';
import 'package:finalyear/views/AS%20A%20PLAYER/culturesport/Coach_Culture_Dashboard.dart';
import 'package:finalyear/views/AS%20A%20PLAYER/internationalsports/dashboard/Coach_International_Dashboard.dart';
import 'package:finalyear/views/forgotpassword.dart';
import 'package:finalyear/views/loginpage.dart';
import 'package:finalyear/views/signuppage.dart';
import 'package:flutter/material.dart';

class Routes {
  static Route<dynamic> generateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case Routesname.login:
        return MaterialPageRoute(
            builder: (BuildContext context) => const loginpage());
      case Routesname.signup:
        return MaterialPageRoute(
            builder: (BuildContext context) => const signuppage());
      case Routesname.splash_screen:
        return MaterialPageRoute(
            builder: (BuildContext context) => const splashscreen());
      case Routesname.forgotpassword:
        return MaterialPageRoute(
            builder: (BuildContext context) => const forgotpassword());

      //THESE ROUTES ARE FOR COACHES SCREENS
      case Routesname.Coach_International_Dashboard:
        return MaterialPageRoute(
            builder: (BuildContext context) =>
                const Coach_International_Dashboard());
      case Routesname.Coach_Culture_Dashboard:
        return MaterialPageRoute(
            builder: (BuildContext context) => const Coach_culture_Dashboard());

      //THESE ROUTES ARE FOR PLAYER SCREEENS
      case Routesname.Player_International_Dashborad:
        return MaterialPageRoute(
            builder: (BuildContext context) =>
                const Player_International_Dashborad());
      case Routesname.Player_Culture_Dashborad:
        return MaterialPageRoute(
            builder: (BuildContext context) =>
                const Player_Culture_Dashboard());

      default:
        return MaterialPageRoute(builder: (_) {
          return const Scaffold(
            body: Center(child: Text("route doenot define")),
          );
        });
    }
  }
}
