class SubmittedAssignmentModel {
  bool? status;
  String? message;
  Data? data;

  SubmittedAssignmentModel({this.status, this.message, this.data});
  SubmittedAssignmentModel.fromJson(Map<String, dynamic> json) {
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
  List<SubmittedAssignmentItem>? data;
  int? total;

  Data(
      {this.currentPage,
        this.data,
        this.total});

  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <SubmittedAssignmentItem>[];
      json['data'].forEach((v) {
        data!.add(SubmittedAssignmentItem.fromJson(v));
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

class SubmittedAssignmentItem {
  int? id;
  int? assignmentId;
  int? studentId;
  String? file;
  int? result;
  String? reviewedBy;
  String? reviewDescription;
  String? createdAt;
  String? assignmentTitle;
  String? assignmentDescription;
  String? assignmentDeadline;
  String? className;
  String? sectionName;
  String? subjectName;

  SubmittedAssignmentItem(
      {this.id,
        this.assignmentId,
        this.studentId,
        this.file,
        this.result,
        this.reviewedBy,
        this.reviewDescription,
        this.createdAt,
        this.assignmentTitle,
        this.assignmentDescription,
        this.assignmentDeadline,
        this.className,
        this.sectionName,
        this.subjectName});

  SubmittedAssignmentItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    assignmentId = json['assignment_id'];
    studentId = json['student_id'];
    file = json['file'];
    reviewedBy = json['reviewed_by'];
    reviewDescription = json['review_description'];
    createdAt = json['created_at'];
    assignmentTitle = json['assignment_title'];
    assignmentDescription = json['assignment_description'];
    assignmentDeadline = json['assignment_deadline'];
    className = json['class_name'];
    sectionName = json['section_name'];
    subjectName = json['subject_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['assignment_id'] = assignmentId;
    data['student_id'] = studentId;
    data['file'] = file;
    data['result'] = result;
    data['reviewed_by'] = reviewedBy;
    data['review_description'] = reviewDescription;
    data['created_at'] = createdAt;
    data['assignment_title'] = assignmentTitle;
    data['assignment_description'] = assignmentDescription;
    data['assignment_deadline'] = assignmentDeadline;
    data['class_name'] = className;
    data['section_name'] = sectionName;
    data['subject_name'] = subjectName;
    return data;
  }
}

