class ShiftModel {
  bool? status;
  String? message;
  List<ShiftItem>? data;


  ShiftModel({this.status, this.message, this.data});

  ShiftModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <ShiftItem>[];
      json['data'].forEach((v) {
        data!.add(ShiftItem.fromJson(v));
      });
    }
  }

}

class ShiftItem {
  int? id;
  String? name;
  String? createdAt;
  String? updatedAt;

  ShiftItem({this.id, this.name, this.createdAt, this.updatedAt});

  ShiftItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }


}
