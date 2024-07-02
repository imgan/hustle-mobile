class Rating {
  final int? rating;
  final int? count;
  final double? percentage;

  Rating({
    this.rating,
    this.count,
    this.percentage,
  });

  factory Rating.fromJson(Map<String, dynamic> json) => Rating(
        rating: json["rating"],
        count: json["count"],
        percentage: json["percentage"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "rating": rating,
        "count": count,
        "percentage": percentage,
      };
}
