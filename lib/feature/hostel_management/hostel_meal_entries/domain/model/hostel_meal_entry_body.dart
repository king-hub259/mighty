class HostelMealEntryBody {
  String? studentId;
  String? mealId;
  String? entryDate;
  String? mealTime;
  String? quantity;
  String? amount;
  String? status;

  HostelMealEntryBody({
    this.studentId,
    this.mealId,
    this.entryDate,
    this.mealTime,
    this.quantity,
    this.amount,
    this.status,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['student_id'] = studentId;
    data['meal_id'] = mealId;
    data['entry_date'] = entryDate;
    data['meal_time'] = mealTime;
    data['quantity'] = quantity;
    data['amount'] = amount;
    data['status'] = status;
    return data;
  }
}
