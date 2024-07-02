import 'package:hustle_house_flutter/model/class.dart';
import 'package:hustle_house_flutter/model/location.dart';
import 'package:hustle_house_flutter/model/trainer.dart';

import 'member_session.dart';

class Schedule {
  int? id;
  String? start;
  int? sportsClassId;
  int? teacherId;
  int? quota;
  String? status;
  int? slotTaken;
  int? price;
  bool? isCancelable;
  SportClass? sportsClass;
  Trainer? teacher;
  Location? location;
  final MemberSession? memberSession;
  dynamic notifyMe;

  Schedule(
      {this.id,
      this.start,
      this.sportsClassId,
      this.teacherId,
      this.quota,
      this.status,
      this.slotTaken,
      this.price,
      this.isCancelable,
      this.sportsClass,
      this.teacher,
      this.location,
      this.memberSession,
      this.notifyMe});

  factory Schedule.fromJson(Map<String, dynamic> json) => Schedule(
      id: json["id"],
      start: json["start"],
      sportsClassId: json["sportsClassID"],
      teacherId: json["teacherID"],
      quota: json["quota"],
      status: json["status"],
      slotTaken: json["slotTaken"],
      price: json["price"],
      isCancelable: json["isCancelable"],
      sportsClass: json["sportsClass"] == null
          ? null
          : SportClass.fromJson(json["sportsClass"]),
      teacher:
          json["teacher"] == null ? null : Trainer.fromJson(json["teacher"]),
      location:
          json["location"] == null ? null : Location.fromJson(json["location"]),
      memberSession: json["memberSession"] == null
          ? null
          : MemberSession.fromJson(json["memberSession"]),
      notifyMe: json["notify_me"]);

  Map<String, dynamic> toJson() => {
        "id": id,
        "start": start,
        "sportsClassID": sportsClassId,
        "teacherID": teacherId,
        "quota": quota,
        "status": status,
        "slotTaken": slotTaken,
        "price": price,
        "isCancelable": isCancelable,
        "sportsClass": sportsClass?.toJson(),
        "teacher": teacher?.toJson(),
        "location": location?.toJson(),
        "memberSession": memberSession?.toJson(),
        "notify_me": notifyMe
      };
}
