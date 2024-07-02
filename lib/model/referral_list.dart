import 'package:hustle_house_flutter/model/user_profile.dart';

class Referrer {
  int? referrerId;
  int? memberId;
  String? createdAt;
  dynamic isActive;
  Member? member;

  Referrer({
    this.referrerId,
    this.memberId,
    this.createdAt,
    this.isActive,
    this.member,
  });

  factory Referrer.fromJson(Map<String, dynamic> json) => Referrer(
        referrerId: json["referrerID"],
        memberId: json["memberID"],
        createdAt: json["createdAt"],
        isActive: json["isActive"],
        member: json["member"] == null ? null : Member.fromJson(json["member"]),
      );

  Map<String, dynamic> toJson() => {
        "referrerID": referrerId,
        "memberID": memberId,
        "createdAt": createdAt,
        "isActive": isActive,
        "member": member?.toJson(),
      };
}
