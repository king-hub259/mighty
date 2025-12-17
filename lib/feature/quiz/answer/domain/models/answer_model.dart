class AnswerModel {
  bool? status;
  String? message;
  Data? data;

  AnswerModel({this.status, this.message, this.data});
  AnswerModel.fromJson(Map<String, dynamic> json) {
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
  List<AnswerItem>? data;
  int? total;

  Data(
      {this.currentPage,
        this.data,
        this.total});

  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <AnswerItem>[];
      json['data'].forEach((v) {
        data!.add(AnswerItem.fromJson(v));
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

class AnswerItem {
  int? id;
  String? topicId;
  String? userId;
  String? questionId;
  String? userAnswer;
  String? answer;
  String? createdAt;
  String? updatedAt;

  AnswerItem(
      {this.id,
        this.topicId,
        this.userId,
        this.questionId,
        this.userAnswer,
        this.answer,
        this.createdAt,
        this.updatedAt});

  AnswerItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    topicId = json['topic_id'].toString();
    userId = json['user_id'].toString();
    questionId = json['question_id'].toString();
    userAnswer = json['user_answer'];
    answer = json['answer'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['topic_id'] = topicId;
    data['user_id'] = userId;
    data['question_id'] = questionId;
    data['user_answer'] = userAnswer;
    data['answer'] = answer;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}

