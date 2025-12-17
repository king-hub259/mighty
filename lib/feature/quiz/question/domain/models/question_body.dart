class QuestionBody {
  int? topicId;
  String? question;
  String? answer;
  String? a;
  String? b;
  String? c;
  String? d;
  String? codeSnippet;
  String? answerExp;
  String? questionVideoLink;

  QuestionBody(
      {this.topicId,
        this.question,
        this.answer,
        this.a,
        this.b,
        this.c,
        this.d,
        this.codeSnippet,
        this.answerExp,
        this.questionVideoLink});

  QuestionBody.fromJson(Map<String, dynamic> json) {
    topicId = json['topic_id'];
    question = json['question'];
    answer = json['answer'];
    a = json['a'];
    b = json['b'];
    c = json['c'];
    d = json['d'];
    codeSnippet = json['code_snippet'];
    answerExp = json['answer_exp'];
    questionVideoLink = json['question_video_link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['topic_id'] = topicId;
    data['question'] = question;
    data['answer'] = answer;
    data['a'] = a;
    data['b'] = b;
    data['c'] = c;
    data['d'] = d;
    data['code_snippet'] = codeSnippet;
    data['answer_exp'] = answerExp;
    data['question_video_link'] = questionVideoLink;
    return data;
  }
}
