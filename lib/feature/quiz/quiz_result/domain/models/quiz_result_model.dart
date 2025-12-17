class QuizResultModel {
  bool? status;
  String? message;
  Data? data;


  QuizResultModel({this.status, this.message, this.data});

  QuizResultModel.fromJson(Map<String, dynamic> json) {
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
  List<QuizResulItem>? data;
  int? total;

  Data(
      {this.currentPage,
        this.data,
        this.total});

  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <QuizResulItem>[];
      json['data'].forEach((v) {
        data!.add(QuizResulItem.fromJson(v));
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

class QuizResulItem {
  int? id;
  String? title;
  String? description;
  String? perQMark;
  String? timer;
  String? showAns;
  String? amount;
  String? createdAt;
  String? updatedAt;
  String? questionsCount;

  QuizResulItem(
      {this.id,
        this.title,
        this.description,
        this.perQMark,
        this.timer,
        this.showAns,
        this.amount,
        this.createdAt,
        this.updatedAt,
        this.questionsCount});

  QuizResulItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    perQMark = json['per_q_mark'];
    timer = json['timer'];
    showAns = json['show_ans'];
    amount = json['amount'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    questionsCount = json['questions_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['description'] = description;
    data['per_q_mark'] = perQMark;
    data['timer'] = timer;
    data['show_ans'] = showAns;
    data['amount'] = amount;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['questions_count'] = questionsCount;
    return data;
  }
}

