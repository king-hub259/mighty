import '../../../../fees_management/smart_collection/domain/model/smart_collection_details_model.dart';

class FeesPaymentInfoReportModel {
  bool? status;
  String? message;
  List<FeesPaymentInfoItem>? data;

  FeesPaymentInfoReportModel({this.status, this.message, this.data});

  FeesPaymentInfoReportModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <FeesPaymentInfoItem>[];
      json['data'].forEach((v) {
        data!.add(FeesPaymentInfoItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FeesPaymentInfoItem {
  int? id;
  int? instituteId;
  int? branchId;
  int? studentId;
  int? classId;
  String? invoiceId;
  String? invoiceDate;
  int? sessionId;
  String? tcAmount;
  String? attendanceFine;
  String? quizFine;
  String? labFine;
  String? totalPayable;
  String? totalPaid;
  String? totalDue;
  String? note;
  int? ledgerId;
  int? receiveLedgerId;
  int? fundId;
  int? createdBy;
  String? createdAt;
  String? updatedAt;
  Student? student;
  List<Details>? details;

  FeesPaymentInfoItem(
      {this.id,
        this.instituteId,
        this.branchId,
        this.studentId,
        this.classId,
        this.invoiceId,
        this.invoiceDate,
        this.sessionId,
        this.tcAmount,
        this.attendanceFine,
        this.quizFine,
        this.labFine,
        this.totalPayable,
        this.totalPaid,
        this.totalDue,
        this.note,
        this.ledgerId,
        this.receiveLedgerId,
        this.fundId,
        this.createdBy,
        this.createdAt,
        this.updatedAt,
        this.student,
        this.details});

  FeesPaymentInfoItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    instituteId = json['institute_id'];
    branchId = json['branch_id'];
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
    note = json['note'];
    ledgerId = json['ledger_id'];
    receiveLedgerId = json['receive_ledger_id'];
    fundId = json['fund_id'];
    createdBy = json['created_by'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    student =
    json['student'] != null ? Student.fromJson(json['student']) : null;
    if (json['details'] != null) {
      details = <Details>[];
      json['details'].forEach((v) {
        details!.add(Details.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['institute_id'] = instituteId;
    data['branch_id'] = branchId;
    data['student_id'] = studentId;
    data['class_id'] = classId;
    data['invoice_id'] = invoiceId;
    data['invoice_date'] = invoiceDate;
    data['session_id'] = sessionId;
    data['tc_amount'] = tcAmount;
    data['attendance_fine'] = attendanceFine;
    data['quiz_fine'] = quizFine;
    data['lab_fine'] = labFine;
    data['total_payable'] = totalPayable;
    data['total_paid'] = totalPaid;
    data['total_due'] = totalDue;
    data['note'] = note;
    data['ledger_id'] = ledgerId;
    data['receive_ledger_id'] = receiveLedgerId;
    data['fund_id'] = fundId;
    data['created_by'] = createdBy;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (student != null) {
      data['student'] = student!.toJson();
    }
    if (details != null) {
      data['details'] = details!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}


class StudentSession {
  int? id;
  int? instituteId;
  int? branchId;
  int? sessionId;
  int? studentId;
  int? classId;
  int? sectionId;
  String? roll;
  ClassItem? classItem;
  Section? section;

  StudentSession(
      {this.id,
        this.instituteId,
        this.branchId,
        this.sessionId,
        this.studentId,
        this.classId,
        this.sectionId,
        this.roll,
        this.classItem,
        this.section});

  StudentSession.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    instituteId = json['institute_id'];
    branchId = json['branch_id'];
    sessionId = json['session_id'];
    studentId = json['student_id'];
    classId = json['class_id'];
    sectionId = json['section_id'];
    roll = json['roll'];
    classItem = json['class'] != null
        ? ClassItem.fromJson(json['class'])
        : null;
    section =
    json['section'] != null ? Section.fromJson(json['section']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['institute_id'] = instituteId;
    data['branch_id'] = branchId;
    data['session_id'] = sessionId;
    data['student_id'] = studentId;
    data['class_id'] = classId;
    data['section_id'] = sectionId;
    data['roll'] = roll;
    if (classItem != null) {
      data['class'] = classItem!.toJson();
    }
    if (section != null) {
      data['section'] = section!.toJson();
    }
    return data;
  }
}

class ClassItem {
  int? id;
  int? instituteId;
  int? branchId;
  String? className;
  int? status;
  String? createdAt;
  String? updatedAt;

  ClassItem(
      {this.id,
        this.instituteId,
        this.branchId,
        this.className,
        this.status,
        this.createdAt,
        this.updatedAt});

  ClassItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    instituteId = json['institute_id'];
    branchId = json['branch_id'];
    className = json['class_name'];
    status = json['status'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['institute_id'] = instituteId;
    data['branch_id'] = branchId;
    data['class_name'] = className;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

class Section {
  int? id;
  int? instituteId;
  int? branchId;
  int? classId;
  int? studentGroupId;
  String? sectionName;
  String? roomNo;


  Section(
      {this.id,
        this.instituteId,
        this.branchId,
        this.classId,
        this.studentGroupId,
        this.sectionName,
        this.roomNo,
      });

  Section.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    instituteId = json['institute_id'];
    branchId = json['branch_id'];
    classId = json['class_id'];
    studentGroupId = json['student_group_id'];
    sectionName = json['section_name'];
    roomNo = json['room_no'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['institute_id'] = instituteId;
    data['branch_id'] = branchId;
    data['class_id'] = classId;
    data['student_group_id'] = studentGroupId;
    data['section_name'] = sectionName;
    data['room_no'] = roomNo;
    return data;
  }
}

class Details {
  int? id;
  int? instituteId;
  int? branchId;
  int? studentId;
  int? sessionId;
  int? studentCollectionId;
  int? feeHeadId;
  int? ledgerId;
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

  Details(
      {this.id,
        this.instituteId,
        this.branchId,
        this.studentId,
        this.sessionId,
        this.studentCollectionId,
        this.feeHeadId,
        this.ledgerId,
        this.totalDue,
        this.totalPayable,
        this.totalPaid,
        this.waiver,
        this.finePayable,
        this.feePayable,
        this.feeAndFinePayable,
        this.feeAndFinePaid,
        this.previousDuePayable,
        this.previousDuePaid,
        this.createdAt,
        this.updatedAt,
        this.feeHead,
        this.subHeads});

  Details.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    instituteId = json['institute_id'];
    branchId = json['branch_id'];
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
    feeHead = json['fee_head'] != null
        ? FeeHead.fromJson(json['fee_head'])
        : null;
    if (json['sub_heads'] != null) {
      subHeads = <SubHeads>[];
      json['sub_heads'].forEach((v) {
        subHeads!.add(SubHeads.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['institute_id'] = instituteId;
    data['branch_id'] = branchId;
    data['student_id'] = studentId;
    data['session_id'] = sessionId;
    data['student_collection_id'] = studentCollectionId;
    data['fee_head_id'] = feeHeadId;
    data['ledger_id'] = ledgerId;
    data['total_due'] = totalDue;
    data['total_payable'] = totalPayable;
    data['total_paid'] = totalPaid;
    data['waiver'] = waiver;
    data['fine_payable'] = finePayable;
    data['fee_payable'] = feePayable;
    data['fee_and_fine_payable'] = feeAndFinePayable;
    data['fee_and_fine_paid'] = feeAndFinePaid;
    data['previous_due_payable'] = previousDuePayable;
    data['previous_due_paid'] = previousDuePaid;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (feeHead != null) {
      data['fee_head'] = feeHead!.toJson();
    }
    if (subHeads != null) {
      data['sub_heads'] = subHeads!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FeeHead {
  int? id;
  int? instituteId;
  int? branchId;
  String? name;
  int? serial;
  String? createdAt;
  String? updatedAt;
  List<FeeSubHeads>? feeSubHeads;

  FeeHead(
      {this.id,
        this.instituteId,
        this.branchId,
        this.name,
        this.serial,
        this.createdAt,
        this.updatedAt,
        this.feeSubHeads});

  FeeHead.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    instituteId = json['institute_id'];
    branchId = json['branch_id'];
    name = json['name'];
    serial = json['serial'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['fee_sub_heads'] != null) {
      feeSubHeads = <FeeSubHeads>[];
      json['fee_sub_heads'].forEach((v) {
        feeSubHeads!.add(FeeSubHeads.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['institute_id'] = instituteId;
    data['branch_id'] = branchId;
    data['name'] = name;
    data['serial'] = serial;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (feeSubHeads != null) {
      data['fee_sub_heads'] = feeSubHeads!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FeeSubHeads {
  int? id;
  int? instituteId;
  int? branchId;
  String? name;
  int? serial;

  FeeSubHeads(
      {this.id,
        this.instituteId,
        this.branchId,
        this.name,
        this.serial,});

  FeeSubHeads.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    instituteId = json['institute_id'];
    branchId = json['branch_id'];
    name = json['name'];
    serial = json['serial'];
    }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['institute_id'] = instituteId;
    data['branch_id'] = branchId;
    data['name'] = name;
    data['serial'] = serial;

    return data;
  }
}



class SubHeads {
  int? id;
  int? instituteId;
  int? branchId;
  int? studentId;
  int? sessionId;
  int? studentCollectionId;
  int? studentCollectionDetailsId;
  int? feeHeadId;
  int? subHeadId;
  String? createdAt;
  String? updatedAt;

  SubHeads(
      {this.id,
        this.instituteId,
        this.branchId,
        this.studentId,
        this.sessionId,
        this.studentCollectionId,
        this.studentCollectionDetailsId,
        this.feeHeadId,
        this.subHeadId,
        this.createdAt,
        this.updatedAt});

  SubHeads.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    instituteId = json['institute_id'];
    branchId = json['branch_id'];
    studentId = json['student_id'];
    sessionId = json['session_id'];
    studentCollectionId = json['student_collection_id'];
    studentCollectionDetailsId = json['student_collection_details_id'];
    feeHeadId = json['fee_head_id'];
    subHeadId = json['sub_head_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['institute_id'] = instituteId;
    data['branch_id'] = branchId;
    data['student_id'] = studentId;
    data['session_id'] = sessionId;
    data['student_collection_id'] = studentCollectionId;
    data['student_collection_details_id'] = studentCollectionDetailsId;
    data['fee_head_id'] = feeHeadId;
    data['sub_head_id'] = subHeadId;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
