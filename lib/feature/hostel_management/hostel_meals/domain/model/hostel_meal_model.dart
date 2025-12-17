

class HostelMealItem {
  int? id;
  int? instituteId;
  int? branchId;
  String? mealName;
  String? mealType;
  String? createdAt;
  String? updatedAt;

  HostelMealItem(
      {this.id,
        this.instituteId,
        this.branchId,
        this.mealName,
        this.mealType,
        this.createdAt,
        this.updatedAt});

  HostelMealItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    instituteId = json['institute_id'];
    branchId = json['branch_id'];
    mealName = json['meal_name'];
    mealType = json['meal_type'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['institute_id'] = instituteId;
    data['branch_id'] = branchId;
    data['meal_name'] = mealName;
    data['meal_type'] = mealType;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
