class UserAccounts {
  bool? success;
  String? message;
  String? redirect;
  List<Accounts>? accounts;

  UserAccounts({this.success, this.message, this.redirect, this.accounts});

  UserAccounts.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    redirect = json['redirect'];
    if (json['accounts'] != null) {
      accounts = <Accounts>[];
      json['accounts'].forEach((v) {
        accounts!.add( Accounts.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    data['redirect'] = redirect;
    if (accounts != null) {
      data['accounts'] = accounts!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Accounts {
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
  String? groupId;
  String? androidDeviceId;
  String? iosDeviceId;
  String? webDeviceId;
  String? createdAt;
  String? updatedAt;
  String? reason;
  String? swtichPassKey;
  UserDetail? userDetail;

  Accounts(
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
      this.groupId,
      this.androidDeviceId,
      this.iosDeviceId,
      this.webDeviceId,
      this.createdAt,
      this.updatedAt,
      this.reason,
      this.swtichPassKey,
      this.userDetail});

  Accounts.fromJson(Map<String, dynamic> json) {
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
    groupId = json['group_id'];
    androidDeviceId = json['android_device_id'];
    iosDeviceId = json['ios_device_id'];
    webDeviceId = json['web_device_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    reason = json['reason'];
    swtichPassKey = json['swtichPassKey'];
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
    data['role'] = role;
    data['thumbnail'] = thumbnail;
    data['theme'] = theme;
    data['locale'] = locale;
    data['user_type'] = userType;
    data['account_type'] = accountType;
    data['is_online'] = isOnline;
    data['status'] = status;
    data['group_id'] = groupId;
    data['android_device_id'] = androidDeviceId;
    data['ios_device_id'] = iosDeviceId;
    data['web_device_id'] = webDeviceId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['reason'] = reason;
    data['swtichPassKey'] = swtichPassKey;
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