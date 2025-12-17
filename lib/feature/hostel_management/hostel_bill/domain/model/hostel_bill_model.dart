import 'package:mighty_school/feature/hostel_management/hostel_meal_plan/domain/model/hostel_meal_plan_model.dart';
import 'package:mighty_school/helper/price_converter.dart';
class HostelBillItem {
  int? id;
  int? studentId;
  double? totalAmount;
  double? hostelFee;
  double? mealFee;
  String? dueDate;
  Student? student;

  HostelBillItem(
      {this.id,
        this.studentId,
        this.totalAmount,
        this.hostelFee,
        this.mealFee,
        this.dueDate,
        this.student});

  HostelBillItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    studentId = json['student_id'];
    totalAmount = PriceConverter.parseAmount( json['total_amount']);
    hostelFee = PriceConverter.parseAmount(json['hostel_fee']);
    mealFee = PriceConverter.parseAmount(json['meal_fee']);
    dueDate = json['due_date'];
    student =
    json['student'] != null ? Student.fromJson(json['student']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['student_id'] = studentId;
    data['total_amount'] = totalAmount;
    data['hostel_fee'] = hostelFee;
    data['meal_fee'] = mealFee;
    data['due_date'] = dueDate;
    if (student != null) {
      data['student'] = student!.toJson();
    }
    return data;
  }
}
