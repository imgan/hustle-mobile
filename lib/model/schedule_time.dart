import 'member_session.dart';

class ScheduleTime {
  final int? id;
  final String? startTime;
  final String? category;
  final String? status;
  final dynamic notifyMe;
  final MemberSession? memberSession;

  ScheduleTime(
      {this.id,
      this.startTime,
      this.category,
      this.status,
      this.memberSession,
      this.notifyMe});

  factory ScheduleTime.fromJson(Map<String, dynamic> json) => ScheduleTime(
      id: json["id"],
      startTime: json["start_time"],
      category: json["category"],
      status: json["status"],
      memberSession: json["memberSession"] == null
          ? null
          : MemberSession.fromJson(json["memberSession"]),
      notifyMe: json["notify_me"]);

  Map<String, dynamic> toJson() => {
        "id": id,
        "start_time": startTime,
        "category": category,
        "status": status,
        "memberSession": memberSession?.toJson(),
        "notify_me": notifyMe
      };
}
