class PhoneBookBody {
  String? name;
  String? phone;
  int? categoryId;
  String? note;

  PhoneBookBody({this.name, this.phone, this.categoryId, this.note});

  PhoneBookBody.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    phone = json['phone'];
    categoryId = json['category_id'];
    note = json['note'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['phone'] = phone;
    data['category_id'] = categoryId;
    data['note'] = note;
    return data;
  }
}
