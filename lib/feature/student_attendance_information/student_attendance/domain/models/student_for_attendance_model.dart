class StudentForAttendanceModel {
  bool? status;
  String? message;
  List<StudentItem>? data;

  StudentForAttendanceModel({this.status, this.message, this.data});

  StudentForAttendanceModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <StudentItem>[];
      json['data'].forEach((v) {
        data!.add(StudentItem.fromJson(v));
      });
    }
  }

}

class StudentItem {
  int? id;
  String? userId;
  String? firstName;
  String? lastName;
  String? phone;
  String? registerNo;
  String? rollNo;
  String? group;
  String? fatherName;
  String? motherName;
  String? birthday;
  String? gender;
  String? bloodGroup;
  String? religion;
  String? address;
  String? state;
  String? country;
  String? studentId;
  String? classId;
  String? sectionId;
  String? sessionId;
  String? roll;
  bool? isPresent;


  StudentItem(
      {this.id,
        this.userId,
        this.firstName,
        this.lastName,
        this.phone,
        this.registerNo,
        this.rollNo,
        this.group,
        this.fatherName,
        this.motherName,
        this.birthday,
        this.gender,
        this.bloodGroup,
        this.religion,
        this.address,
        this.state,
        this.country,
        this.studentId,
        this.classId,
        this.sectionId,
        this.sessionId,
        this.roll,
        this.isPresent
        });

  StudentItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'].toString();
    firstName = json['first_name'];
    lastName = json['last_name'];
    phone = json['phone'];
    registerNo = json['register_no'].toString();
    rollNo = json['roll_no'].toString();
    group = json['group'].toString();
    fatherName = json['father_name'];
    motherName = json['mother_name'];
    birthday = json['birthday'];
    gender = json['gender'];
    bloodGroup = json['blood_group'];
    religion = json['religion'];
    address = json['address'];
    state = json['state'];
    country = json['country'];
    studentId = json['student_id'].toString();
    classId = json['class_id'].toString();
    sectionId = json['section_id'].toString();
    sessionId = json['session_id'].toString();
    roll = json['roll'].toString();
    isPresent = false;
  }
}
