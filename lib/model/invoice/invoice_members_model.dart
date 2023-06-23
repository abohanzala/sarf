class InvoiceMemberListModel {
  bool? success;
  String? message;
  String? redirect;
  List<InvoiceMember>? data;

  InvoiceMemberListModel(
      {this.success, this.message, this.redirect, this.data});

  InvoiceMemberListModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    redirect = json['redirect'];
    if (json['data'] != null) {
      data = <InvoiceMember>[];
      json['data'].forEach((v) {
        data!.add(InvoiceMember.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    data['redirect'] = redirect;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class InvoiceMember {
  int? id;
  String? name;
  String? username;
  String? email;
  String? firebaseEmail;
  String? mobile;
  String? photo;
  int? childOf;
  int? countryId;
  int? role;
  String? thumbnail;
  String? theme;
  String? locale;
  int? userType;
  int? isMaster;
  int? accountType;
  int? isOnline;
  int? status;
  String? groupId;
  String? linkWith;
  String? androidDeviceId;
  String? iosDeviceId;
  String? webDeviceId;
  String? createdAt;
  String? updatedAt;
  String? reason;
  int? invoicesCount;
  int? invoicesSumAmount;
  UserDetail? userDetail;

  InvoiceMember(
      {this.id,
      this.name,
      this.username,
      this.email,
      this.firebaseEmail,
      this.mobile,
      this.photo,
      this.childOf,
      this.countryId,
      this.role,
      this.thumbnail,
      this.theme,
      this.locale,
      this.userType,
      this.isMaster,
      this.accountType,
      this.isOnline,
      this.status,
      this.groupId,
      this.linkWith,
      this.androidDeviceId,
      this.iosDeviceId,
      this.webDeviceId,
      this.createdAt,
      this.updatedAt,
      this.reason,
      this.invoicesCount,
      this.invoicesSumAmount,
      this.userDetail});

  InvoiceMember.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    username = json['username'];
    email = json['email'];
    firebaseEmail = json['firebase_email'];
    mobile = json['mobile'];
    photo = json['photo'];
    childOf = json['child_of'];
    countryId = json['country_id'];
    role = json['role'];
    thumbnail = json['thumbnail'];
    theme = json['theme'];
    locale = json['locale'];
    userType = json['user_type'];
    isMaster = json['is_master'];
    accountType = json['account_type'];
    isOnline = json['is_online'];
    status = json['status'];
    groupId = json['group_id'];
    linkWith = json['link_with'];
    androidDeviceId = json['android_device_id'];
    iosDeviceId = json['ios_device_id'];
    webDeviceId = json['web_device_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    reason = json['reason'];
    invoicesCount = json['invoices_count'];
    invoicesSumAmount = json['invoices_sum_amount'];
    userDetail = json['user_detail'] != null
        ? UserDetail.fromJson(json['user_detail'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['username'] = username;
    data['email'] = email;
    data['firebase_email'] = firebaseEmail;
    data['mobile'] = mobile;
    data['photo'] = photo;
    data['child_of'] = childOf;
    data['country_id'] = countryId;
    data['role'] = role;
    data['thumbnail'] = thumbnail;
    data['theme'] = theme;
    data['locale'] = locale;
    data['user_type'] = userType;
    data['is_master'] = isMaster;
    data['account_type'] = accountType;
    data['is_online'] = isOnline;
    data['status'] = status;
    data['group_id'] = groupId;
    data['link_with'] = linkWith;
    data['android_device_id'] = androidDeviceId;
    data['ios_device_id'] = iosDeviceId;
    data['web_device_id'] = webDeviceId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['reason'] = reason;
    data['invoices_count'] = invoicesCount;
    data['invoices_sum_amount'] = invoicesSumAmount;
    if (userDetail != null) {
      data['user_detail'] = userDetail!.toJson();
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['city_id'] = cityId;
    data['expense_type_id'] = expenseTypeId;
    data['insta_link'] = instaLink;
    data['twitter_link'] = twitterLink;
    data['contact_no'] = contactNo;
    data['whatsapp'] = whatsapp;
    data['website'] = website;
    data['location'] = location;
    data['location_lat'] = locationLat;
    data['location_lng'] = locationLng;
    return data;
  }
}