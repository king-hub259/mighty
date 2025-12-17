class UnPaidReportModel {
  bool? status;
  String? message;
  UnPaidReportItem? data;


  UnPaidReportModel({this.status, this.message, this.data});

  UnPaidReportModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? UnPaidReportItem.fromJson(json['data']) : null;

  }

}

class UnPaidReportItem {
  String? sessionId;
  int? classId;
  int? sectionId;
  List<StudentData>? studentData;

  UnPaidReportItem({this.sessionId, this.classId, this.sectionId, this.studentData});

  UnPaidReportItem.fromJson(Map<String, dynamic> json) {
    sessionId = json['session_id'];
    classId = json['class_id'];
    sectionId = json['section_id'];
    if (json['studentData'] != null) {
      studentData = <StudentData>[];
      json['studentData'].forEach((v) {
        studentData!.add(StudentData.fromJson(v));
      });
    }
  }

}

class StudentData {
  int? id;
  String? name;
  String? roll;
  String? className;
  String? sectionName;
  List<FeeHeads>? feeHeads;
  int? totalPaidAmount;

  StudentData(
      {this.id,
        this.name,
        this.roll,
        this.className,
        this.sectionName,
        this.feeHeads,
        this.totalPaidAmount});

  StudentData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    roll = json['roll'];
    className = json['class_name'];
    sectionName = json['section_name'];
    if (json['feeHeads'] != null) {
      feeHeads = <FeeHeads>[];
      json['feeHeads'].forEach((v) {
        feeHeads!.add(FeeHeads.fromJson(v));
      });
    }
    totalPaidAmount = json['total_paid_amount'];
  }

}

class FeeHeads {
  int? id;
  String? name;
  List<FeeSubHeads>? feeSubHeads;

  FeeHeads({this.id, this.name, this.feeSubHeads});

  FeeHeads.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    if (json['feeSubHeads'] != null) {
      feeSubHeads = <FeeSubHeads>[];
      json['feeSubHeads'].forEach((v) {
        feeSubHeads!.add(FeeSubHeads.fromJson(v));
      });
    }
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    if (feeSubHeads != null) {
      data['feeSubHeads'] = feeSubHeads!.map((v) => v.toJson()).toList();
    }
    return data;
  }

}

class FeeSubHeads {
  int? id;
  String? name;
  Amount? amount;

  FeeSubHeads({this.id, this.name, this.amount});

  FeeSubHeads.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    amount =
    json['amount'] != null ? Amount.fromJson(json['amount']) : null;
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    if (amount != null) {
      data['amount'] = amount!.toJson();
    }
    return data;
  }
}

class Amount {
  int? studentId;
  int? totalDue;
  int? totalPaid;
  int? waiver;
  int? finePayable;
  int? feePayable;
  int? feeAndFinePayable;
  int? feeAndFinePaid;
  int? previousDuePayable;
  int? previousDuePaid;
  int? feeHeadId;
  int? totalPayable;
  bool? foundStudent;
  bool? foundFeeAmount;

  Amount(
      {this.studentId,
        this.totalDue,
        this.totalPaid,
        this.waiver,
        this.finePayable,
        this.feePayable,
        this.feeAndFinePayable,
        this.feeAndFinePaid,
        this.previousDuePayable,
        this.previousDuePaid,
        this.feeHeadId,
        this.totalPayable,
        this.foundStudent,
        this.foundFeeAmount});

  Amount.fromJson(Map<String, dynamic> json) {
    studentId = json['student_id'];
    totalDue = json['total_due'];
    totalPaid = json['total_paid'];
    waiver = json['waiver'];
    finePayable = json['fine_payable'];
    feePayable = json['fee_payable'];
    feeAndFinePayable = json['fee_and_fine_payable'];
    feeAndFinePaid = json['fee_and_fine_paid'];
    previousDuePayable = json['previous_due_payable'];
    previousDuePaid = json['previous_due_paid'];
    feeHeadId = json['fee_head_id'];
    totalPayable = json['total_payable'];
    foundStudent = json['found_student'];
    foundFeeAmount = json['found_fee_amount'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['student_id'] = studentId;
    data['total_due'] = totalDue;
    data['total_paid'] = totalPaid;
    data['waiver'] = waiver;
    data['fine_payable'] = finePayable;
    data['fee_payable'] = feePayable;
    data['fee_and_fine_payable'] = feeAndFinePayable;
    data['fee_and_fine_paid'] = feeAndFinePaid;
    data['previous_due_payable'] = previousDuePayable;
    data['previous_due_paid'] = previousDuePaid;
    data['fee_head_id'] = feeHeadId;
    data['total_payable'] = totalPayable;
    data['found_student'] = foundStudent;
    data['found_fee_amount'] = foundFeeAmount;
    return data;
  }

}
