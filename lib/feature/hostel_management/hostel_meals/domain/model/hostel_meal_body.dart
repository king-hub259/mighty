class HostelMealBody {
  String? name;
  String? description;
  String? mealType;
  String? price;
  String? status;
  String? hostelId;

  HostelMealBody({
    this.name,
    this.description,
    this.mealType,
    this.price,
    this.status,
    this.hostelId,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['description'] = description;
    data['meal_type'] = mealType;
    data['price'] = price;
    data['status'] = status;
    data['hostel_id'] = hostelId;
    return data;
  }
}
