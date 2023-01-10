class DataCollection {
  bool? success;
  String? message;
  String? redirect;
  Data? data;

  DataCollection({this.success, this.message, this.redirect, this.data});

  DataCollection.fromJson(Map<String, dynamic> json) {
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
  List<Countries>? countries;
  List<Cities>? cities;
  List<ExpenseType>? expenseType;
  List<Languages>? languages;

  Data({this.countries, this.cities, this.expenseType, this.languages});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['countries'] != null) {
      countries = <Countries>[];
      json['countries'].forEach((v) {
        countries!.add(new Countries.fromJson(v));
      });
    }
    if (json['cities'] != null) {
      cities = <Cities>[];
      json['cities'].forEach((v) {
        cities!.add(new Cities.fromJson(v));
      });
    }
    if (json['expense_type'] != null) {
      expenseType = <ExpenseType>[];
      json['expense_type'].forEach((v) {
        expenseType!.add(new ExpenseType.fromJson(v));
      });
    }
    if (json['languages'] != null) {
      languages = <Languages>[];
      json['languages'].forEach((v) {
        languages!.add(new Languages.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.countries != null) {
      data['countries'] = this.countries!.map((v) => v.toJson()).toList();
    }
    if (this.cities != null) {
      data['cities'] = this.cities!.map((v) => v.toJson()).toList();
    }
    if (this.expenseType != null) {
      data['expense_type'] = this.expenseType!.map((v) => v.toJson()).toList();
    }
    if (this.languages != null) {
      data['languages'] = this.languages!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Countries {
  int? id;
  Name? name;
  String? code;
  String? abbr;
  String? flag;
  int? mobileNumberLength;
  String? mobileNumberPlaceholder;
  int? status;

  Countries(
      {this.id,
      this.name,
      this.code,
      this.abbr,
      this.flag,
      this.mobileNumberLength,
      this.mobileNumberPlaceholder,
      this.status});

  Countries.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'] != null ? new Name.fromJson(json['name']) : null;
    code = json['code'];
    abbr = json['abbr'];
    flag = json['flag'];
    mobileNumberLength = json['mobile_number_length'];
    mobileNumberPlaceholder = json['mobile_number_placeholder'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.name != null) {
      data['name'] = this.name!.toJson();
    }
    data['code'] = this.code;
    data['abbr'] = this.abbr;
    data['flag'] = this.flag;
    data['mobile_number_length'] = this.mobileNumberLength;
    data['mobile_number_placeholder'] = this.mobileNumberPlaceholder;
    data['status'] = this.status;
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

class Cities {
  int? id;
  int? userId;
  int? countryId;
  Name? name;
  int? status;

  Cities({this.id, this.userId, this.countryId, this.name, this.status});

  Cities.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    countryId = json['country_id'];
    name = json['name'] != null ? new Name.fromJson(json['name']) : null;
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['country_id'] = this.countryId;
    if (this.name != null) {
      data['name'] = this.name!.toJson();
    }
    data['status'] = this.status;
    return data;
  }
}

class ExpenseType {
  int? id;
  String? expenseName;
  String? expenseNameAr;
  int? orderBy;
  int? status;

  ExpenseType(
      {this.id,
      this.expenseName,
      this.expenseNameAr,
      this.orderBy,
      this.status});

  ExpenseType.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    expenseName = json['expense_name'];
    expenseNameAr = json['expense_name_ar'];
    orderBy = json['order_by'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['expense_name'] = this.expenseName;
    data['expense_name_ar'] = this.expenseNameAr;
    data['order_by'] = this.orderBy;
    data['status'] = this.status;
    return data;
  }
}

class Languages {
  int? id;
  String? abbr;
  String? name;
  Null? flag;
  Null? dateFormat;
  Null? datetimeFormat;
  String? direction;
  String? status;
  String? isDefault;
  Null? deletedAt;
  String? createdAt;
  String? updatedAt;

  Languages(
      {this.id,
      this.abbr,
      this.name,
      this.flag,
      this.dateFormat,
      this.datetimeFormat,
      this.direction,
      this.status,
      this.isDefault,
      this.deletedAt,
      this.createdAt,
      this.updatedAt});

  Languages.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    abbr = json['abbr'];
    name = json['name'];
    flag = json['flag'];
    dateFormat = json['date_format'];
    datetimeFormat = json['datetime_format'];
    direction = json['direction'];
    status = json['status'];
    isDefault = json['is_default'];
    deletedAt = json['deleted_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['abbr'] = this.abbr;
    data['name'] = this.name;
    data['flag'] = this.flag;
    data['date_format'] = this.dateFormat;
    data['datetime_format'] = this.datetimeFormat;
    data['direction'] = this.direction;
    data['status'] = this.status;
    data['is_default'] = this.isDefault;
    data['deleted_at'] = this.deletedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
