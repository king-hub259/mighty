class PaidReportModel {
  bool? status;
  String? message;
  List<PaidReportInfo>? data;

  PaidReportModel({this.status, this.message, this.data});

  PaidReportModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <PaidReportInfo>[];
      json['data'].forEach((v) { data!.add(PaidReportInfo.fromJson(v)); });
    }
  }

}

class PaidReportInfo {
  int? id;
  String? studentId;
  String? classId;
  String? invoiceId;
  String? invoiceDate;
  String? sessionId;
  String? tcAmount;
  String? attendanceFine;
  String? quizFine;
  String? labFine;
  String? totalPayable;
  String? totalPaid;
  String? totalDue;
  String? ledgerId;
  String? receiveLedgerId;
  String? fundId;
  String? createdBy;
  String? createdAt;
  String? updatedAt;
  Student? student;
  List<Details>? details;

  PaidReportInfo({this.id, this.studentId, this.classId, this.invoiceId, this.invoiceDate, this.sessionId, this.tcAmount,
    this.attendanceFine,
    this.quizFine, this.labFine,
    this.totalPayable,
    this.totalPaid, this.totalDue,
    this.ledgerId, this.receiveLedgerId, this.fundId,
    this.createdBy, this.createdAt, this.updatedAt,
    this.student, this.details});

  PaidReportInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    studentId = json['student_id'];
    classId = json['class_id'];
    invoiceId = json['invoice_id'];
    invoiceDate = json['invoice_date'];
    sessionId = json['session_id'];
    tcAmount = json['tc_amount'];
    attendanceFine = json['attendance_fine'];
    quizFine = json['quiz_fine'];
    labFine = json['lab_fine'];
    totalPayable = json['total_payable'];
    totalPaid = json['total_paid'];
    totalDue = json['total_due'];
    ledgerId = json['ledger_id'];
    receiveLedgerId = json['receive_ledger_id'];
    fundId = json['fund_id'];
    createdBy = json['created_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    student = json['student'] != null ? Student.fromJson(json['student']) : null;
    if (json['details'] != null) {
      details = <Details>[];
      json['details'].forEach((v) { details!.add(Details.fromJson(v)); });
    }
  }

}

class Student {
  int? id;
  String? userId;
  String? group;
  String? studentCategoryId;
  String? firstName;
  String? lastName;
  String? phone;
  String? registerNo;
  String? rollNo;
  String? fatherName;
  String? motherName;
  String? birthday;
  String? gender;
  String? bloodGroup;
  String? religion;
  String? address;
  String? status;
  String? nationality;
  String? createdAt;
  String? updatedAt;
  StudentSession? studentSession;

  Student({this.id,
    this.userId,
    this.group,
    this.studentCategoryId,
    this.firstName,
    this.lastName,
    this.phone,
    this.registerNo,
    this.rollNo,
    this.fatherName,
    this.motherName,
    this.birthday,
    this.gender,
    this.bloodGroup,
    this.religion,
    this.address,
    this.status,
    this.nationality,
    this.createdAt,
    this.updatedAt,
    this.studentSession});

  Student.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    group = json['group'];
    studentCategoryId = json['student_category_id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    phone = json['phone'];
    registerNo = json['register_no'];
    rollNo = json['roll_no'];
    fatherName = json['father_name'];
    motherName = json['mother_name'];
    birthday = json['birthday'];
    gender = json['gender'];
    bloodGroup = json['blood_group'];
    religion = json['religion'];
    address = json['address'];
    status = json['status'];
    nationality = json['nationality'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    studentSession = json['student_session'] != null ? StudentSession.fromJson(json['student_session']) : null;
  }

}

class StudentSession {
  int? id;
  String? sessionId;
  String? studentId;
  String? classId;
  String? sectionId;
  String? roll;
  String? createdAt;
  String? updatedAt;
  ClassInfo? classInfo;

  StudentSession({this.id, this.sessionId, this.studentId, this.classId, this.sectionId, this.roll, this.createdAt, this.updatedAt, this.classInfo});

