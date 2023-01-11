class SupportDetails {
  bool? success;
  String? message;
  String? redirect;
  SingleSupportDetails? data;

  SupportDetails({this.success, this.message, this.redirect, this.data});

  SupportDetails.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    redirect = json['redirect'];
    data = json['data'] != null ? new SingleSupportDetails.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    data['redirect'] = this.redirect;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class SingleSupportDetails {
  int? id;
  String? type;
  String? message;
  String? userId;
  List<String>? attachments;
  String? status;
  String? isSatisfied;
  String? createdAt;
  String? updatedAt;
  String? createdDate;
  String? createdTime;
  SupportDetailType? supportType;
  List<SingleDetail>? detail;

  SingleSupportDetails(
      {this.id,
      this.type,
      this.message,
      this.userId,
      this.attachments,
      this.status,
      this.isSatisfied,
      this.createdAt,
      this.updatedAt,
      this.createdDate,
      this.createdTime,
      this.supportType,
      this.detail});

  SingleSupportDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    message = json['message'];
    userId = json['user_id'];
    attachments = json['attachments'].cast<String>();
    status = json['status'];
    isSatisfied = json['is_satisfied'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    createdDate = json['created_date'];
    createdTime = json['created_time'];
    supportType = json['support_type'] != null
        ? new SupportDetailType.fromJson(json['support_type'])
        : null;
    if (json['detail'] != null) {
      detail = <SingleDetail>[];
      json['detail'].forEach((v) {
        detail!.add(new SingleDetail.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    data['message'] = this.message;
    data['user_id'] = this.userId;
    data['attachments'] = this.attachments;
    data['status'] = this.status;
    data['is_satisfied'] = this.isSatisfied;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['created_date'] = this.createdDate;
    data['created_time'] = this.createdTime;
    if (this.supportType != null) {
      data['support_type'] = this.supportType!.toJson();
    }
    if (this.detail != null) {
      data['detail'] = this.detail!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SupportDetailType {
  int? id;
  SupportDetailName? name;

  SupportDetailType({this.id, this.name});

  SupportDetailType.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'] != null ? new SupportDetailName.fromJson(json['name']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.name != null) {
      data['name'] = this.name!.toJson();
    }
    return data;
  }
}

class SupportDetailName {
  String? ar;
  String? en;

  SupportDetailName({this.ar, this.en});

  SupportDetailName.fromJson(Map<String, dynamic> json) {
    ar = json['ar'];
    en = json['en'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ar'] = this.ar;
    data['en'] = this.en;
    return data;
  }
}

class SingleDetail {
  int? id;
  String? message;
  String? supportId;
  String? userId;
  String? type;
  String? status;
  String? createdAt;
  String? updatedAt;
  String? createdDate;
  String? createdTime;
  Users? users;

  SingleDetail(
      {this.id,
      this.message,
      this.supportId,
      this.userId,
      this.type,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.createdDate,
      this.createdTime,
      this.users});

  SingleDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    message = json['message'];
    supportId = json['support_id'];
    userId = json['user_id'];
    type = json['type'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    createdDate = json['created_date'];
    createdTime = json['created_time'];
    users = json['users'] != null ? new Users.fromJson(json['users']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['message'] = this.message;
    data['support_id'] = this.supportId;
    data['user_id'] = this.userId;
    data['type'] = this.type;
    data['status'] = this.status;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['created_date'] = this.createdDate;
    data['created_time'] = this.createdTime;
    if (this.users != null) {
      data['users'] = this.users!.toJson();
    }
    return data;
  }
}

class Users {
  int? id;
  String? name;

  Users({this.id, this.name});

  Users.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    return data;
  }
}