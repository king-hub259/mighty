class ParentDashboardDataModel {
  bool? status;
  String? message;
  Data? data;

  ParentDashboardDataModel({this.status, this.message, this.data});

  ParentDashboardDataModel.fromJson(Map<String, dynamic> json) {
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
  Attendance? attendance;
  int? tasks;
  int? upcomingExams;

  Data({this.attendance, this.tasks, this.upcomingExams});

  Data.fromJson(Map<String, dynamic> json) {
    attendance = json['attendance'] != null
        ? Attendance.fromJson(json['attendance'])
        : null;
    tasks = json['tasks'];
    upcomingExams = json['upcoming_exams'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (attendance != null) {
      data['attendance'] = attendance!.toJson();
    }
    data['tasks'] = tasks;
    data['upcoming_exams'] = upcomingExams;
    return data;
  }
}

class Attendance {
  double? monthlyPercentage;
  double? overallPercentage;

  Attendance({this.monthlyPercentage, this.overallPercentage});

  Attendance.fromJson(Map<String, dynamic> json) {
    monthlyPercentage = json['monthly_percentage'].toDouble();
    overallPercentage = json['overall_percentage'].toDouble();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['monthly_percentage'] = monthlyPercentage;
    data['overall_percentage'] = overallPercentage;
    return data;
  }
}
