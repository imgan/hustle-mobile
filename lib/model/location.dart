class Location {
  final int? id;
  final String? locationName;

  Location({
    this.id,
    this.locationName,
  });

  factory Location.fromJson(Map<String, dynamic> json) => Location(
    id: json["id"],
    locationName: json["location_name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "location_name": locationName,
  };
}