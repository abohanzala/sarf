class LoginModel {
  bool? success;
  String? message;
  String? redirect;
  String? token;
  User? user;

  LoginModel(
      {this.success, this.message, this.redirect, this.token, this.user});

  LoginModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    redirect = json['redirect'];
    token = json['token'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    data['redirect'] = this.redirect;
    data['token'] = this.token;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}

class User {
  int? id;
  String? name;
  String? username;
  String? email;
  String? firebaseEmail;
  String? mobile;
  Null? photo;
  int? role;
  Null? thumbnail;
  String? theme;
  String? locale;
  int? userType;
  int? accountType;
  int? isOnline;
  int? status;
  String? androidDeviceId;
  String? iosDeviceId;
  Null? webDeviceId;
  String? createdAt;
  String? updatedAt;
  Null? reason;

  User(
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
      this.reason});

  User.fromJson(Map<String, dynamic> json) {
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
    return data;
  }
}
