class SubjectModel {
  bool? status;
  String? message;
  Data? data;

  SubjectModel({this.status, this.message, this.data});

  SubjectModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

}

class Data {
  int? currentPage;
  List<SubjectItem>? data;
  int? total;

  Data({this.currentPage, this.data, this.total});

  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <SubjectItem>[];
      json['data'].forEach((v) {
        data!.add(SubjectItem.fromJson(v));
      });
    }
    total = json['total'];
  }

}

class SubjectItem {
  int? id;
  String? subjectName;
  String? subjectCode;
  String? subjectType;
  String? classId;
  String? slNo;
  String? groupId;
  String? objective;
  String? written;
  String? practical;
  String? fullMark;
  String? passMark;
  String? createdAt;
  String? className;
  String? status;
  bool? isSelected;

  SubjectItem(
      {this.id,
        this.subjectName,
        this.subjectCode,
        this.subjectType,
        this.classId,
        this.slNo,
        this.groupId,
        this.objective,
        this.written,
        this.practical,
        this.fullMark,
        this.passMark,
        this.createdAt,
        this.className,
        this.status,
      this.isSelected});

  SubjectItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    subjectName = json['subject_name'];
    subjectCode = json['subject_code'];
    subjectType = json['subject_type'];
    classId = json['class_id'].toString();
    slNo = json['sl_no'].toString();
    groupId = json['group_id'].toString();
    objective = json['objective'].toString();
    written = json['written'].toString();
    practical = json['practical'].toString();
    fullMark = json['full_mark'].toString();
    passMark = json['pass_mark'].toString();
    createdAt = json['created_at'];
    className = json['class_name'];
    status = json['status'].toString();
    isSelected = false;
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['subject_name'] = subjectName;
    data['subject_code'] = subjectCode;
    data['subject_type'] = subjectType;
    data['class_id'] = classId;
    data['sl_no'] = slNo;
    data['group_id'] = groupId;
    data['objective'] = objective;
    data['written'] = written;
    data['practical'] = practical;
    data['full_mark'] = fullMark;
    data['pass_mark'] = passMark;
    data['created_at'] = createdAt;
    data['class_name'] = className;
    data['status'] = status;
    return data;
  }


}

