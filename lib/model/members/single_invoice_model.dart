class SingleInvoiceDetails {
  bool? success;
  String? message;
  String? redirect;
  Data? data;

  SingleInvoiceDetails({this.success, this.message, this.redirect, this.data});

  SingleInvoiceDetails.fromJson(Map<String, dynamic> json) {
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
  String? createdDate;
  String? createdTime;
  List<InvoiceFiles>? invoiceFiles;
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
      this.createdDate,
      this.createdTime,
      this.invoiceFiles,
      this.customer});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    memberId = json['member_id'];
    amount = json['amount'];
    note = json['note'];
    attachments = json['attachments'].cast<String>();
    expenseTypeId = json['expense_type_id'];
    budgetId = json['budget_id'];
    paymentType = json['payment_type'];
    isReset = json['is_reset'];
    isApprove = json['is_approve'];
    invoiceType = json['invoice_type'];
    paidStatus = json['paid_status'];
    status = json['status'];
    createdDate = json['created_date'];
    createdTime = json['created_time'];
    if (json['invoice_files'] != null ) {
      invoiceFiles = <InvoiceFiles>[];
      json['invoice_files'].forEach((v) {
        invoiceFiles!.add(new InvoiceFiles.fromJson(v));
      });
    }
    customer = json['customer'] != null
        ? new Customer.fromJson(json['customer'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user_id'] = this.userId;
    data['member_id'] = this.memberId;
    data['amount'] = this.amount;
    data['note'] = this.note;
    data['attachments'] = this.attachments;
    data['expense_type_id'] = this.expenseTypeId;
    data['budget_id'] = this.budgetId;
    data['payment_type'] = this.paymentType;
    data['is_reset'] = this.isReset;
    data['is_approve'] = this.isApprove;
    data['invoice_type'] = this.invoiceType;
    data['paid_status'] = this.paidStatus;
    data['status'] = this.status;
    data['created_date'] = this.createdDate;
    data['created_time'] = this.createdTime;
    if (this.invoiceFiles != null) {
      data['invoice_files'] =
          this.invoiceFiles!.map((v) => v.toJson()).toList();
    }
    if (this.customer != null) {
      data['customer'] = this.customer!.toJson();
    }
    return data;
  }
}

class InvoiceFiles {
  int? id;
  int? invoiceId;
  int? userId;
  List<String>? files;
  int? status;

  InvoiceFiles({this.id, this.invoiceId, this.userId, this.files, this.status});

  InvoiceFiles.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    invoiceId = json['invoice_id'];
    userId = json['user_id'];
    files = json['files'] != null ? json['files'].cast<String>() : null ;
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['invoice_id'] = this.invoiceId;
    data['user_id'] = this.userId;
    data['files'] = this.files;
    data['status'] = this.status;
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
    data['id'] = this.id;
    data['name'] = this.name;
    data['username'] = this.username;
    data['mobile'] = this.mobile;
    return data;
  }
}