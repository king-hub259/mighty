class HostelRoomMemberModel {
  bool? status;
  String? message;
  HostelRoomMemberData? data;

  HostelRoomMemberModel({this.status, this.message, this.data});

  HostelRoomMemberModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? HostelRoomMemberData.fromJson(json['data']) : null;
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

class HostelRoomMemberData {
  int? currentPage;
  List<HostelRoomMemberItem>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  String? nextPageUrl;
  String? path;
  int? perPage;
  String? prevPageUrl;
  int? to;
  int? total;

  HostelRoomMemberData({
    this.currentPage,
    this.data,
    this.firstPageUrl,
    this.from,
    this.lastPage,
    this.lastPageUrl,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
    this.total,
  });

  HostelRoomMemberData.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <HostelRoomMemberItem>[];
      json['data'].forEach((v) {
        data!.add(HostelRoomMemberItem.fromJson(v));
      });
    }
    firstPageUrl = json['first_page_url'];
    from = json['from'];
    lastPage = json['last_page'];
    lastPageUrl = json['last_page_url'];
    nextPageUrl = json['next_page_url'];
    path = json['path'];
    perPage = json['per_page'];
    prevPageUrl = json['prev_page_url'];
    to = json['to'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['current_page'] = currentPage;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['first_page_url'] = firstPageUrl;
    data['from'] = from;
    data['last_page'] = lastPage;
    data['last_page_url'] = lastPageUrl;
    data['next_page_url'] = nextPageUrl;
    data['path'] = path;
    data['per_page'] = perPage;
    data['prev_page_url'] = prevPageUrl;
    data['to'] = to;
    data['total'] = total;
    return data;
  }
}

class HostelRoomMemberItem {
  int? id;
  int? roomId;
  int? studentId;
  String? assignDate;
  String? leaveDate;
  String? status;
  String? createdAt;
  String? updatedAt;
  RoomInfo? room;
  StudentInfo? student;

  HostelRoomMemberItem({
    this.id,
    this.roomId,
    this.studentId,
    this.assignDate,
    this.leaveDate,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.room,
    this.student,
  });

  HostelRoomMemberItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    roomId = json['room_id'];
    studentId = json['student_id'];
    assignDate = json['assign_date'];
    leaveDate = json['leave_date'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    room = json['room'] != null ? RoomInfo.fromJson(json['room']) : null;
    student = json['student'] != null ? StudentInfo.fromJson(json['student']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['room_id'] = roomId;
    data['student_id'] = studentId;
    data['assign_date'] = assignDate;
    data['leave_date'] = leaveDate;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (room != null) {
      data['room'] = room!.toJson();
    }
    if (student != null) {
      data['student'] = student!.toJson();
    }
    return data;
  }
}

class RoomInfo {
  int? id;
  String? roomNumber;
  String? roomType;
  HostelInfo? hostel;

  RoomInfo({this.id, this.roomNumber, this.roomType, this.hostel});

  RoomInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    roomNumber = json['room_number'];
    roomType = json['room_type'];
    hostel = json['hostel'] != null ? HostelInfo.fromJson(json['hostel']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['room_number'] = roomNumber;
    data['room_type'] = roomType;
    if (hostel != null) {
      data['hostel'] = hostel!.toJson();
    }
    return data;
  }
}

class HostelInfo {
  int? id;
  String? name;

  HostelInfo({this.id, this.name});

  HostelInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}

class StudentInfo {
  int? id;
  String? firstName;
  String? lastName;
  String? registerNo;
  String? image;

  StudentInfo({this.id, this.firstName, this.lastName, this.registerNo, this.image});

  StudentInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    registerNo = json['register_no'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['first_name'] = firstName;
    data['last_name'] = lastName;
    data['register_no'] = registerNo;
    data['image'] = image;
    return data;
  }
}