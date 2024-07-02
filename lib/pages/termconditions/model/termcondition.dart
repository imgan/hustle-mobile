class TermConditionData {
  final int id;
  final String title1;
  final String description1;
  final String title2;
  final String description2;

  TermConditionData({
    required this.id,
    required this.title1,
    required this.description1,
    required this.title2,
    required this.description2,
  });

  factory TermConditionData.fromJson(Map<String, dynamic> json) {
    return TermConditionData(
      id: json['id'],
      title1: json['title_1'],
      description1: json['description_1'],
      title2: json['title_2'],
      description2: json['description_2'],
    );
  }
}
