class PriceGuide {
  final int? id;
  final String? title;
  final int? price;
  final int? creditStart;
  final int? creditEnd;
  final int? expiry;
  final int? isUpTo;

  PriceGuide({
    this.id,
    this.title,
    this.price,
    this.creditStart,
    this.creditEnd,
    this.expiry,
    this.isUpTo,
  });

  factory PriceGuide.fromJson(Map<String, dynamic> json) => PriceGuide(
        id: json["id"],
        title: json["title"],
        price: json["price"],
        creditStart: json["credit_start"],
        creditEnd: json["credit_end"],
        expiry: json["expiry"],
        isUpTo: json["is_up_to"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "price": price,
        "credit_start": creditStart,
        "credit_end": creditEnd,
        "expiry": expiry,
        "is_up_to": isUpTo,
      };
}
