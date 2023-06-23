class offerrequest {
  String amount;
  bool isApproved;
  String sentby;
  offerrequest({
    required this.amount,
    this.isApproved = false,
    required this.sentby,
  });

  Map<String, dynamic> toJson() {
    return {
      'amount': amount,
      'isApproved': isApproved,
      'sentby': sentby,
    };
  }

  factory offerrequest.fromJson(Map<String, dynamic> json) {
    return offerrequest(
        amount: json['amount'],
        isApproved: json['isApproved'],
        sentby: json['sentby']);
  }
}
