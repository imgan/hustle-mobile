import 'package:hustle_house_flutter/model/sport_class_type.dart';

class SportClass {
  int? id;
  String? name;
  String? description;
  int? quota;
  int? duration;
  String? category;
  int? branchId;
  String? subTitle;
  int? rewardPoints;
  int? loyaltyPoints;
  String? image;
  String? imageUrl;
  String? cancellationPolicy;
  String? prepare;
  int? price;
  List<SportsClassImage>? sportsClassImages;
  SportsClassAsset? sportsClassAsset;
  List<SportsClassType>? sportsClassType;

  SportClass(
      {this.id,
      this.name,
      this.description,
      this.quota,
      this.duration,
      this.category,
      this.branchId,
      this.subTitle,
      this.rewardPoints,
      this.loyaltyPoints,
      this.image,
      this.imageUrl,
      this.sportsClassImages,
      this.sportsClassAsset,
      this.sportsClassType,
      this.cancellationPolicy,
      this.prepare,
      this.price});

  factory SportClass.fromJson(Map<String, dynamic> json) => SportClass(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        quota: json["quota"],
        duration: json["duration"],
        category: json["category"],
        branchId: json["branchID"],
        subTitle: json["subTitle"],
        rewardPoints: json["rewardPoints"],
        loyaltyPoints: json["loyaltyPoints"],
        image: json["image"],
        imageUrl: json["imageUrl"],
        prepare: json["prepare"],
        price: json["price"],
        cancellationPolicy: json["cancellationPolicy"],
        sportsClassImages: json["sportsClassImages"] == null
            ? []
            : List<SportsClassImage>.from(json["sportsClassImages"]!
                .map((x) => SportsClassImage.fromJson(x))),
        sportsClassAsset: json["sportsClassAsset"] == null
            ? null
            : SportsClassAsset.fromJson(json["sportsClassAsset"]),
        sportsClassType: json["sportsClassType"] == null
            ? []
            : List<SportsClassType>.from(json["sportsClassType"]!
                .map((x) => SportsClassType.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "quota": quota,
        "duration": duration,
        "category": category,
        "branchID": branchId,
        "subTitle": subTitle,
        "rewardPoints": rewardPoints,
        "loyaltyPoints": loyaltyPoints,
        "image": image,
        "imageUrl": imageUrl,
        "prepare": prepare,
        "price": price,
        "cancellationPolicy": cancellationPolicy,
        "sportsClassImages": sportsClassImages == null
            ? []
            : List<dynamic>.from(sportsClassImages!.map((x) => x.toJson())),
        "sportsClassAsset": sportsClassAsset?.toJson(),
        "sportsClassType": sportsClassType == null
            ? []
            : List<dynamic>.from(sportsClassType!.map((x) => x.toJson())),
      };
}

class SportsClassAsset {
  int? id;
  String? logo;
  String? fontLogo;
  String? fontLogoColored;
  String? color;
  int? sportsClassId;
  String? logoUrl;
  String? fontLogoUrl;
  String? fontLogoColoredUrl;

  SportsClassAsset({
    this.id,
    this.logo,
    this.fontLogo,
    this.fontLogoColored,
    this.color,
    this.sportsClassId,
    this.logoUrl,
    this.fontLogoUrl,
    this.fontLogoColoredUrl,
  });

  factory SportsClassAsset.fromJson(Map<String, dynamic> json) =>
      SportsClassAsset(
        id: json["id"],
        logo: json["logo"],
        fontLogo: json["fontLogo"],
        fontLogoColored: json["fontLogoColored"],
        color: json["color"],
        sportsClassId: json["sportsClassID"],
        logoUrl: json["logoUrl"],
        fontLogoUrl: json["fontLogoUrl"],
        fontLogoColoredUrl: json["fontLogoColoredUrl"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "logo": logo,
        "fontLogo": fontLogo,
        "fontLogoColored": fontLogoColored,
        "color": color,
        "sportsClassID": sportsClassId,
        "logoUrl": logoUrl,
        "fontLogoUrl": fontLogoUrl,
        "fontLogoColoredUrl": fontLogoColoredUrl,
      };
}

class SportsClassImage {
  int? id;
  String? image;
  int? sportsClassId;
  String? imageUrl;

  SportsClassImage({
    this.id,
    this.image,
    this.sportsClassId,
    this.imageUrl,
  });

  factory SportsClassImage.fromJson(Map<String, dynamic> json) =>
      SportsClassImage(
        id: json["id"],
        image: json["image"],
        sportsClassId: json["sportsClassID"],
        imageUrl: json["imageUrl"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "image": image,
        "sportsClassID": sportsClassId,
        "imageUrl": imageUrl,
      };
}
