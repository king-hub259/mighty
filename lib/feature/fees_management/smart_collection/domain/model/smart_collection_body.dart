class SmartCollectionBody {
  String? studentId;
  List<FeeHead>? feeHeads;
  double? attendanceFine;
  double? quizFine;
  double? labFine;
  String? totalPaid;
  String? totalPayable;
  String? smsStatus;
  double? tcAmount;
  String? date;
  int? ledgerId;
  String? note;

  SmartCollectionBody(
      {this.studentId,
        this.feeHeads,
        this.attendanceFine,
        this.quizFine,
        this.labFine,
        this.totalPaid,
        this.totalPayable,
        this.smsStatus,
        this.tcAmount,
        this.date,
        this.ledgerId,
        this.note});

  SmartCollectionBody.fromJson(Map<String, dynamic> json) {
    studentId = json['student_id'];
    if (json['fee_heads'] != null) {
      feeHeads = <FeeHead>[];
      json['fee_heads'].forEach((v) {
        feeHeads!.add(FeeHead.fromJson(v));
      });
    }
    attendanceFine = json['attendance_fine'];
    quizFine = json['quiz_fine'];
    labFine = json['lab_fine'];
    totalPaid = json['total_paid'];
    totalPayable = json['total_payable'];
    smsStatus = json['sms_status'];
    tcAmount = json['tc_amount'];
    date = json['date'];
    ledgerId = json['ledger_id'];
    note = json['note'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['student_id'] = studentId;
    if (feeHeads != null) {
      data['fee_heads'] = feeHeads!.map((v) => v.toJson()).toList();
    }
    data['attendance_fine'] = attendanceFine;
    data['quiz_fine'] = quizFine;
    data['lab_fine'] = labFine;
    data['total_paid'] = totalPaid;
    data['total_payable'] = totalPayable;
    data['sms_status'] = smsStatus;
    data['tc_amount'] = tcAmount;
    data['date'] = date;
    data['ledger_id'] = ledgerId;
    data['note'] = note;
    return data;
  }
}

class FeeHead {
  String? feeHeadId;
  List<int>? subHeadIds;
  String? totalPaid;
  String? waiver;
  String? finePayable;
  String? feePayable;
  String? feeAndFinePayable;
  String? previousDuePayable;
  String? previousDuePaid;
  String? totalPayable;

  FeeHead(
      {this.feeHeadId,
        this.subHeadIds,
        this.totalPaid,
        this.waiver,
        this.finePayable,
        this.feePayable,
        this.feeAndFinePayable,
        this.previousDuePayable,
        this.previousDuePaid,
        this.totalPayable});

  FeeHead.fromJson(Map<String, dynamic> json) {
    feeHeadId = json['fee_head_id'];
    subHeadIds = json['sub_head_ids'].cast<int>();
    totalPaid = json['total_paid'];
    waiver = json['waiver'];
    finePayable = json['fine_payable'];
    feePayable = json['fee_payable'];
    feeAndFinePayable = json['fee_and_fine_payable'];
    previousDuePayable = json['previous_due_payable'];
    previousDuePaid = json['previous_due_paid'];
    totalPayable = json['total_payable'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['fee_head_id'] = feeHeadId;
    data['sub_head_ids'] = subHeadIds;
    data['total_paid'] = totalPaid;
    data['waiver'] = waiver;
    data['fine_payable'] = finePayable;
    data['fee_payable'] = feePayable;
    data['fee_and_fine_payable'] = feeAndFinePayable;
    data['previous_due_payable'] = previousDuePayable;
    data['previous_due_paid'] = previousDuePaid;
    data['total_payable'] = totalPayable;
    return data;
  }
}
