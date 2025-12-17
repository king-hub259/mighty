class PhoneBookCategoryModel {
  bool? status;
  String? message;
  List<PhoneBookCategoryItem>? data;


  PhoneBookCategoryModel({this.status, this.message, this.data});

  PhoneBookCategoryModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <PhoneBookCategoryItem>[];
      json['data'].forEach((v) {
        data!.add(PhoneBookCategoryItem.fromJson(v));
      });
    }

  }

}

class PhoneBookCategoryItem {
  int? id;
  String? name;
  String? description;
  String? active;
  String? createdAt;
  String? updatedAt;

  PhoneBookCategoryItem(
      {this.id,
        this.name,
        this.description,
        this.active,
        this.createdAt,
        this.updatedAt});

  PhoneBookCategoryItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    active = json['active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

}
