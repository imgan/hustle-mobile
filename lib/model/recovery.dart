import 'package:hustle_house_flutter/model/class.dart';
import 'package:intl/intl.dart';

class Recovery {
  final String? title;
  final String? image;
  final int? sessionId;
  final int? id;
  final String? name;
  final String? description;
  final int? quota;
  final int? duration;
  final String? sportType;
  final String? category;
  final int? branchId;
  final String? subTitle;
  final int? rewardPoints;
  final int? loyaltyPoints;
  final String? cancellationPolicy;
  final String? prepare;
  final String? locationName;
  final String? createdAt;
  final List<SportsClassAsset>? sportsClassAssets;
  final SportsClassAsset? assets;
  List<SportsClassImage>? sportsClassImages;

  Recovery(
      {this.title,
      this.image,
      this.sessionId,
      this.id,
      this.name,
      this.description,
      this.quota,
      this.duration,
      this.sportType,
      this.category,
      this.branchId,
      this.subTitle,
      this.rewardPoints,
      this.createdAt,
      this.loyaltyPoints,
      this.cancellationPolicy,
      this.prepare,
      this.locationName,
      this.sportsClassAssets,
      this.sportsClassImages,
      this.assets});

  Map<String, List<String>> getScheduleTimes() {
    switch (name?.toLowerCase()) {
      case 'ice bath':
        return {
          'Morning':
              generateTimeList('06:00', '12:10', const Duration(minutes: 10)),
          'Afternoon':
              generateTimeList('12:00', '18:10', const Duration(minutes: 10)),
          'Evening':
              generateTimeList('18:00', '24:10', const Duration(minutes: 10)),
        };
      case 'normatec':
        return {
          'Morning':
              generateTimeList('06:00', '12:30', const Duration(minutes: 30)),
          'Afternoon':
              generateTimeList('12:00', '18:30', const Duration(minutes: 30)),
          'Evening':
              generateTimeList('18:00', '24:30', const Duration(minutes: 30)),
        };
      case 'sports massage':
        return {
          'Morning':
              generateTimeList('06:00', '13:00', const Duration(minutes: 60)),
          'Afternoon':
              generateTimeList('12:00', '19:00', const Duration(minutes: 60)),
          'Evening':
              generateTimeList('18:00', '25:00', const Duration(minutes: 60)),
        };
      default:
        return {};
    }
  }

  List<String> generateTimeList(
      String startTime, String endTime, Duration step) {
    DateFormat timeFormat = DateFormat('HH:mm');
    DateTime currentTime = timeFormat.parse(startTime);
    DateTime endTimeParsed = timeFormat.parse(endTime);

    List<String> timeList = [];

    while (currentTime.isBefore(endTimeParsed)) {
      String formattedTime = timeFormat.format(currentTime);
      timeList.add(formattedTime);
      currentTime = currentTime.add(step);
    }

    return timeList;
  }

  String getDateSchedule() {
    final date = DateTime.parse(createdAt ?? '');
    final DateFormat formatter = DateFormat.EEEE();
    final DateFormat dateFormat = DateFormat('dd MMMM yyyy');
    final DateFormat hourFormat = DateFormat('hh:mm');
    return '${formatter.format(date)}, ${dateFormat.format(date)} • ${hourFormat.format(date)}';
  }

  factory Recovery.fromJson(Map<String, dynamic> json) => Recovery(
        sessionId: json["sessionId"],
        id: json["id"],
        name: json["name"],
        description: json["description"],
        quota: json["quota"],
        duration: json["duration"],
        sportType: json["sport_type"],
        category: json["category"],
        branchId: json["branchID"],
        subTitle: json["subTitle"],
        createdAt: json["createdAt"],
        rewardPoints: json["rewardPoints"],
        loyaltyPoints: json["loyaltyPoints"],
        cancellationPolicy: json["cancellationPolicy"],
        prepare: json["prepare"],
        locationName: json["location_name"],
        sportsClassAssets: json["sports_class_assets"] == null
            ? []
            : List<SportsClassAsset>.from(json["sports_class_assets"]!
                .map((x) => SportsClassAsset.fromJson(x))),
        assets: json["assets"] == null
            ? null
            : SportsClassAsset.fromJson(json["assets"]),
        sportsClassImages: json["sportsClassImages"] == null
            ? []
            : List<SportsClassImage>.from(json["sportsClassImages"]!
                .map((x) => SportsClassImage.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "sessionId": sessionId,
        "id": id,
        "name": name,
        "description": description,
        "quota": quota,
        "duration": duration,
        "createdAt": createdAt,
        "sport_type": sportType,
        "category": category,
        "branchID": branchId,
        "subTitle": subTitle,
        "rewardPoints": rewardPoints,
        "loyaltyPoints": loyaltyPoints,
        "cancellationPolicy": cancellationPolicy,
        "prepare": prepare,
        "location_name": locationName,
        "sports_class_assets": sportsClassAssets == null
            ? []
            : List<dynamic>.from(sportsClassAssets!.map((x) => x.toJson())),
        "assets": assets?.toJson(),
        "sportsClassImages": sportsClassImages == null
            ? []
            : List<dynamic>.from(sportsClassImages!.map((x) => x.toJson()))
      };
}
