import 'package:hustle_house_flutter/model/class.dart';
import 'package:hustle_house_flutter/model/location.dart';
import 'package:hustle_house_flutter/model/trainer.dart';
import 'package:intl/intl.dart';

import 'member_session.dart';

class ClassDetail {
  final int? id;
  final String? start;
  final int? sportsClassId;
  final int? teacherId;
  final int? locationId;
  final int? quota;
  final String? status;
  final int? slotTaken;
  final int? price;
  final bool? isCancelable;
  final SportClass? sportsClass;
  final Trainer? teacher;
  final Location? location;
  final MemberSession? memberSession;

  ClassDetail(
      {this.id,
      this.start,
      this.sportsClassId,
      this.teacherId,
      this.locationId,
      this.quota,
      this.status,
      this.slotTaken,
      this.price,
      this.isCancelable,
      this.sportsClass,
      this.teacher,
      this.location,
      this.memberSession});

  String getDateSchedule() {
    try {
      final date = DateTime.parse(start ?? '');
      final DateFormat formatter = DateFormat.EEEE();
      final DateFormat dateFormat = DateFormat('dd MMMM yyyy');
      final DateFormat hourFormat = DateFormat('HH:mm');
      return '${formatter.format(date)}, ${dateFormat.format(date)} • ${hourFormat.format(date)}';
    } catch (e) {
      return '';
    }
  }

  String getHour() {
    final date = DateTime.parse(start ?? '');
    final DateFormat hourFormat = DateFormat('HH:mm');
    return hourFormat.format(date);
  }

  String getDate() {
    final date = DateTime.parse(start ?? '');
    final DateFormat formatter = DateFormat.EEEE();
    final DateFormat dateFormat = DateFormat('dd MMMM yyyy');
    return '${formatter.format(date)}, ${dateFormat.format(date)}';
  }

  factory ClassDetail.fromJson(Map<String, dynamic> json) => ClassDetail(
        id: json["id"],
        start: json["start"],
        sportsClassId: json["sportsClassID"],
        teacherId: json["teacherID"],
        locationId: json["location_id"],
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
        location: json["location"] == null
            ? null
            : Location.fromJson(json["location"]),
        memberSession: json["memberSession"] == null
            ? null
            : MemberSession.fromJson(json["memberSession"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "start": start,
        "sportsClassID": sportsClassId,
        "teacherID": teacherId,
        "location_id": locationId,
        "quota": quota,
        "status": status,
        "slotTaken": slotTaken,
        "price": price,
        "isCancelable": isCancelable,
        "sportsClass": sportsClass?.toJson(),
        "teacher": teacher?.toJson(),
        "location": location?.toJson(),
        "memberSession": memberSession?.toJson(),
      };
}
