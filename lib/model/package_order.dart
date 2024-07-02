import 'package:hustle_house_flutter/model/package_first_timer.dart';

class PackageOrder {
  final int? id;
  final int? packageId;
  final int? orderId;
  final int? quantity;
  final Package? package;

  PackageOrder({
    this.id,
    this.packageId,
    this.orderId,
    this.quantity,
    this.package,
  });

  factory PackageOrder.fromJson(Map<String, dynamic> json) => PackageOrder(
        id: json["id"],
        packageId: json["packageID"],
        orderId: json["orderID"],
        quantity: json["quantity"],
        package:
            json["package"] == null ? null : Package.fromJson(json["package"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "packageID": packageId,
        "orderID": orderId,
        "quantity": quantity,
        "package": package?.toJson(),
      };
}
