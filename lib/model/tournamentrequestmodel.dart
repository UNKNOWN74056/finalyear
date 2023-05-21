class TournamentRegistrationRequest {
  String teamName;
  String captainName;
  String address;
  String city;
  String contactEmail;
  bool isApproved;

  TournamentRegistrationRequest({
    required this.teamName,
    required this.captainName,
    required this.address,
    required this.city,
    required this.contactEmail,
    this.isApproved = false,
  });

  Map<String, dynamic> toJson() {
    return {
      'teamName': teamName,
      'captainName': captainName,
      'address': address,
      'city': city,
      'contactEmail': contactEmail,
      'isApproved': isApproved,
    };
  }

  factory TournamentRegistrationRequest.fromJson(Map<String, dynamic> json) {
    return TournamentRegistrationRequest(
      teamName: json['teamName'],
      captainName: json['captainName'],
      address: json['address'],
      city: json['city'],
      contactEmail: json['contactEmail'],
      isApproved: json['isApproved'],
    );
  }
}
