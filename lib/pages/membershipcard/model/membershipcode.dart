class MembershipCodeData {
  int? code;
  bool? status;
  String? message;
  Data? data;

  MembershipCodeData({this.code, this.status, this.message, this.data});

  MembershipCodeData.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? id;
  int? memberID;
  String? membershipCode;
  String? expiredDate;
  int? isActive;

  Data(
      {this.id,
        this.memberID,
        this.membershipCode,
        this.expiredDate,
        this.isActive});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    memberID = json['memberID'];
    membershipCode = json['membershipCode'];
    expiredDate = json['expired_date'];
    isActive = json['isActive'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['memberID'] = this.memberID;
    data['membershipCode'] = this.membershipCode;
    data['expired_date'] = this.expiredDate;
    data['isActive'] = this.isActive;
    return data;
  }
}
