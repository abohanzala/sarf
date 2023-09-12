class GenrateReportModel {
  bool? success;
  String? message;
  String? redirect;
  List<ReceivedInvoices>? receivedInvoices;
  List<ReceivedInvoices>? sendInvoices;

  GenrateReportModel(
      {this.success,
      this.message,
      this.redirect,
      this.receivedInvoices,
      this.sendInvoices});

  GenrateReportModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    redirect = json['redirect'];
    if (json['received_invoices'] != null) {
      receivedInvoices = <ReceivedInvoices>[];
      json['received_invoices'].forEach((v) {
        receivedInvoices!.add(new ReceivedInvoices.fromJson(v));
      });
    }
    if (json['send_invoices'] != null) {
      sendInvoices = <ReceivedInvoices>[];
      json['send_invoices'].forEach((v) {
        sendInvoices!.add(new ReceivedInvoices.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = success;
    data['message'] = message;
    data['redirect'] = redirect;
    if (receivedInvoices != null) {
      data['received_invoices'] =
          receivedInvoices!.map((v) => v.toJson()).toList();
    }
    if (sendInvoices != null) {
      data['send_invoices'] =
          sendInvoices!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ReceivedInvoices {
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
  int? isViewed;
  String? createdDate;
  String? createdTime;
  Customer? customer;
  Customer? user;

  ReceivedInvoices(
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
      this.isViewed,
      this.createdDate,
      this.createdTime,
      this.customer,
      this.user});

  ReceivedInvoices.fromJson(Map<String, dynamic> json) {
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
    isViewed = json['is_viewed'];
    createdDate = json['created_date'];
    createdTime = json['created_time'];
    customer = json['customer'] != null
        ? new Customer.fromJson(json['customer'])
        : null;
    user = json['user'] != null ? new Customer.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['user_id'] = userId;
    data['member_id'] = memberId;
    data['amount'] = amount;
    data['note'] = note;
    if (attachments != null) {
      data['attachments'] = attachments!.toList();
    }
    data['expense_type_id'] = expenseTypeId;
    data['budget_id'] = budgetId;
    data['payment_type'] = paymentType;
    data['is_reset'] = isReset;
    data['is_approve'] = isApprove;
    data['invoice_type'] = invoiceType;
    data['paid_status'] = paidStatus;
    data['status'] = status;
    data['is_viewed'] = isViewed;
    data['created_date'] = createdDate;
    data['created_time'] = createdTime;
    if (customer != null) {
      data['customer'] = customer!.toJson();
    }
    if (user != null) {
      data['user'] = user!.toJson();
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = id;
    data['name'] = name;
    data['username'] = username;
    data['mobile'] = mobile;
    return data;
  }
}
