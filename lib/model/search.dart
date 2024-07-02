class Search {
  final int? id;
  final String? name;
  final String? category;
  final int? price;

  Search({
    this.id,
    this.name,
    this.category,
    this.price,
  });

  factory Search.fromJson(Map<String, dynamic> json) => Search(
        id: json["id"],
        name: json["name"],
        category: json["category"],
        price: json["price"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "category": category,
        "price": price,
      };
}
