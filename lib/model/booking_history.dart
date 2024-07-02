import 'package:hustle_house_flutter/model/class.dart';
import 'package:hustle_house_flutter/model/location.dart';
import 'package:hustle_house_flutter/model/trainer.dart';

class BookingHistory {
  int? id;
  int? memberPackageId;
  int? sessionId;
  String? status;
  DateTime? createdAt;
  int? memberId;
  double? averageRating;
  bool? isCancelable;
  Session? session;
  bool? isUserComment;

  BookingHistory({
    this.id,
    this.memberPackageId,
    this.sessionId,
    this.status,
    this.createdAt,
    this.memberId,
    this.averageRating,
    this.isCancelable,
    this.session,
    this.isUserComment,
  });

  factory BookingHistory.fromJson(Map<String, dynamic> json) => BookingHistory(
      id: json["id"],
      memberPackageId: json["memberPackageID"],
      sessionId: json["sessionID"],
      status: json["status"],
      createdAt: DateTime.parse(json["createdAt"]),
      memberId: json["memberID"],
      averageRating: json["averageRating"]?.toDouble(),
      isCancelable: json["isCancelable"],
      session: Session.fromJson(json["session"]),
      isUserComment: json["isUserComment"]);

  Map<String, dynamic> toJson() => {
        "id": id,
        "memberPackageID": memberPackageId,
        "sessionID": sessionId,
        "status": status,
        "createdAt": createdAt?.toIso8601String(),
        "memberID": memberId,
        "averageRating": averageRating,
        "isCancelable": isCancelable,
        "session": session?.toJson(),
        "isUserComment": isUserComment
      };
}

class Session {
  int? id;
  DateTime? start;
  int? sportsClassId;
  int? teacherId;
  int? locationId;
  int? price;
  String? category;
  int? quota;
  int? slotTaken;
  String? endTime;
  bool? isCancelable;
  SportClass? sportsClass;
  Location? location;
  Trainer? teacher;

  Session({
    this.id,
    this.start,
    this.sportsClassId,
    this.teacherId,
    this.locationId,
    this.price,
    this.category,
    this.quota,
    this.slotTaken,
    this.endTime,
    this.isCancelable,
    this.sportsClass,
    this.location,
    this.teacher,
  });

  factory Session.fromJson(Map<String, dynamic> json) => Session(
        id: json["id"],
        start: DateTime.parse(json["start"]),
        sportsClassId: json["sportsClassID"],
        teacherId: json["teacherID"],
        locationId: json["location_id"],
        price: json["price"],
        category: json["category"],
        quota: json["quota"],
        slotTaken: json["slotTaken"],
        endTime: json["endTime"],
        isCancelable: json["isCancelable"],
        sportsClass: json["sportsClass"] == null
            ? null
            : SportClass.fromJson(json["sportsClass"]),
        location: json['location'] == null
            ? null
            : Location.fromJson(json["location"]),
        teacher: Trainer.fromJson(json["teacher"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "start": start?.toIso8601String(),
        "sportsClassID": sportsClassId,
        "teacherID": teacherId,
        "location_id": locationId,
        "price": price,
        "category": category,
        "quota": quota,
        "slotTaken": slotTaken,
        "endTime": endTime,
        "isCancelable": isCancelable,
        "sportsClass": sportsClass?.toJson(),
        "location": location?.toJson(),
        "teacher": teacher?.toJson(),
      };
}
