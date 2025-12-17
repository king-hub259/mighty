class SmartCollectionModel {
  bool? status;
  String? message;
  Data? data;


  SmartCollectionModel({this.status, this.message, this.data});

  SmartCollectionModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  
}

class Data {
  int? sectionId;
  int? classId;
  Students? students;

  Data({this.sectionId, this.classId, this.students});

  Data.fromJson(Map<String, dynamic> json) {
    sectionId = json['sectionId'];
    classId = json['classId'];
    students = json['students'] != null ? Students.fromJson(json['students']) : null;
  }
  
}

class Students {
  int? currentPage;
  List<StudentItem>? data;
  int? total;

  Students(
      {this.currentPage,
        this.data,
        this.total});

  Students.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <StudentItem>[];
      json['data'].forEach((v) {
        data!.add(StudentItem.fromJson(v));
      });
    }
    total = json['total'];
  }
  
}

class StudentItem {
  int? id;
  String? roll;
  String? name;
  String? className;
  String? sectionName;
  String? groupName;
  bool? loading;

  StudentItem(
      {this.id,
        this.roll,
        this.name,
        this.className,
        this.sectionName,
        this.groupName,
        this.loading
      });

  StudentItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    roll = json['roll'];
    name = json['name'];
    className = json['class_name'];
    sectionName = json['section_name'];
    groupName = json['group_name'];
    loading = false;
  }
}

