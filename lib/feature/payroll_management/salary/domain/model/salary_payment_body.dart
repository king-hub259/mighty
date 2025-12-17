class SalaryPaymentBody {
  String? year;
  String? month;
  List<String>? userId;
  List<String>? due;
  List<String>? netSalary;
  List<String>? payable;
  List<String>? paidAmount;

  SalaryPaymentBody(
      {
        this.year,
        this.month,
        this.userId,
        this.due,
        this.netSalary,
        this.payable,
        this.paidAmount});

  SalaryPaymentBody.fromJson(Map<String, dynamic> json) {
    year = json['year'];
    month = json['month'];
    userId = json['user_id'].cast<String>();
    due = json['due'].cast<String>();
    netSalary = json['net_salary'].cast<String>();
    payable = json['payable'].cast<String>();
    paidAmount = json['paid_amount'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['year'] = year;
    data['month'] = month;
    data['user_id'] = userId;
    data['due'] = due;
    data['net_salary'] = netSalary;
    data['payable'] = payable;
    data['paid_amount'] = paidAmount;
    return data;
  }
}
