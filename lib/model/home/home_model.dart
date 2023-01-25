class HomeData {
  bool? success;
  String? message;
  String? redirect;
  SingleHomeData? data;

  HomeData({this.success, this.message, this.redirect, this.data});

  HomeData.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    redirect = json['redirect'];
    data = json['data'] != null ? SingleHomeData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['success'] = success;
    data['message'] = message;
    data['redirect'] = redirect;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class SingleHomeData {
  String? currency;
  int? alertCount;
  List<Budgets>? budgets;
  List<ExpenseTypes>? expenseTypes;
  int? totalInvoices;
  int? totalExpenses;

  SingleHomeData(
      {this.currency,
      this.alertCount,
      this.budgets,
      this.expenseTypes,
      this.totalInvoices,
      this.totalExpenses});

  SingleHomeData.fromJson(Map<String, dynamic> json) {
    currency = json['currency'];
    alertCount = json['alert_count'];
    if (json['budgets'] != null) {
      budgets = <Budgets>[];
      json['budgets'].forEach((v) {
        budgets!.add(Budgets.fromJson(v));
      });
    }
    if (json['expense_types'] != null) {
      expenseTypes = <ExpenseTypes>[];
      json['expense_types'].forEach((v) {
        expenseTypes!.add(ExpenseTypes.fromJson(v));
      });
    }
    totalInvoices = json['total_invoices'];
    totalExpenses = json['total_expenses'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['currency'] = currency;
    data['alert_count'] = alertCount;
    if (budgets != null) {
      data['budgets'] = budgets!.map((v) => v.toJson()).toList();
    }
    if (expenseTypes != null) {
      data['expense_types'] =
          expenseTypes!.map((v) => v.toJson()).toList();
    }
    data['total_invoices'] = totalInvoices;
    data['total_expenses'] = totalExpenses;
    return data;
  }
}

class Budgets {
  int? id;
  String? name;
  String? number;
  int? userId;
  int? type;
  int? status;
  String? deletedAt;

  Budgets(
      {this.id,
      this.name,
      this.number,
      this.userId,
      this.type,
      this.status,
      this.deletedAt});

  Budgets.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    number = json['number'];
    userId = json['user_id'];
    type = json['type'];
    status = json['status'];
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['number'] = number;
    data['user_id'] = userId;
    data['type'] = type;
    data['status'] = status;
    data['deleted_at'] = deletedAt;
    return data;
  }
}

class ExpenseTypes {
  int? id;
  String? expenseName;
  String? expenseNameAr;
  int? invoiceSumAmount;

  ExpenseTypes(
      {this.id, this.expenseName, this.expenseNameAr, this.invoiceSumAmount});

  ExpenseTypes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    expenseName = json['expense_name'];
    expenseNameAr = json['expense_name_ar'];
    invoiceSumAmount = json['invoice_sum_amount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['expense_name'] = expenseName;
    data['expense_name_ar'] = expenseNameAr;
    data['invoice_sum_amount'] = invoiceSumAmount;
    return data;
  }
}
