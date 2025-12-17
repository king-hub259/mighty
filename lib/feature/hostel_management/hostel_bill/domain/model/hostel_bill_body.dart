class HostelBillBody {
  String? billNumber;
  String? studentId;
  String? hostelId;
  String? billMonth;
  String? billYear;
  String? roomRent;
  String? mealCharges;
  String? otherCharges;
  String? totalAmount;
  String? paidAmount;
  String? dueAmount;
  String? status;
  String? dueDate;

  HostelBillBody({
    this.billNumber,
    this.studentId,
    this.hostelId,
    this.billMonth,
    this.billYear,
    this.roomRent,
    this.mealCharges,
    this.otherCharges,
    this.totalAmount,
    this.paidAmount,
    this.dueAmount,
    this.status,
    this.dueDate,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['bill_number'] = billNumber;
    data['student_id'] = studentId;
    data['hostel_id'] = hostelId;
    data['bill_month'] = billMonth;
    data['bill_year'] = billYear;
    data['room_rent'] = roomRent;
    data['meal_charges'] = mealCharges;
    data['other_charges'] = otherCharges;
    data['total_amount'] = totalAmount;
    data['paid_amount'] = paidAmount;
    data['due_amount'] = dueAmount;
    data['status'] = status;
    data['due_date'] = dueDate;
    return data;
  }
}
