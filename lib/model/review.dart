import 'package:hustle_house_flutter/model/rating.dart';

class Review {
  final int? code;
  final bool? status;
  final String? message;
  final double? averageRating;
  final int? totalRatings;
  final List<Rating>? ratings;

  Review(
      {this.code,
      this.status,
      this.message,
      this.averageRating,
      this.totalRatings,
      this.ratings});

  factory Review.fromJson(Map<String, dynamic> json) => Review(
        code: json["code"],
        status: json["status"],
        message: json["message"],
        averageRating: json["average_rating"]?.toDouble(),
        totalRatings: json["total_ratings"],
        ratings: json["ratings"] == null
            ? []
            : List<Rating>.from(
                json["ratings"]!.map((x) => Rating.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "status": status,
        "message": message,
        "average_rating": averageRating,
        "total_ratings": totalRatings,
        "ratings": ratings == null
            ? []
            : List<dynamic>.from(ratings!.map((x) => x.toJson())),
      };
}
