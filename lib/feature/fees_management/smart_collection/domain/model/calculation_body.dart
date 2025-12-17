import 'package:mighty_school/helper/price_converter.dart';

class CalculationModel {
  int? feeHeadId;
  List<int>? feeSubHeads;
  Amounts? amounts;

  CalculationModel({this.feeHeadId, this.feeSubHeads, this.amounts});

  CalculationModel.fromJson(Map<String, dynamic> json) {
    feeHeadId = json['fee_head_id'];
    feeSubHeads = json['fee_sub_heads'].cast<int>();
    amounts = json['amounts'] != null ? Amounts.fromJson(json['amounts']) : null;
  }

}

class Amounts {
  int? studentId;
  double? totalDue;
  double? totalPaid;
  double? waiver;
  double? finePayable;
  double? feePayable;
  double? feeAndFinePayable;
  double? feeAndFinePaid;
  double? previousDuePayable;
  double? previousDuePaid;
  double? totalPayable;
  bool? foundStudent;
  bool? foundFeeAmount;

  Amounts(
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
        this.totalPayable,
        this.foundStudent,
        this.foundFeeAmount});

  Amounts.fromJson(Map<String, dynamic> json) {
    studentId = json['student_id'];
    totalDue = PriceConverter.parseAmount(json['total_due']);
    totalPaid = PriceConverter.parseAmount(json['total_paid']);
    waiver = PriceConverter.parseAmount(json['waiver']);
    finePayable = PriceConverter.parseAmount(json['fine_payable']);
    feePayable = PriceConverter.parseAmount(json['fee_payable']);
    feeAndFinePayable = PriceConverter.parseAmount(json['fee_and_fine_payable']);
    feeAndFinePaid = PriceConverter.parseAmount(json['fee_and_fine_paid']);
    previousDuePayable = PriceConverter.parseAmount(json['previous_due_payable']);
    previousDuePaid = PriceConverter.parseAmount(json['previous_due_paid']);
    totalPayable = PriceConverter.parseAmount(json['total_payable']);
    foundStudent = json['found_student'];
    foundFeeAmount = json['found_fee_amount'];
  }

}
