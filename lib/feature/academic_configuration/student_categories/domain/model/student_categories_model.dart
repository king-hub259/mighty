class StudentCategoriesModel {
  bool? status;
  String? message;
  Data? data;

  StudentCategoriesModel({this.status, this.message, this.data});

  StudentCategoriesModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

}

class Data {
  int? currentPage;
  List<StudentCategoryItem>? data;
  int? total;

  Data(
      {this.currentPage,
        this.data,
        this.total});

  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <StudentCategoryItem>[];
      json['data'].forEach((v) {
        data!.add(StudentCategoryItem.fromJson(v));
      });
    }
    total = json['total'];
  }


}

class StudentCategoryItem {
  int? id;
  String? name;

  StudentCategoryItem({this.id, this.name});

  StudentCategoryItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }
}


