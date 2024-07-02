class Credit {
  final int? id;
  final int? transactionId;
  final String? transactionType;
  final int? memberId;
  final int? credit;
  final String? expired;
  final int? creditInfo;
  final int? creditPriceInfo;
  final int? isActive;
  final int? creditStartOrder;
  final int? creditUsed;
  bool? isExpand;

  Credit(
      {this.id,
      this.transactionId,
      this.transactionType,
      this.memberId,
      this.credit,
      this.expired,
      this.creditInfo,
      this.creditPriceInfo,
      this.isActive,
      this.creditStartOrder,
      this.creditUsed,
      this.isExpand});

  factory Credit.fromJson(Map<String, dynamic> json) => Credit(
        id: json["id"],
        transactionId: json["transaction_id"],
        transactionType: json["transaction_type"],
        memberId: json["memberID"],
        credit: json["credit"],
        expired: json["expired"],
        creditInfo: json["credit_info"],
        creditPriceInfo: json["credit_price_info"],
        isActive: json["isActive"],
        creditStartOrder: json["creditStartOrder"],
        creditUsed: json["creditUsed"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "transaction_id": transactionId,
        "transaction_type": transactionType,
        "memberID": memberId,
        "credit": credit,
        "expired": expired,
        "credit_info": creditInfo,
        "credit_price_info": creditPriceInfo,
        "isActive": isActive,
        "creditStartOrder": creditStartOrder,
        "creditUsed": creditUsed,
      };
}
