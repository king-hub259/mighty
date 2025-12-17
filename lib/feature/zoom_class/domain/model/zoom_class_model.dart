class ZoomModel {
  bool? status;
  String? message;
  Data? data;


  ZoomModel({this.status, this.message, this.data});

  ZoomModel.fromJson(Map<String, dynamic> json) {
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
  int? currentPage;
  List<ZoomItem>? data;
  int? total;

  Data(
      {this.currentPage,
        this.data,
        this.total});

  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <ZoomItem>[];
      json['data'].forEach((v) {
        data!.add(ZoomItem.fromJson(v));
      });
    }

    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['current_page'] = currentPage;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['total'] = total;
    return data;
  }
}

class ZoomItem {
  int? id;
  int? instituteId;
  int? branchId;
  String? meetingId;
  String? topic;
  String? agenda;
  String? startTime;
  int? duration;
  String? password;
  String? joinUrl;
  String? startUrl;
  int? createdBy;
  String? createdAt;
  String? updatedAt;

  ZoomItem(
      {this.id,
        this.instituteId,
        this.branchId,
        this.meetingId,
        this.topic,
        this.agenda,
        this.startTime,
        this.duration,
        this.password,
        this.joinUrl,
        this.startUrl,
        this.createdBy,
        this.createdAt,
        this.updatedAt,
        });

  ZoomItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    instituteId = json['institute_id'];
    branchId = json['branch_id'];
    meetingId = json['meeting_id'];
    topic = json['topic'];
    agenda = json['agenda'];
    startTime = json['start_time'];
    duration = json['duration'];
    password = json['password'];
    joinUrl = json['join_url'];
    startUrl = json['start_url'];
    createdBy = json['created_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['institute_id'] = instituteId;
    data['branch_id'] = branchId;
    data['meeting_id'] = meetingId;
    data['topic'] = topic;
    data['agenda'] = agenda;
    data['start_time'] = startTime;
    data['duration'] = duration;
    data['password'] = password;
    data['join_url'] = joinUrl;
    data['start_url'] = startUrl;
    data['created_by'] = createdBy;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;

    return data;
  }
}

