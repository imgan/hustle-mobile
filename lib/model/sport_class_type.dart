class SportsClassType {
  final int? id;
  final String? image;
  final int? sportsClassId;
  final String? imageUrl;
  final String? name;

  SportsClassType({
    this.id,
    this.image,
    this.sportsClassId,
    this.imageUrl,
    this.name,
  });

  factory SportsClassType.fromJson(Map<String, dynamic> json) => SportsClassType(
    id: json["id"],
    image: json["image"],
    sportsClassId: json["sportsClassID"],
    imageUrl: json["imageUrl"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "image": image,
    "sportsClassID": sportsClassId,
    "imageUrl": imageUrl,
    "name": name,
  };
}