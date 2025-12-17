class StaffAttendanceBody {
  String? date;
  String? type;
  int? smsStatus;
  List<Attendance>? attendance;

  StaffAttendanceBody({this.date, this.type, this.smsStatus, this.attendance});

  StaffAttendanceBody.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    type = json['type'];
    smsStatus = json['sms_status'];
    if (json['attendance'] != null) {
      attendance = <Attendance>[];
      json['attendance'].forEach((v) {
        attendance!.add(Attendance.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['date'] = date;
    data['type'] = type;
    data['sms_status'] = smsStatus;
    if (attendance != null) {
      data['attendance'] = attendance!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Attendance {
  int? userId;
  int? attendance;
  String? startTime;
  String? endTime;
  String? smsStatus;

  Attendance(
      {this.userId,
        this.attendance,
        this.startTime,
        this.endTime,
        this.smsStatus});

  Attendance.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    attendance = json['attendance'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    smsStatus = json['sms_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = userId;
    data['attendance'] = attendance;
    data['start_time'] = startTime;
    data['end_time'] = endTime;
    data['sms_status'] = smsStatus;
    return data;
  }
}
