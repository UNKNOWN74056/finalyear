class offerrequest {
  String amount;
  bool isApproved;
  String sentby;
  String email;
  offerrequest({
    required this.amount,
    this.isApproved = false,
    required this.sentby,
    required this.email,
  });

  Map<String, dynamic> toJson() {
    return {
      'amount': amount,
      'isApproved': isApproved,
      'sentby': sentby,
      'email': email,
    };
  }

  factory offerrequest.fromJson(Map<String, dynamic> json) {
    return offerrequest(
      amount: json['amount'],
      isApproved: json['isApproved'],
      sentby: json['sentby'],
      email: json['email'],
    );
  }
}
