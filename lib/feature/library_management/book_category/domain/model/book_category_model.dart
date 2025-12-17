class BookCategoryModel {
  bool? status;
  String? message;
  Data? data;


  BookCategoryModel({this.status, this.message, this.data});

  BookCategoryModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

}

class Data {
  int? currentPage;
  List<BookCategoryItem>? data;
  int? total;

  Data({this.currentPage, this.data, this.total});

  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <BookCategoryItem>[];
      json['data'].forEach((v) {
        data!.add(BookCategoryItem.fromJson(v));
      });
    }
    total = json['total'];
  }
}

class BookCategoryItem {
  int? id;
  String? categoryName;
  String? createdAt;
  String? updatedAt;

  BookCategoryItem({this.id, this.categoryName, this.createdAt, this.updatedAt});

  BookCategoryItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryName = json['category_name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

}

