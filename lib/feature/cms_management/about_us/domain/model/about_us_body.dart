class AboutUsBody {
  String? title;
  String? description;
  String? method;

  AboutUsBody({this.title, this.description, this.method});

  AboutUsBody.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'].cast<String>();
    method = json['_method'];
  }

  Map<String, String> toJson() {
    final Map<String, String> data = <String, String>{};
    data['title'] = title??'';
    data['description'] = description??'';
    data['_method'] = method??'';
    return data;
  }
}
