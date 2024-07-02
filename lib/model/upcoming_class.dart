import 'dart:convert';

import 'package:hustle_house_flutter/model/booking_history.dart';

class UpcomingClass {
  int? id;
  int? memberPackageId;
  int? sessionId;
  String? status;
  int? memberId;
  bool? isCancelable;
  Session? session;

  UpcomingClass({
    this.id,
    this.memberPackageId,
    this.sessionId,
    this.status,
    this.memberId,
    this.isCancelable,
    this.session,
  });

  factory UpcomingClass.fromRawJson(String str) =>
      UpcomingClass.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UpcomingClass.fromJson(Map<String, dynamic> json) => UpcomingClass(
        id: json["id"],
        memberPackageId: json["memberPackageID"],
        sessionId: json["sessionID"],
        status: json["status"],
        memberId: json["memberID"],
        isCancelable: json["isCancelable"],
        session: Session.fromJson(json["session"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "memberPackageID": memberPackageId,
        "sessionID": sessionId,
        "status": status,
        "memberID": memberId,
        "isCancelable": isCancelable,
        "session": session?.toJson(),
      };
}
