class QuizTopicBody {
  String? title;
  String? perQMark;
  String? timer;
  String? amount;
  String? showAns;
  String? description;
  String? method;

  QuizTopicBody(
      {this.title,
        this.perQMark,
        this.timer,
        this.amount,
        this.showAns,
        this.description,
        this.method
      });

  QuizTopicBody.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    perQMark = json['per_q_mark'];
    timer = json['timer'];
    amount = json['amount'];
    showAns = json['show_ans'];
    description = json['description'];
    method = json['_method'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['per_q_mark'] = perQMark;
    data['timer'] = timer;
    data['amount'] = amount;
    data['show_ans'] = showAns;
    data['description'] = description;
    data['_method'] = method;
    return data;
  }
}
