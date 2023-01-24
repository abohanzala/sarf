class ListMembersNewList {
  bool? success;
  String? message;
  String? redirect;
  List<Data>? data;

  ListMembersNewList({this.success, this.message, this.redirect, this.data});

  ListMembersNewList.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    redirect = json['redirect'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
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

class Data {
  int? id;
  String? name;
  String? username;
  String? email;
  String? firebaseEmail;
  String? mobile;
  String? photo;
  int? role;
  String? thumbnail;
  String? theme;
  String? locale;
  int? userType;
  int? accountType;
  int? isOnline;
  int? status;
  String? androidDeviceId;
  String? iosDeviceId;
  String? webDeviceId;
  String? createdAt;
  String? updatedAt;
  String? reason;
  int? invoicesCount;
  String? invoicesSumAmount;
  UserDetail? userDetail;

  Data(
      {this.id,
      this.name,
      this.username,
      this.email,
      this.firebaseEmail,
      this.mobile,
      this.photo,
      this.role,
      this.thumbnail,
      this.theme,
      this.locale,
      this.userType,
      this.accountType,
      this.isOnline,
      this.status,
      this.androidDeviceId,
      this.iosDeviceId,
      this.webDeviceId,
      this.createdAt,
      this.updatedAt,
      this.reason,
      this.invoicesCount,
      this.invoicesSumAmount,
      this.userDetail});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    username = json['username'];
    email = json['email'];
    firebaseEmail = json['firebase_email'];
    mobile = json['mobile'];
    photo = json['photo'];
    role = json['role'];
    thumbnail = json['thumbnail'];
    theme = json['theme'];
    locale = json['locale'];
    userType = json['user_type'];
    accountType = json['account_type'];
    isOnline = json['is_online'];
    status = json['status'];
    androidDeviceId = json['android_device_id'];
    iosDeviceId = json['ios_device_id'];
    webDeviceId = json['web_device_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    reason = json['reason'];
    invoicesCount = json['invoices_count'];
    invoicesSumAmount = json['invoices_sum_amount'];
    userDetail = json['user_detail'] != null
        ? new UserDetail.fromJson(json['user_detail'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['username'] = this.username;
    data['email'] = this.email;
    data['firebase_email'] = this.firebaseEmail;
    data['mobile'] = this.mobile;
    data['photo'] = this.photo;
    data['role'] = this.role;
    data['thumbnail'] = this.thumbnail;
    data['theme'] = this.theme;
    data['locale'] = this.locale;
    data['user_type'] = this.userType;
    data['account_type'] = this.accountType;
    data['is_online'] = this.isOnline;
    data['status'] = this.status;
    data['android_device_id'] = this.androidDeviceId;
    data['ios_device_id'] = this.iosDeviceId;
    data['web_device_id'] = this.webDeviceId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['reason'] = this.reason;
    data['invoices_count'] = this.invoicesCount;
    data['invoices_sum_amount'] = this.invoicesSumAmount;
    if (this.userDetail != null) {
      data['user_detail'] = this.userDetail!.toJson();
    }
    return data;
  }
}

class UserDetail {
  int? id;
  int? userId;
  int? cityId;
  int? expenseTypeId;
  String? instaLink;
  String? twitterLink;
  String? contactNo;
  String? whatsapp;
  String? website;
  String? location;
  String? locationLat;
  String? locationLng;

  UserDetail(
      {this.id,
      this.userId,
      this.cityId,
      this.expenseTypeId,
      this.instaLink,
      this.twitterLink,
      this.contactNo,
      this.whatsapp,
      this.website,
      this.location,
      this.locationLat,
      this.locationLng});

  UserDetail.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    cityId = json['city_id'];
    expenseTypeId = json['expense_type_id'];
    instaLink = json['insta_link'];
    twitterLink = json['twitter_link'];
    contactNo = json['contact_no'];
    whatsapp = json['whatsapp'];
    website = json['website'];
    location = json['location'];
    locationLat = json['location_lat'];
    locationLng = json['location_lng'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['city_id'] = this.cityId;
    data['expense_type_id'] = this.expenseTypeId;
    data['insta_link'] = this.instaLink;
    data['twitter_link'] = this.twitterLink;
    data['contact_no'] = this.contactNo;
    data['whatsapp'] = this.whatsapp;
    data['website'] = this.website;
    data['location'] = this.location;
    data['location_lat'] = this.locationLat;
    data['location_lng'] = this.locationLng;
    return data;
  }
}
