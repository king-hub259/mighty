import 'package:mighty_school/helper/price_converter.dart';

class SaasAdminDashboardReportModel {
  bool? status;
  String? message;
  Data? data;

  SaasAdminDashboardReportModel(
      {this.status, this.message, this.data});

  SaasAdminDashboardReportModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? totalStudents;
  int? totalPackages;
  int? totalActiveInstitute;
  int? totalInactiveInstitute;
  List<Transactions>? transactions;
  List<PackageReport>? packageReport;

  Data(
      {this.totalStudents,
        this.totalPackages,
        this.totalActiveInstitute,
        this.totalInactiveInstitute,
        this.transactions,
        this.packageReport});

  Data.fromJson(Map<String, dynamic> json) {
    totalStudents = json['total_institute'];
    totalPackages = json['total_packages'];
    totalActiveInstitute = json['total_active_institute'];
    totalInactiveInstitute = json['total_inactive_institute'];
    if (json['transactions'] != null) {
      transactions = <Transactions>[];
      json['transactions'].forEach((v) {
        transactions!.add(Transactions.fromJson(v));
      });
    }
    if (json['package_report'] != null) {
      packageReport = <PackageReport>[];
      json['package_report'].forEach((v) {
        packageReport!.add(PackageReport.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total_institute'] = totalStudents;
    data['total_packages'] = totalPackages;
    data['total_active_institute'] = totalActiveInstitute;
    data['total_inactive_institute'] = totalInactiveInstitute;
    if (transactions != null) {
      data['transactions'] = transactions!.map((v) => v.toJson()).toList();
    }
    if (packageReport != null) {
      data['package_report'] =
          packageReport!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Transactions {
  String? month;
  double? totalPaid;

  Transactions({this.month, this.totalPaid});

  Transactions.fromJson(Map<String, dynamic> json) {
    month = json['month'];
    totalPaid = PriceConverter.parseAmount(json['total_paid']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['month'] = month;
    data['total_paid'] = totalPaid;
    return data;
  }
}

class PackageReport {
  int? planId;
  String? planName;
  int? instituteCount;
  int? usagePercent;

  PackageReport(
      {this.planId, this.planName, this.instituteCount, this.usagePercent});

  PackageReport.fromJson(Map<String, dynamic> json) {
    planId = json['plan_id'];
    planName = json['plan_name'];
    instituteCount = json['institute_count'];
    usagePercent = json['usage_percent'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['plan_id'] = planId;
    data['plan_name'] = planName;
    data['institute_count'] = instituteCount;
    data['usage_percent'] = usagePercent;
    return data;
  }
}
