class PayrollBody {
  String? date;
  String? month;
  String? year;
  String? userId;
  String? amount;
  String? method;
  String? status;
  String? reference;
  String? notes;

  PayrollBody(
      {this.date,
        this.month,
        this.year,
        this.userId,
        this.amount,
        this.method,
        this.status,
        this.reference,
        this.notes});

  PayrollBody.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    month = json['month'];
    year = json['year'];
    userId = json['user_id'];
    amount = json['amount'];
    method = json['method'];
    status = json['status'];
    reference = json['reference'];
    notes = json['notes'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['date'] = date;
    data['month'] = month;
    data['year'] = year;
    data['user_id'] = userId;
    data['amount'] = amount;
    data['method'] = method;
    data['status'] = status;
    data['reference'] = reference;
    data['notes'] = notes;
    return data;
  }
}
