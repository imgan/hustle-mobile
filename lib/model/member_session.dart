class MemberSession {
  final int? id;
  final int? memberPackageId;
  final int? sessionId;
  final String? status;
  final int? memberId;
  final bool? isCancelable;

  MemberSession({
    this.id,
    this.memberPackageId,
    this.sessionId,
    this.status,
    this.memberId,
    this.isCancelable,
  });

  factory MemberSession.fromJson(Map<String, dynamic> json) => MemberSession(
    id: json["id"],
    memberPackageId: json["memberPackageID"],
    sessionId: json["sessionID"],
    status: json["status"],
    memberId: json["memberID"],
    isCancelable: json["isCancelable"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "memberPackageID": memberPackageId,
    "sessionID": sessionId,
    "status": status,
    "memberID": memberId,
    "isCancelable": isCancelable,
  };
}