import 'package:hustle_house_flutter/model/teacher_specialization_name.dart';

class TeacherSpecialization {
  final int? id;
  final int? teacherId;
  final int? specializationId;
  final TeacherSpecializationName? teacherSpecializationName;

  TeacherSpecialization(
      {this.id,
      this.teacherId,
      this.specializationId,
      this.teacherSpecializationName});

  factory TeacherSpecialization.fromJson(Map<String, dynamic> json) =>
      TeacherSpecialization(
        id: json["id"],
        teacherId: json["teacherId"],
        specializationId: json["specializationId"],
        teacherSpecializationName: json["teacherSpecialization"] == null
            ? null
            : TeacherSpecializationName.fromJson(json["teacherSpecialization"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "teacherId": teacherId,
        "specializationId": specializationId,
        "teacherSpecialization": teacherSpecializationName?.toJson(),
      };
}
