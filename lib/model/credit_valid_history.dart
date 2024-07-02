import 'dart:convert';

class CreditHistory {
  int? id;
  int? memberId;
  int? credit;
  DateTime? expired;
  String? name;
  String? transactionDate;
  int? price;
  String? status;

  CreditHistory({
    this.id,
    this.memberId,
    this.credit,
    this.expired,
    this.name,
    this.transactionDate,
    this.price,
    this.status,
  });

  factory CreditHistory.fromRawJson(String str) =>
      CreditHistory.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CreditHistory.fromJson(Map<String, dynamic> json) => CreditHistory(
        id: json["id"],
        memberId: json["memberID"],
        credit: json["credit"],
        expired:
            json["expired"] == null ? null : DateTime.parse(json["expired"]),
        name: json["name"],
        transactionDate: json["transactionDate"],
        price: json["price"],
        status: json["status"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "memberID": memberId,
        "credit": credit,
        "expired":
            "${expired!.year.toString().padLeft(4, '0')}-${expired!.month.toString().padLeft(2, '0')}-${expired!.day.toString().padLeft(2, '0')}",
        "name": name,
        "transactionDate": transactionDate,
        "price": price,
        "status": status,
      };
}
