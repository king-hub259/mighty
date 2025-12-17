class SignatureModel {
  bool? status;
  String? message;
  Data? data;


  SignatureModel({this.status, this.message, this.data});
  SignatureModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;

  }

}

class Data {
  int? currentPage;
  List<SignatureItem>? data;
  int? total;

  Data({this.currentPage, this.data, this.total});

  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <SignatureItem>[];
      json['data'].forEach((v) {
        data!.add(SignatureItem.fromJson(v));
      });
    }
    total = json['total'];
  }

}

class SignatureItem {
  int? id;
  String? placeAt;
  String? title;
  String? image;
  String? createdAt;
  String? updatedAt;

  SignatureItem(
      {this.id,
        this.placeAt,
        this.title,
        this.image,
        this.createdAt,
        this.updatedAt});

  SignatureItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    placeAt = json['place_at'];
    title = json['title'];
    image = json['image'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }


}


