class QuizTopicModel {
  bool? status;
  String? message;
  Data? data;


  QuizTopicModel({this.status, this.message, this.data});

  QuizTopicModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;

  }

}

class Data {
  int? currentPage;
  List<QuizTopicItem>? data;
  int? total;

  Data(
      {this.currentPage,
        this.data,
        this.total});

  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <QuizTopicItem>[];
      json['data'].forEach((v) {
        data!.add(QuizTopicItem.fromJson(v));
      });
    }
    total = json['total'];
  }

}

class QuizTopicItem {
  int? id;
  String? title;
  String? description;
  String? perQMark;
  String? timer;
  String? showAns;
  String? amount;
  String? createdAt;
  String? updatedAt;

  QuizTopicItem(
      {this.id,
        this.title,
        this.description,
        this.perQMark,
        this.timer,
        this.showAns,
        this.amount,
        this.createdAt,
        this.updatedAt});

  QuizTopicItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    perQMark = json['per_q_mark'].toString();
    timer = json['timer'].toString();
    showAns = json['show_ans'].toString();
    amount = json['amount'].toString();
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

}

