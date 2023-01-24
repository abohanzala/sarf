class SupportList {
  bool? success;
  String? message;
  String? redirect;
  List<SingleSupportList>? data;

  SupportList({this.success, this.message, this.redirect, this.data});

  SupportList.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    redirect = json['redirect'];
    if (json['data'] != null) {
      data = <SingleSupportList>[];
      json['data'].forEach((v) {
        data!.add(new SingleSupportList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    data['redirect'] = this.redirect;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class SingleSupportList {
  int? id;
  String? type;
  String? message;
  int? userId;
  List<String>? attachments;
  String? status;
  int? isSatisfied;
  String? createdAt;
  String? updatedAt;
  String? createdDate;
  String? createdTime;
  SupportType? supportType;

  SingleSupportList(
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
      this.supportType});

  SingleSupportList.fromJson(Map<String, dynamic> json) {
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
        ? new SupportType.fromJson(json['support_type'])
        : null;
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
    return data;
  }
}

class SupportType {
  int? id;
  Name? name;

  SupportType({this.id, this.name});

  SupportType.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'] != null ? new Name.fromJson(json['name']) : null;
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

class Name {
  String? ar;
  String? en;

  Name({this.ar, this.en});

  Name.fromJson(Map<String, dynamic> json) {
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