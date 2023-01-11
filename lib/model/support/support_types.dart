class SupportTypes {
  bool? success;
  String? message;
  String? redirect;
  List<SingleSupport>? data;

  SupportTypes({this.success, this.message, this.redirect, this.data});

  SupportTypes.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    redirect = json['redirect'];
    if (json['data'] != null) {
      data = <SingleSupport>[];
      json['data'].forEach((v) {
        data!.add( SingleSupport.fromJson(v));
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

class SingleSupport {
  int? id;
  SupportName? name;
  int? status;

  SingleSupport({this.id, this.name, this.status});

  SingleSupport.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'] != null ? SupportName.fromJson(json['name']) : null;
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    if (name != null) {
      data['name'] = name!.toJson();
    }
    data['status'] = status;
    return data;
  }
}

class SupportName {
  String? ar;
  String? en;

  SupportName({this.ar, this.en});

  SupportName.fromJson(Map<String, dynamic> json) {
    ar = json['ar'];
    en = json['en'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ar'] = ar;
    data['en'] = en;
    return data;
  }
}