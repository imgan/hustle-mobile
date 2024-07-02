class RewardVoucher {
  final int? id;
  final String? name;
  final int? value;
  final int? rewardPoints;
  final String? image;
  final String? description;
  final String? expired;
  final int? isPercentage;
  final String? imageUrl;
  final int? locationID;
  final String? code;

  RewardVoucher(
      {this.id,
      this.name,
      this.value,
      this.rewardPoints,
      this.image,
      this.description,
      this.expired,
      this.isPercentage,
      this.imageUrl,
      this.locationID,
      this.code});

  factory RewardVoucher.fromJson(Map<String, dynamic> json) => RewardVoucher(
      id: json["id"],
      name: json["name"],
      value: json["value"],
      rewardPoints: json["rewardPoints"],
      image: json["image"],
      description: json["description"],
      expired: json["expired"],
      isPercentage: json["isPercentage"],
      imageUrl: json["imageUrl"],
      locationID: json["locationID"],
      code: json["code"]);

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "value": value,
        "rewardPoints": rewardPoints,
        "image": image,
        "description": description,
        "expired": expired,
        "isPercentage": isPercentage,
        "imageUrl": imageUrl,
        "locationID": locationID,
        "code": code
      };
}
