class OrderCredit {
  final int? id;
  final int? orderId;
  final String? nameOrder;
  final int? credit;
  final int? expiry;
  final int? price;
  final int? subtotal;

  OrderCredit({
    this.id,
    this.orderId,
    this.nameOrder,
    this.credit,
    this.expiry,
    this.price,
    this.subtotal,
  });

  factory OrderCredit.fromJson(Map<String, dynamic> json) => OrderCredit(
    id: json["id"],
    orderId: json["orderID"],
    nameOrder: json["name_order"],
    credit: json["credit"],
    expiry: json["expiry"],
    price: json["price"],
    subtotal: json["subtotal"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "orderID": orderId,
    "name_order": nameOrder,
    "credit": credit,
    "expiry": expiry,
    "price": price,
    "subtotal": subtotal,
  };
}