class PhoneBookModel {
  bool? status;
  String? message;
  List<PhoneBookItem>? data;


  PhoneBookModel({this.status, this.message, this.data});

  PhoneBookModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <PhoneBookItem>[];
      json['data'].forEach((v) {
        data!.add(PhoneBookItem.fromJson(v));
      });
    }
  }
}

class PhoneBookItem {
  int? id;
  String? name;
  String? phone;
  String? categoryId;
  String? note;
  String? createdAt;
  String? updatedAt;
  Category? category;

  PhoneBookItem(
      {this.id,
        this.name,
        this.phone,
        this.categoryId,
        this.note,
        this.createdAt,
        this.updatedAt,
        this.category});

  PhoneBookItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    categoryId = json['category_id'];
    note = json['note'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    category = json['category'] != null ? Category.fromJson(json['category']) : null;
  }

}

class Category {
  int? id;
  String? name;
  String? description;
  String? active;
  String? createdAt;
  String? updatedAt;

  Category(
      {this.id,
        this.name,
        this.description,
        this.active,
        this.createdAt,
        this.updatedAt});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    active = json['active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

}
