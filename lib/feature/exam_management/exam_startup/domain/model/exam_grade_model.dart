class ExamGradeModel {
  bool? status;
  String? message;
  Data? data;


  ExamGradeModel({this.status, this.message, this.data});

  ExamGradeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;

  }


}

class Data {
  int? currentPage;
  List<ExamGradeItem>? data;
  int? total;

  Data({this.currentPage, this.data, this.total});

  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <ExamGradeItem>[];
      json['data'].forEach((v) {
        data!.add(ExamGradeItem.fromJson(v));
      });
    }
    total = json['total'];
  }

}

class ExamGradeItem {
  int? id;
  String? gradeName;
  String? gradeNumber;
  String? gradePoint;
  String? gradeRange;
  String? numberHigh;
  String? numberLow;
  String? pointHigh;
  String? pointLow;
  String? priority;
  String? createdAt;
  String? updatedAt;
  bool? isSelected;

  ExamGradeItem(
      {this.id,
        this.gradeName,
        this.gradeNumber,
        this.gradePoint,
        this.gradeRange,
        this.numberHigh,
        this.numberLow,
        this.pointHigh,
        this.pointLow,
        this.priority,
        this.createdAt,
        this.updatedAt,
      this.isSelected = false
      });

  ExamGradeItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    gradeName = json['grade_name'];
    gradeNumber = json['grade_number'];
    gradePoint = json['grade_point'];
    gradeRange = json['grade_range'];
    numberHigh = json['number_high'];
    numberLow = json['number_low'];
    pointHigh = json['point_high'];
    pointLow = json['point_low'];
    priority = json['priority'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    isSelected = json['is_selected']?? false;
  }


}


