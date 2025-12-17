class StudentQuizModel {
  bool? status;
  String? message;
  QuizItem? data;

  StudentQuizModel({this.status, this.message, this.data,});
  StudentQuizModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? QuizItem.fromJson(json['data']) : null;
  }

}

class QuizItem {
  List<Topics>? topics;
  List<Questions>? questions;

  QuizItem({this.topics, this.questions});

  QuizItem.fromJson(Map<String, dynamic> json) {
    if (json['topics'] != null) {
      topics = <Topics>[];
      json['topics'].forEach((v) {
        topics!.add(Topics.fromJson(v));
      });
    }
    if (json['questions'] != null) {
      questions = <Questions>[];
      json['questions'].forEach((v) {
        questions!.add(Questions.fromJson(v));
      });
    }
  }
}

class Topics {
  int? id;
  String? title;
  String? description;
  String? perQMark;
  String? timer;
  String? showAns;
  String? amount;

  Topics(
      {this.id,
        this.title,
        this.description,
        this.perQMark,
        this.timer,
        this.showAns,
        this.amount});

  Topics.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    perQMark = json['per_q_mark'].toString();
    timer = json['timer'].toString();
    showAns = json['show_ans'].toString();
    amount = json['amount'].toString();
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
        this.answerExp});

  Questions.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    topicId = json['topic_id'].toString();
    question = json['question'].toString();
    a = json['a'];
    b = json['b'];
    c = json['c'];
    d = json['d'];
    answer = json['answer'];
    codeSnippet = json['code_snippet'];
    answerExp = json['answer_exp'];
  }
}
