class Package {
  final int? id;
  final String? name;
  final int? credit;
  final int? price;
  final int? expiry;
  final String? start;
  final String? end;
  final int? shareable;
  final int? firstTimeOnly;
  final int? pricePerItem;
  final String? imageUrl;
  final String? packagePolicy;
  final String? description;

  Package(
      {this.id,
      this.name,
      this.credit,
      this.price,
      this.expiry,
      this.start,
      this.end,
      this.shareable,
      this.firstTimeOnly,
      this.pricePerItem,
      this.imageUrl,
      this.packagePolicy,
      this.description});

  factory Package.fromJson(Map<String, dynamic> json) => Package(
      id: json["id"],
      name: json["name"],
      credit: json["credit"],
      price: json["price"],
      expiry: json["expiry"],
      start: json["start"],
      end: json["end"],
      shareable: json["shareable"],
      firstTimeOnly: json["firstTimeOnly"],
      pricePerItem: json["pricePerItem"],
      imageUrl: json["imageUrl"],
      packagePolicy: json["package_policy"],
      description: json["description"]);

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "credit": credit,
        "price": price,
        "expiry": expiry,
        "start": start,
        "end": end,
        "shareable": shareable,
        "firstTimeOnly": firstTimeOnly,
        "pricePerItem": pricePerItem,
        "imageUrl": imageUrl,
        "package_policy": packagePolicy,
        "description": description
      };
}
