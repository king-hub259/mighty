class SmsTemplateModel {
  bool? status;
  String? message;
  List<SmsTemplateItem>? data;

  SmsTemplateModel({this.status, this.message, this.data});

  SmsTemplateModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <SmsTemplateItem>[];
      json['data'].forEach((v) {
        data!.add(SmsTemplateItem.fromJson(v));
      });
    }
  }
}

class SmsTemplateItem {
  int? id;
  String? name;
  String? description;
  String? active;
  String? createdAt;
  String? updatedAt;

  SmsTemplateItem(
      {this.id,
        this.name,
        this.description,
        this.active,
        this.createdAt,
        this.updatedAt});

  SmsTemplateItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    active = json['active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }
}
