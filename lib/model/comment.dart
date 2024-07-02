class Comment {
  final int? id;
  final String? firstName;
  final String? lastName;
  final int? memberId;
  final String? createdAt;
  final dynamic starRating;
  final String? comments;

  Comment({
    this.id,
    this.firstName,
    this.lastName,
    this.memberId,
    this.createdAt,
    this.starRating,
    this.comments,
  });

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
        id: json["id"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        memberId: json["memberID"],
        createdAt: json["createdAt"],
        starRating: json["star_rating"],
        comments: json["comments"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "firstName": firstName,
        "lastName": lastName,
        "memberID": memberId,
        "createdAt": createdAt,
        "star_rating": starRating,
        "comments": comments,
      };
}
