import 'package:finalyear/AS%20A%20PLAYER/internationalsports/dashboard/profile.dart';
class TournamentRegistrationRequest {
  String teamName;
  String captainName;
  String address;
  String city;
  String contactEmail;
  String sportevent;
  String contact;
  String player1;
  String player2;
  String player3;
  String player4;
  String player5;
  String player6;
  String player7;
  String player8;
  String player9;
  String player10;
  String player11;
  String player12;
  bool isApproved;
  String sentby;

  TournamentRegistrationRequest({
    required this.teamName,
    required this.captainName,
    required this.address,
    required this.city,
    required this.contactEmail,
    required this.sportevent,
    required this.contact,
    required this.player1,
    required this.player2,
    required this.player3,
    required this.player4,
    required this.player5,
    required this.player6,
    required this.player7,
    required this.player8,
    required this.player9,
    required this.player10,
    required this.player11,
    required this.player12,
    this.isApproved = false,
    required this.sentby,
  });

  Map<String, dynamic> toJson() {
    return {
      'teamName': teamName,
      'captainName': captainName,
      'address': address,
      'city': city,
      'contactEmail': contactEmail,
      'sportevent': sportevent,
      'contact': contact,
      'player1': player1,
      'player2': player2,
      'player3': player3,
      'player4': player4,
      'player5': player4,
      'player6': player6,
      'player7': player7,
      'player8': player8,
      'player9': player9,
      'player10': player10,
      'player11': player11,
      'isApproved': isApproved,
      'email' : sentby,
    };
  }

  factory TournamentRegistrationRequest.fromJson(Map<String, dynamic> json) {
    return TournamentRegistrationRequest(
      teamName: json['teamName'],
      captainName: json['captainName'],
      address: json['address'],
      city: json['city'],
      contactEmail: json['contactEmail'],
      sportevent: json['sportevent'],
      contact: json['contact'],
      player1: json['player1'],
      player2: json['player2'],
      player3: json['player3'],
      player4: json['player4'],
      player5: json['player5'],
      player6: json['player6'],
      player7: json['player7'],
      player8: json['player8'],
      player9: json['player9'],
      player10: json['player10'],
      player11: json['player11'],
      player12: json['player12'],
      isApproved: json['isApproved'],
      sentby: json['email']
    );
  }
}
