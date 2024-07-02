class TeacherSpecializationName {
  final String? name;

  TeacherSpecializationName({
    this.name,
  });

  factory TeacherSpecializationName.fromJson(Map<String, dynamic> json) =>
      TeacherSpecializationName(
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
      };
}
