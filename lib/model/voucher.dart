import 'package:hustle_house_flutter/model/reward_voucher.dart';

class Voucher {
  final int? id;
  final String? code;
  final int? memberId;
  final int? rvId;
  final String? expired;
  final String? category;
  final String? name;
  final String? description;
  int? totalVoucher;
  String? transactionDate;
  final RewardVoucher? rewardVoucher;
  final List<dynamic>? packages;
  final List<dynamic>? credits;

  Voucher({this.id,
    this.code,
    this.memberId,
    this.rvId,
    this.expired,
    this.category,
    this.name,
    this.description,
    this.totalVoucher = 1,
    this.rewardVoucher,
    this.transactionDate,
    this.packages,
    this.credits});

  factory Voucher.fromJson(Map<String, dynamic> json) =>
      Voucher(
          id: json["id"],
          code: json["code"],
          memberId: json["memberID"],
          rvId: json["rvID"],
          expired: json["expired"],
          category: json["category"],
          name: json["name"],
          description: json["description"],
          transactionDate: json["transactionDate"],
          rewardVoucher: json["rewardVoucher"] == null
              ? null
              : RewardVoucher.fromJson(json["rewardVoucher"]),
          packages: json["packages"],
          credits: json["credits"]);

  Map<String, dynamic> toJson() =>
      {
        "id": id,
        "code": code,
        "memberID": memberId,
        "rvID": rvId,
        "expired": expired,
        "category": category,
        "name": name,
        "description": description,
        "transactionDate": transactionDate,
        "rewardVoucher": rewardVoucher?.toJson(),
        "packages": packages,
        "credits": credits
      };
}
