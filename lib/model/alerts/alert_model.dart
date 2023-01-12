class Notifications {
  bool? success;
  String? message;
  String? redirect;
  NotificationData? data;

  Notifications({this.success, this.message, this.redirect, this.data});

  Notifications.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    redirect = json['redirect'];
    data = json['data'] != null ? new NotificationData.fromJson(json['data']) : null;
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

class NotificationData {
  List<Alerts>? alerts;
  int? alertCount;

  NotificationData({this.alerts, this.alertCount});

  NotificationData.fromJson(Map<String, dynamic> json) {
    if (json['alerts'] != null) {
      alerts = <Alerts>[];
      json['alerts'].forEach((v) {
        alerts!.add(new Alerts.fromJson(v));
      });
    }
    alertCount = json['alert_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.alerts != null) {
      data['alerts'] = this.alerts!.map((v) => v.toJson()).toList();
    }
    data['alert_count'] = this.alertCount;
    return data;
  }
}

class Alerts {
  int? id;
  int? userId;
  int? refId;
  Title? title;
  Title? description;
  String? alertType;
  int? isRead;
  String? createdDate;
  String? createdTime;

  Alerts(
      {this.id,
      this.userId,
      this.refId,
      this.title,
      this.description,
      this.alertType,
      this.isRead,
      this.createdDate,
      this.createdTime});

  Alerts.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    refId = json['ref_id'];
    title = json['title'] != null ? new Title.fromJson(json['title']) : null;
    description = json['description'] != null
        ? new Title.fromJson(json['description'])
        : null;
    alertType = json['alert_type'];
    isRead = json['is_read'];
    createdDate = json['created_date'];
    createdTime = json['created_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['ref_id'] = this.refId;
    if (this.title != null) {
      data['title'] = this.title!.toJson();
    }
    if (this.description != null) {
      data['description'] = this.description!.toJson();
    }
    data['alert_type'] = this.alertType;
    data['is_read'] = this.isRead;
    data['created_date'] = this.createdDate;
    data['created_time'] = this.createdTime;
    return data;
  }
}

class Title {
  String? ar;
  String? en;

  Title({this.ar, this.en});

  Title.fromJson(Map<String, dynamic> json) {
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