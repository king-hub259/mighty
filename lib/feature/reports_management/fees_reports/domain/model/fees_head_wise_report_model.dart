class FeesHeadWiseReportModel {
  bool? status;
  String? message;
  List<FeesHeadWiseReportItem>? data;

  FeesHeadWiseReportModel({this.status, this.message, this.data});

  FeesHeadWiseReportModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <FeesHeadWiseReportItem>[];
      json['data'].forEach((v) {
        data!.add(FeesHeadWiseReportItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FeesHeadWiseReportItem {
  int? studentId;
  String? firstName;
  String? lastName;
  String? roll;
  String? totalPaid;
  String? invoiceId;
  String? invoiceDate;
  String? feeHeadName;
  String? feeTotalPaid;

  FeesHeadWiseReportItem(
      {this.studentId,
        this.firstName,
        this.lastName,
        this.roll,
        this.totalPaid,
        this.invoiceId,
        this.invoiceDate,
        this.feeHeadName,
        this.feeTotalPaid});

  FeesHeadWiseReportItem.fromJson(Map<String, dynamic> json) {
    studentId = json['student_id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    roll = json['roll'];
    totalPaid = json['total_paid'];
    invoiceId = json['invoice_id'];
    invoiceDate = json['invoice_date'];
    feeHeadName = json['fee_head_name'];
    feeTotalPaid = json['fee_total_paid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['student_id'] = studentId;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['roll'] = roll;
    data['total_paid'] = totalPaid;
    data['invoice_id'] = invoiceId;
    data['invoice_date'] = invoiceDate;
    data['fee_head_name'] = feeHeadName;
    data['fee_total_paid'] = feeTotalPaid;
    return data;
  }
}
