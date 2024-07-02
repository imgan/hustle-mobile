import 'dart:convert';

class ReferralCode {
  int? code;
  bool? status;
  String? message;
  String? data;

  ReferralCode({
    this.code,
    this.status,
    this.message,
    this.data,
  });

  factory ReferralCode.fromRawJson(String str) =>
      ReferralCode.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ReferralCode.fromJson(Map<String, dynamic> json) => ReferralCode(
        code: json["code"],
        status: json["status"],
        message: json["message"],
        data: json["data"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "status": status,
        "message": message,
        "data": data,
      };
}
