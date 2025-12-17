
import 'package:mighty_school/feature/hostel_management/hostel_meal_plan/domain/model/hostel_meal_plan_model.dart';
class HostelMealEntryItem {
  int? id;
  int? studentId;
  int? mealId;
  String? date;
  String? mealPrice;
  Student? student;
  Meal? meal;

  HostelMealEntryItem(
      {this.id,
        this.studentId,
        this.mealId,
        this.date,
        this.mealPrice,
        this.student,
        this.meal});

  HostelMealEntryItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    studentId = json['student_id'];
    mealId = json['meal_id'];
    date = json['date'];
    mealPrice = json['meal_price'];
    student =
    json['student'] != null ? Student.fromJson(json['student']) : null;
    meal = json['meal'] != null ? Meal.fromJson(json['meal']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['student_id'] = studentId;
    data['meal_id'] = mealId;
    data['date'] = date;
    data['meal_price'] = mealPrice;
    if (student != null) {
      data['student'] = student!.toJson();
    }
    if (meal != null) {
      data['meal'] = meal!.toJson();
    }
    return data;
  }
}
