class ViewerModel {
  bool? success;
  String? message;
  String? redirect;
  List<ViewerData>? data;

  ViewerModel({this.success, this.message, this.redirect, this.data});

  ViewerModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    redirect = json['redirect'];
    if (json['data'] != null) {
      data = <ViewerData>[];
      json['data'].forEach((v) {
        data!.add(ViewerData.fromJson(v));
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

class ViewerData {
  int? id;
  String? name;
  String? username;
  String? email;
  String? firebaseEmail;
  String? mobile;
  String? photo;
  int? childOf;
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
  String? passwordValue;

  ViewerData(
      {this.id,
      this.name,
      this.username,
      this.email,
      this.firebaseEmail,
      this.mobile,
      this.photo,
      this.childOf,
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
      this.passwordValue});

  ViewerData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    username = json['username'];
    email = json['email'];
    firebaseEmail = json['firebase_email'];
    mobile = json['mobile'];
    photo = json['photo'];
    childOf = json['child_of'];
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
    passwordValue = json['password_value'];
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
    data['password_value'] = passwordValue;
    return data;
  }
}
