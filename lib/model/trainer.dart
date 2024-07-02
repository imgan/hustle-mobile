import 'package:hustle_house_flutter/model/location.dart';
import 'package:hustle_house_flutter/model/teacher_specialization.dart';

class Trainer {
  int? id;
  String? firstName;
  String? lastName;
  String? imageUrl;
  int? rewardPoint;
  String? about;
  int? price;
  int? duration;
  Location? location;
  int? rewardPoints;
  final List<TeacherSpecialization>? teacherSpecialization;

  Trainer(
      {this.id,
      this.firstName,
      this.lastName,
      this.imageUrl,
      this.rewardPoint,
      this.about,
      this.price,
      this.duration,
      this.location,
      this.rewardPoints,
      this.teacherSpecialization});

  factory Trainer.fromJson(Map<String, dynamic> json) => Trainer(
        id: json["id"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        imageUrl: json["imageUrl"],
        rewardPoint: json["rewardPoints"],
        about: json["about"],
        price: json["price"],
        duration: json["duration"],
        location: json["location"] == null
            ? null
            : Location.fromJson(json["location"]),
        rewardPoints: json["rewardPoints"],
        teacherSpecialization: json["teacherSpecialization"] == null
            ? []
            : List<TeacherSpecialization>.from(json["teacherSpecialization"]!
                .map((x) => TeacherSpecialization.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "firstName": firstName,
        "lastName": lastName,
        "imageUrl": imageUrl,
        "rewardPoints": rewardPoint,
        "about": about,
        "price": price,
        "duration": duration,
        "location": location?.toJson(),
        "teacherSpecialization": teacherSpecialization == null
            ? []
            : List<dynamic>.from(teacherSpecialization!.map((x) => x.toJson())),
      };
}
