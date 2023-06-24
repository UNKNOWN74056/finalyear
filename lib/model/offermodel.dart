class offerrequest {
  String amount;
  bool isApproved;
  String sentby;
  String email;
  String name;
  String profession;
  String sport;
  offerrequest({
    required this.amount,
    this.isApproved = false,
    required this.sentby,
    required this.email,
    required this.name,
    required this.profession,
    required this.sport,
  });

  Map<String, dynamic> toJson() {
    return {
      'amount': amount,
      'isApproved': isApproved,
      'sentby': sentby,
      'email': email,
      'coach': name,
      'profession': profession,
      'sport': sport
    };
  }

  factory offerrequest.fromJson(Map<String, dynamic> json) {
    return offerrequest(
        amount: json['amount'],
        isApproved: json['isApproved'],
        sentby: json['sentby'],
        email: json['email'],
        name: json['coach'],
        profession: json['profession'],
        sport: json['sport']);
  }
}