  StudentSession.fromJson(Map<String, dynamic> json) {
  id = json['id'];
  sessionId = json['session_id'];
  studentId = json['student_id'];
  classId = json['class_id'];
  sectionId = json['section_id'];
  roll = json['roll'];
  createdAt = json['created_at'];
  updatedAt = json['updated_at'];
  classInfo = json['class'] != null ? ClassInfo.fromJson(json['class']) : null;
  }

}

class ClassInfo {
  int? id;
  String? className;
  String? status;
  String? createdAt;
  String? updatedAt;

  ClassInfo({this.id, this.className, this.status, this.createdAt, this.updatedAt});

  ClassInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    className = json['class_name'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

}

class Details {
  int? id;
  String? studentId;
  String? sessionId;
  String? studentCollectionId;
  String? feeHeadId;
  String? ledgerId;
  String? totalDue;
  String? totalPayable;
  String? totalPaid;
  String? waiver;
  String? finePayable;
  String? feePayable;
  String? feeAndFinePayable;
  String? feeAndFinePaid;
  String? previousDuePayable;
  String? previousDuePaid;
  String? createdAt;
  String? updatedAt;
  FeeHead? feeHead;
  List<SubHeads>? subHeads;

  Details({this.id, this.studentId, this.sessionId, this.studentCollectionId, this.feeHeadId, this.ledgerId, this.totalDue, this.totalPayable, this.totalPaid, this.waiver, this.finePayable, this.feePayable, this.feeAndFinePayable, this.feeAndFinePaid, this.previousDuePayable, this.previousDuePaid, this.createdAt, this.updatedAt, this.feeHead, this.subHeads});

  Details.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    studentId = json['student_id'];
    sessionId = json['session_id'];
    studentCollectionId = json['student_collection_id'];
    feeHeadId = json['fee_head_id'];
    ledgerId = json['ledger_id'];
    totalDue = json['total_due'];
    totalPayable = json['total_payable'];
    totalPaid = json['total_paid'];
    waiver = json['waiver'];
    finePayable = json['fine_payable'];
    feePayable = json['fee_payable'];
    feeAndFinePayable = json['fee_and_fine_payable'];
    feeAndFinePaid = json['fee_and_fine_paid'];
    previousDuePayable = json['previous_due_payable'];
    previousDuePaid = json['previous_due_paid'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    feeHead = json['fee_head'] != null ? FeeHead.fromJson(json['fee_head']) : null;
    if (json['sub_heads'] != null) {
      subHeads = <SubHeads>[];
      json['sub_heads'].forEach((v) { subHeads!.add(SubHeads.fromJson(v)); });
    }
  }


}

class FeeHead {
  int? id;
  String? name;
  String? serial;
  String? createdAt;
  String? updatedAt;
  List<FeeSubHeads>? feeSubHeads;

  FeeHead({this.id, this.name, this.serial, this.createdAt, this.updatedAt, this.feeSubHeads});

  FeeHead.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    serial = json['serial'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['fee_sub_heads'] != null) {
      feeSubHeads = <FeeSubHeads>[];
      json['fee_sub_heads'].forEach((v) { feeSubHeads!.add(FeeSubHeads.fromJson(v)); });
    }
  }


}

class FeeSubHeads {
  int? id;
  String? name;
  String? serial;
  String? createdAt;
  String? updatedAt;


  FeeSubHeads({this.id, this.name, this.serial, this.createdAt, this.updatedAt});

  FeeSubHeads.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    serial = json['serial'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];

  }


}



class SubHeads {
  int? id;
  String? studentId;
  String? sessionId;
  String? studentCollectionId;
  String? studentCollectionDetailsId;
  String? feeHeadId;
  String? subHeadId;
  String? createdAt;
  String? updatedAt;

  SubHeads({this.id, this.studentId, this.sessionId, this.studentCollectionId, this.studentCollectionDetailsId, this.feeHeadId, this.subHeadId, this.createdAt, this.updatedAt});

  SubHeads.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    studentId = json['student_id'];
    sessionId = json['session_id'];
    studentCollectionId = json['student_collection_id'];
    studentCollectionDetailsId = json['student_collection_details_id'];
    feeHeadId = json['fee_head_id'];
    subHeadId = json['sub_head_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }


}
