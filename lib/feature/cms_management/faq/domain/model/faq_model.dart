class FaqModel {
  bool? status;
  String? message;
  Data? data;

  FaqModel({this.status, this.message, this.data});

  FaqModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? currentPage;
  List<FaqItem>? data;
  int? total;

  Data({this.currentPage, this.data, this.total});

  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <FaqItem>[];
      json['data'].forEach((v) {
        data!.add(FaqItem.fromJson(v));
      });
    }
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['current_page'] = currentPage;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['total'] = total;
    return data;
  }
}

class FaqItem {
  int? id;
  int? instituteId;
  String? question;
  String? answer;
  int? status;
  String? createdAt;

  FaqItem(
      {this.id,
        this.instituteId,
        this.question,
        this.answer,
        this.status,
        this.createdAt});

  FaqItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    instituteId = json['institute_id'];
    question = json['question'];
    answer = json['answer'];
    status = json['status'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['institute_id'] = instituteId;
    data['question'] = question;
    data['answer'] = answer;
    data['status'] = status;
    data['created_at'] = createdAt;
    return data;
  }
}

