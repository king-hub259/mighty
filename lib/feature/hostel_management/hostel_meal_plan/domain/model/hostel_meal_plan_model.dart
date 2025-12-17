class HostelMealPlanItem {
  int? id;
  int? studentId;
  int? mealId;
  String? date;
  Student? student;
  Meal? meal;

  HostelMealPlanItem(
      {this.id,
        this.studentId,
        this.mealId,
        this.date,
        this.student,
        this.meal});

  HostelMealPlanItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    studentId = json['student_id'];
    mealId = json['meal_id'];
    date = json['date'];
    student =
    json['student'] != null ? new Student.fromJson(json['student']) : null;
    meal = json['meal'] != null ? new Meal.fromJson(json['meal']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['student_id'] = studentId;
    data['meal_id'] = mealId;
    data['date'] = date;
    if (student != null) {
      data['student'] = student!.toJson();
    }
    if (meal != null) {
      data['meal'] = meal!.toJson();
    }
    return data;
  }
}

class Student {
  int? id;
  String? firstName;

  Student({this.id, this.firstName});

  Student.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    firstName = json['first_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['first_name'] = firstName;
    return data;
  }
}

class Meal {
  int? id;
  String? mealName;

  Meal({this.id, this.mealName});

  Meal.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    mealName = json['meal_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['meal_name'] = mealName;
    return data;
  }
}