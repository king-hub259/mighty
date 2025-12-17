class TransportMemberModel {
  bool? status;
  String? message;
  Data? data;

  TransportMemberModel({this.status, this.message, this.data});

  TransportMemberModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
}

class Data {
  int? currentPage;
  List<TransportMemberItem>? data;
  int? total;

  Data({this.currentPage, this.data, this.total});

  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <TransportMemberItem>[];
      json['data'].forEach((v) {
        data!.add(TransportMemberItem.fromJson(v));
      });
    }
    total = json['total'];
  }
}

class TransportMemberItem {
  int? id;
  String? studentId;
  String? routeId;
  String? stopId;
  String? membershipType;
  String? startDate;
  String? endDate;
  String? monthlyFee;
  String? status;
  String? pickupTime;
  String? dropTime;
  String? createdAt;
  String? updatedAt;
  Student? student;
  TransportRoute? route;
  TransportStop? stop;

  TransportMemberItem({
    this.id,
    this.studentId,
    this.routeId,
    this.stopId,
    this.membershipType,
    this.startDate,
    this.endDate,
    this.monthlyFee,
    this.status,
    this.pickupTime,
    this.dropTime,
    this.createdAt,
    this.updatedAt,
    this.student,
    this.route,
    this.stop,
  });

  TransportMemberItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    studentId = json['student_id'].toString();
    routeId = json['route_id'].toString();
    stopId = json['stop_id'].toString();
    membershipType = json['membership_type'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    monthlyFee = json['monthly_fee'].toString();
    status = json['status'];
    pickupTime = json['pickup_time'];
    dropTime = json['drop_time'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    student = json['student'] != null ? Student.fromJson(json['student']) : null;
    route = json['route'] != null ? TransportRoute.fromJson(json['route']) : null;
    stop = json['stop'] != null ? TransportStop.fromJson(json['stop']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['student_id'] = studentId;
    data['route_id'] = routeId;
    data['stop_id'] = stopId;
    data['membership_type'] = membershipType;
    data['start_date'] = startDate;
    data['end_date'] = endDate;
    data['monthly_fee'] = monthlyFee;
    data['status'] = status;
    data['pickup_time'] = pickupTime;
    data['drop_time'] = dropTime;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (student != null) {
      data['student'] = student!.toJson();
    }
    if (route != null) {
      data['route'] = route!.toJson();
    }
    if (stop != null) {
      data['stop'] = stop!.toJson();
    }
    return data;
  }
}

class Student {
  int? id;
  String? name;
  String? rollNumber;
  String? className;
  String? sectionName;

  Student({this.id, this.name, this.rollNumber, this.className, this.sectionName});

  Student.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    rollNumber = json['roll_number'];
    className = json['class_name'];
    sectionName = json['section_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['roll_number'] = rollNumber;
    data['class_name'] = className;
    data['section_name'] = sectionName;
    return data;
  }
}

class TransportRoute {
  int? id;
  String? routeName;
  String? routeCode;

  TransportRoute({this.id, this.routeName, this.routeCode});

  TransportRoute.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    routeName = json['route_name'];
    routeCode = json['route_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['route_name'] = routeName;
    data['route_code'] = routeCode;
    return data;
  }
}

class TransportStop {
  int? id;
  String? stopName;
  String? stopCode;

  TransportStop({this.id, this.stopName, this.stopCode});

  TransportStop.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    stopName = json['stop_name'];
    stopCode = json['stop_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['stop_name'] = stopName;
    data['stop_code'] = stopCode;
    return data;
  }
}