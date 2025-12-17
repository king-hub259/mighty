class ParentClassRoutineModel {
  bool? status;
  String? message;
  RoutineInfo? data;

  ParentClassRoutineModel({this.status, this.message, this.data});

  ParentClassRoutineModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? RoutineInfo.fromJson(json['data']) : null;

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class RoutineInfo {
  ClassDetails? classDetails;
  Section? section;
  Routine? routine;

  RoutineInfo({this.classDetails, this.section, this.routine});

  RoutineInfo.fromJson(Map<String, dynamic> json) {
    classDetails = json['class'] != null ? ClassDetails.fromJson(json['class']) : null;
    section = json['section'] != null ? Section.fromJson(json['section']) : null;
    routine = json['routine'] != null ? Routine.fromJson(json['routine']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (classDetails != null) {
      data['class'] = classDetails!.toJson();
    }
    if (section != null) {
      data['section'] = section!.toJson();
    }
    if (routine != null) {
      data['routine'] = routine!.toJson();
    }
    return data;
  }
}

class ClassDetails {
  int? id;
  String? className;
  String? status;
  String? createdAt;
  String? updatedAt;

  ClassDetails({this.id, this.className, this.status, this.createdAt, this.updatedAt});

  ClassDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    className = json['class_name'];
    status = json['status'].toString();
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['class_name'] = className;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class Section {
  int? id;
  String? classId;
  String? studentGroupId;
  String? sectionName;
  String? roomNo;
  dynamic classTeacherId;
  String? status;
  dynamic rank;
  dynamic capacity;
  dynamic attendanceTimeConfigId;
  String? createdAt;
  String? updatedAt;

  Section({
    this.id,
    this.classId,
    this.studentGroupId,
    this.sectionName,
    this.roomNo,
    this.classTeacherId,
    this.status,
    this.rank,
    this.capacity,
    this.attendanceTimeConfigId,
    this.createdAt,
    this.updatedAt,
  });

  Section.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    classId = json['class_id'].toString();
    studentGroupId = json['student_group_id'].toString();
    sectionName = json['section_name'];
    roomNo = json['room_no'];
    classTeacherId = json['class_teacher_id'];
    status = json['status'].toString();
    rank = json['rank'];
    capacity = json['capacity'];
    attendanceTimeConfigId = json['attendance_time_config_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['class_id'] = classId;
    data['student_group_id'] = studentGroupId;
    data['section_name'] = sectionName;
    data['room_no'] = roomNo;
    data['class_teacher_id'] = classTeacherId;
    data['status'] = status;
    data['rank'] = rank;
    data['capacity'] = capacity;
    data['attendance_time_config_id'] = attendanceTimeConfigId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class Routine {
  List<RoutineDetails>? saturday;
  List<RoutineDetails>? sunday;
  List<RoutineDetails>? monday;
  List<RoutineDetails>? tuesday;
  List<RoutineDetails>? wednesday;
  List<RoutineDetails>? thursday;
  List<RoutineDetails>? friday;

  Routine({
    this.saturday,
    this.sunday,
    this.monday,
    this.tuesday,
    this.wednesday,
    this.thursday,
    this.friday,
  });

  Routine.fromJson(Map<String, dynamic> json) {
    saturday = json['SATURDAY'] != null
        ? (json['SATURDAY'] as List).map((v) => RoutineDetails.fromJson(v)).toList()
        : null;
    sunday = json['SUNDAY'] != null
        ? (json['SUNDAY'] as List).map((v) => RoutineDetails.fromJson(v)).toList()
        : null;
    monday = json['MONDAY'] != null
        ? (json['MONDAY'] as List).map((v) => RoutineDetails.fromJson(v)).toList()
        : null;
    tuesday = json['TUESDAY'] != null
        ? (json['TUESDAY'] as List).map((v) => RoutineDetails.fromJson(v)).toList()
        : null;
    wednesday = json['WEDNESDAY'] != null
        ? (json['WEDNESDAY'] as List).map((v) => RoutineDetails.fromJson(v)).toList()
        : null;
    thursday = json['THURSDAY'] != null
        ? (json['THURSDAY'] as List).map((v) => RoutineDetails.fromJson(v)).toList()
        : null;
    friday = json['FRIDAY'] != null
        ? (json['FRIDAY'] as List).map((v) => RoutineDetails.fromJson(v)).toList()
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (saturday != null) data['SATURDAY'] = saturday!.map((v) => v.toJson()).toList();
    if (sunday != null) data['SUNDAY'] = sunday!.map((v) => v.toJson()).toList();
    if (monday != null) data['MONDAY'] = monday!.map((v) => v.toJson()).toList();
    if (tuesday != null) data['TUESDAY'] = tuesday!.map((v) => v.toJson()).toList();
    if (wednesday != null) data['WEDNESDAY'] = wednesday!.map((v) => v.toJson()).toList();
    if (thursday != null) data['THURSDAY'] = thursday!.map((v) => v.toJson()).toList();
    if (friday != null) data['FRIDAY'] = friday!.map((v) => v.toJson()).toList();
    return data;
  }
}

class RoutineDetails {
  String? classDayId;
  String? classDay;
  String? sId;
  String? subjectName;
  dynamic id;
  dynamic sectionId;
  dynamic subjectId;
  dynamic day;
  dynamic startTime;
  dynamic endTime;
  dynamic teacherId;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic teacherName;

  RoutineDetails({
    this.classDayId,
    this.classDay,
    this.sId,
    this.subjectName,
    this.id,
    this.sectionId,
    this.subjectId,
    this.day,
    this.startTime,
    this.endTime,
    this.teacherId,
    this.createdAt,
    this.updatedAt,
    this.teacherName,
  });

  RoutineDetails.fromJson(Map<String, dynamic> json) {
    classDayId = json['class_day_id'].toString();
    classDay = json['class_day'];
    sId = json['s_id'].toString();
    subjectName = json['subject_name'];
    id = json['id'];
    sectionId = json['section_id'];
    subjectId = json['subject_id'];
    day = json['day'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    teacherId = json['teacher_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    teacherName = json['teacher_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['class_day_id'] = classDayId;
    data['class_day'] = classDay;
    data['s_id'] = sId;
    data['subject_name'] = subjectName;
    data['id'] = id;
    data['section_id'] = sectionId;
    data['subject_id'] = subjectId;
    data['day'] = day;
    data['start_time'] = startTime;
    data['end_time'] = endTime;
    data['teacher_id'] = teacherId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['teacher_name'] = teacherName;
    return data;
  }
}
