class InvoiceList {
  bool? success;
  String? message;
  String? redirect;
  List<Data>? data;

  InvoiceList({this.success, this.message, this.redirect, this.data});

  InvoiceList.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    redirect = json['redirect'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
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

class Data {
  int? id;
  int? userId;
  int? memberId;
  int? amount;
  String? note;
  List<String>? attachments;
  int? expenseTypeId;
  int? budgetId;
  int? paymentType;
  int? isReset;
  int? isApprove;
  int? invoiceType;
  int? paidStatus;
  int? status;
  int? viewed;
  String? createdDate;
  String? createdTime;
  Customer? customer;

  Data(
      {this.id,
      this.userId,
      this.memberId,
      this.amount,
      this.note,
      this.attachments,
      this.expenseTypeId,
      this.budgetId,
      this.paymentType,
      this.isReset,
      this.isApprove,
      this.invoiceType,
      this.paidStatus,
      this.status,
      this.viewed,
      this.createdDate,
      this.createdTime,
      this.customer});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    memberId = json['member_id'];
    amount = json['amount'];
    note = json['note'];
    if (json['attachments'] != null) {
      attachments = <String>[];
      json['attachments'].forEach((v) {
        attachments!.add(v);
      });
    }
    expenseTypeId = json['expense_type_id'];
    budgetId = json['budget_id'];
    paymentType = json['payment_type'];
    isReset = json['is_reset'];
    isApprove = json['is_approve'];
    invoiceType = json['invoice_type'];
    paidStatus = json['paid_status'];
    status = json['status'];
    viewed = json['is_viewed'];
    createdDate = json['created_date'];
    createdTime = json['created_time'];
    customer = json['customer'] != null
        ?  Customer.fromJson(json['customer'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['member_id'] = memberId;
    data['amount'] = amount;
    data['note'] = note;
    if (attachments != null) {
      data['attachments'] = attachments!.map((v) => v).toList();
    }
    data['expense_type_id'] = expenseTypeId;
    data['budget_id'] = budgetId;
    data['payment_type'] = paymentType;
    data['is_reset'] = isReset;
    data['is_approve'] = isApprove;
    data['invoice_type'] = invoiceType;
    data['paid_status'] = paidStatus;
    data['status'] = status;
    data['is_viewed'] = viewed;
    data['created_date'] = createdDate;
    data['created_time'] = createdTime;
    if (customer != null) {
      data['customer'] = customer!.toJson();
    }
    return data;
  }
}

class Customer {
  int? id;
  String? name;
  String? username;
  String? mobile;

  Customer({this.id, this.name, this.username, this.mobile});

  Customer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    username = json['username'];
    mobile = json['mobile'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['username'] = username;
    data['mobile'] = mobile;
    return data;
  }
}