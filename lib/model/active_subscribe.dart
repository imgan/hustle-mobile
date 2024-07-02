class ActiveSubscribe {
  final int? id;
  final int? memberId;
  final int? credit;
  final String? expired;
  final String? anotherName;

  ActiveSubscribe({
    this.id,
    this.memberId,
    this.credit,
    this.expired,
    this.anotherName,
  });

  factory ActiveSubscribe.fromJson(Map<String, dynamic> json) =>
      ActiveSubscribe(
        id: json["id"],
        memberId: json["memberID"],
        credit: json["credit"],
        expired: json["expired"],
        anotherName: json["anotherName"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "memberID": memberId,
        "credit": credit,
        "expired": expired,
        "anotherName": anotherName,
      };
}
