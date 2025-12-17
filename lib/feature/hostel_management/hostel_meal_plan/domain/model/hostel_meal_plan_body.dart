class HostelMealPlanBody {
  String? name;
  String? description;
  String? planType;
  String? monthlyPrice;
  String? dailyPrice;
  String? status;
  String? hostelId;
  List<String>? mealIds;

  HostelMealPlanBody({
    this.name,
    this.description,
    this.planType,
    this.monthlyPrice,
    this.dailyPrice,
    this.status,
    this.hostelId,
    this.mealIds,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['description'] = description;
    data['plan_type'] = planType;
    data['monthly_price'] = monthlyPrice;
    data['daily_price'] = dailyPrice;
    data['status'] = status;
    data['hostel_id'] = hostelId;
    data['meal_ids'] = mealIds;
    return data;
  }
}
