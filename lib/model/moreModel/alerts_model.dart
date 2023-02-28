class AlertsCount {
  bool? success;
  String? message;
  String? redirect;
  Data? data;

  AlertsCount({this.success, this.message, this.redirect, this.data});

  AlertsCount.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    redirect = json['redirect'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
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

class Data {
  int? alertCount;

  Data({this.alertCount});

  Data.fromJson(Map<String, dynamic> json) {
    alertCount = json['alert_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['alert_count'] = this.alertCount;
    return data;
  }
}