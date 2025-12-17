

class StudentAssignmentItem {
  int? id;
  String? sessionId;
  String? title;
  String? description;
  String? deadline;
  String? classId;
  String? sectionId;
  String? subjectId;
  String? file;
  String? file2;
  String? file3;
  String? file4;
  String? createdAt;
  String? updatedAt;
  String? className;
  String? status;
  String? studentGroupId;
  String? sectionName;
  String? roomNo;
  String? subjectName;
  String? subjectCode;
  String? subjectType;
  String? slNo;
  String? objective;
  String? written;
  String? practical;
  String? fullMark;
  String? passMark;

  StudentAssignmentItem(
      {this.id,
        this.sessionId,
        this.title,
        this.description,
        this.deadline,
        this.classId,
        this.sectionId,
        this.subjectId,
        this.file,
        this.file2,
        this.file3,
        this.file4,
        this.createdAt,
        this.updatedAt,
        this.className,
        this.status,
        this.studentGroupId,
        this.sectionName,
        this.roomNo,
        this.subjectName,
        this.subjectCode,
        this.subjectType,
        this.slNo,
        this.objective,
        this.written,
        this.practical,
        this.fullMark,
        this.passMark
      });

  StudentAssignmentItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sessionId = json['session_id'];
    title = json['title'];
    description = json['description'];
    deadline = json['deadline'];
    classId = json['class_id'];
    sectionId = json['section_id'];
    subjectId = json['subject_id'];
    file = json['file'];
    file2 = json['file_2'];
    file3 = json['file_3'];
    file4 = json['file_4'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    className = json['class_name'];
    status = json['status'];
    studentGroupId = json['student_group_id'];
    sectionName = json['section_name'];
    roomNo = json['room_no'];
    subjectName = json['subject_name'];
    subjectCode = json['subject_code'];
    subjectType = json['subject_type'];
    slNo = json['sl_no'];
    objective = json['objective'];
    written = json['written'];
    practical = json['practical'];
    fullMark = json['full_mark'];
    passMark = json['pass_mark'];
  }
}


