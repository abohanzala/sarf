class MembersList {
  bool? success;
  String? message;
  String? redirect;
  List<SingleMember>? data;

  MembersList({this.success, this.message, this.redirect, this.data});

  MembersList.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    redirect = json['redirect'];
    if (json['data'] != null) {
      data = <SingleMember>[];
      json['data'].forEach((v) {
        data!.add(SingleMember.fromJson(v));
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

class SingleMember {
  int? id;
  String? expenseName;
  String? expenseNameAr;
  String? membersCount;

  SingleMember({this.id, this.expenseName, this.expenseNameAr, this.membersCount});

  SingleMember.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    expenseName = json['expense_name'];
    expenseNameAr = json['expense_name_ar'];
    membersCount = json['members_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['expense_name'] = expenseName;
    data['expense_name_ar'] = expenseNameAr;
    data['members_count'] = membersCount;
    return data;
  }
}
