class NotificationModel {
  final int? id;
  final int? memberId;
  final int? sportsClassId;
  final int? teacherId;
  final String? name;
  final String? description;
  final int? isRead;
  final String? notifType;
  final String? link;
  final String? createdAt;
  final int? sessionID;
  final String? category;

  NotificationModel(
      {this.id,
      this.memberId,
      this.sportsClassId,
      this.teacherId,
      this.name,
      this.description,
      this.isRead,
      this.notifType,
      this.link,
      this.createdAt,
      this.sessionID,
      this.category});

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      NotificationModel(
          id: json["id"],
          memberId: json["memberID"],
          sportsClassId: json["sportsClassID"],
          teacherId: json["teacherID"],
          name: json["name"],
          description: json["description"],
          isRead: json["is_read"],
          notifType: json["notif_type"],
          link: json["link"],
          createdAt: json["createdAt"],
          sessionID: json["sessionID"],
          category: json["category"]);

  Map<String, dynamic> toJson() => {
        "id": id,
        "memberID": memberId,
        "sportsClassID": sportsClassId,
        "teacherID": teacherId,
        "name": name,
        "description": description,
        "is_read": isRead,
        "notif_type": notifType,
        "link": link,
        "createdAt": createdAt,
        "sessionID": sessionID,
        "category": category
      };
}
