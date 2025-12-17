class ClassRoutineModel {
  bool? status;
  String? message;
  Data? data;

  ClassRoutineModel({this.status, this.message, this.data});

  ClassRoutineModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;

  }


}

class Data {
  List<DAY>? sATURDAY;
  List<DAY>? sUNDAY;
  List<DAY>? mONDAY;
  List<DAY>? tUESDAY;
  List<DAY>? wEDNESDAY;
  List<DAY>? tHURSDAY;
  List<DAY>? fRIDAY;

  Data(
      {this.sATURDAY,
        this.sUNDAY,
        this.mONDAY,
        this.tUESDAY,
        this.wEDNESDAY,
        this.tHURSDAY,
        this.fRIDAY});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['SATURDAY'] != null) {
      sATURDAY = <DAY>[];
      json['SATURDAY'].forEach((v) {
        sATURDAY!.add(DAY.fromJson(v));
      });
    }
    if (json['SUNDAY'] != null) {
      sUNDAY = <DAY>[];
      json['SUNDAY'].forEach((v) {
        sUNDAY!.add(DAY.fromJson(v));
      });
    }
    if (json['MONDAY'] != null) {
      mONDAY = <DAY>[];
      json['MONDAY'].forEach((v) {
        mONDAY!.add(DAY.fromJson(v));
      });
    }
    if (json['TUESDAY'] != null) {
      tUESDAY = <DAY>[];
      json['TUESDAY'].forEach((v) {
        tUESDAY!.add(DAY.fromJson(v));
      });
    }
    if (json['WEDNESDAY'] != null) {
      wEDNESDAY = <DAY>[];
      json['WEDNESDAY'].forEach((v) {
        wEDNESDAY!.add(DAY.fromJson(v));
      });
    }
    if (json['THURSDAY'] != null) {
      tHURSDAY = <DAY>[];
      json['THURSDAY'].forEach((v) {
        tHURSDAY!.add(DAY.fromJson(v));
      });
    }
    if (json['FRIDAY'] != null) {
      fRIDAY = <DAY>[];
      json['FRIDAY'].forEach((v) {
        fRIDAY!.add(DAY.fromJson(v));
      });
    }
  }

}

class DAY {
  String? classDayId;
  String? classDay;
  String? sId;
  String? subjectName;
  String? startTime;
  String? endTime;
  String? teacherName;

  DAY(
      {this.classDayId,
        this.classDay,
        this.sId,
        this.subjectName,
        this.startTime,
        this.endTime,
        this.teacherName});

  DAY.fromJson(Map<String, dynamic> json) {
    classDayId = json['class_day_id'].toString();
    classDay = json['class_day'];
    sId = json['s_id'].toString();
    subjectName = json['subject_name'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    teacherName = json['teacher_name'];
  }

}