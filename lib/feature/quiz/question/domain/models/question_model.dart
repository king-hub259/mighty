class QuestionModel {
  bool? status;
  String? message;
  QuestionItem? data;


  QuestionModel({this.status, this.message, this.data});

  QuestionModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? QuestionItem.fromJson(json['data']) : null;

  }


}

class QuestionItem {
  Topic? topic;
  List<Questions>? questions;

  QuestionItem({this.topic, this.questions});

  QuestionItem.fromJson(Map<String, dynamic> json) {
    topic = json['topic'] != null ? Topic.fromJson(json['topic']) : null;
    if (json['questions'] != null) {
      questions = <Questions>[];
      json['questions'].forEach((v) {
        questions!.add(Questions.fromJson(v));
      });
    }
  }

}

class Topic {
  int? id;
  String? title;
  String? description;
  String? perQMark;
  String? timer;
  String? showAns;
  String? amount;
  String? createdAt;
  String? updatedAt;

  Topic(
      {this.id,
        this.title,
        this.description,
        this.perQMark,
        this.timer,
        this.showAns,
        this.amount,
        this.createdAt,
        this.updatedAt});

  Topic.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    perQMark = json['per_q_mark'].toString();
    timer = json['timer'];
    showAns = json['show_ans'];
    amount = json['amount'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

}

class Questions {
  int? id;
  String? topicId;
  String? question;
  String? a;
  String? b;
  String? c;
  String? d;
  String? answer;
  String? codeSnippet;
  String? answerExp;
  String? createdAt;
  String? updatedAt;
  String? questionImg;
  String? questionVideoLink;

  Questions(
      {this.id,
        this.topicId,
        this.question,
        this.a,
        this.b,
        this.c,
        this.d,
        this.answer,
        this.codeSnippet,
        this.answerExp,
        this.createdAt,
        this.updatedAt,
        this.questionImg,
        this.questionVideoLink});

  Questions.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    topicId = json['topic_id'];
    question = json['question'];
    a = json['a'];
    b = json['b'];
    c = json['c'];
    d = json['d'];
    answer = json['answer'];
    codeSnippet = json['code_snippet'];
    answerExp = json['answer_exp'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    questionImg = json['question_img'];
    questionVideoLink = json['question_video_link'];
  }

}
