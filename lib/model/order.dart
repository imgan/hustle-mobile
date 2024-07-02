import 'package:hustle_house_flutter/model/package_order.dart';

import 'order_credit.dart';

class Order {
  final int? id;
  final int? memberId;
  final String? code;
  final int? isCart;
  final int? subTotal;
  final int? totalDiscount;
  final int? total;
  final List<PackageOrder>? packages;
  final List<OrderCredit>? orderCredit;

  Order({
    this.id,
    this.memberId,
    this.code,
    this.isCart,
    this.subTotal,
    this.totalDiscount,
    this.total,
    this.packages,
    this.orderCredit,
  });

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        id: json["id"],
        memberId: json["memberID"],
        code: json["code"],
        isCart: json["isCart"],
        subTotal: json["subTotal"],
        totalDiscount: json["totalDiscount"],
        total: json["total"],
        packages: json["packages"] == null
            ? []
            : List<PackageOrder>.from(
                json["packages"]!.map((x) => PackageOrder.fromJson(x))),
        orderCredit: json["order_credit"] == null
            ? []
            : List<OrderCredit>.from(
                json["order_credit"]!.map((x) => OrderCredit.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "memberID": memberId,
        "code": code,
        "isCart": isCart,
        "subTotal": subTotal,
        "totalDiscount": totalDiscount,
        "total": total,
        "packages": packages == null
            ? []
            : List<dynamic>.from(packages!.map((x) => x.toJson())),
        "order_credit": orderCredit == null
            ? []
            : List<dynamic>.from(orderCredit!.map((x) => x.toJson())),
      };
}
