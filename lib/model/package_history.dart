class PackageHistory {
  int? id;
  int? memberId;
  int? credit;
  DateTime? expired;
  String? package;
  String? description;
  String? transactionDate;
  int? price;
  String? status;
  int? packageId;

  PackageHistory(
      {this.id,
      this.memberId,
      this.credit,
      this.expired,
      this.package,
      this.description,
      this.transactionDate,
      this.price,
      this.status,
      this.packageId});

  factory PackageHistory.fromJson(Map<String, dynamic> json) => PackageHistory(
      id: json["id"],
      memberId: json["memberID"],
      credit: json["credit"],
      expired: json["expired"] == null ? null : DateTime.parse(json["expired"]),
      package: json["package"],
      description: json["description"],
      transactionDate: json["transactionDate"],
      price: json["price"],
      status: json["status"],
      packageId: json["package_id"]);

  Map<String, dynamic> toJson() => {
        "id": id,
        "memberID": memberId,
        "credit": credit,
        "expired":
            "${expired!.year.toString().padLeft(4, '0')}-${expired!.month.toString().padLeft(2, '0')}-${expired!.day.toString().padLeft(2, '0')}",
        "package": package,
        "description": description,
        "transactionDate": transactionDate,
        "price": price,
        "status": status,
        "package_id": packageId,
      };
}
