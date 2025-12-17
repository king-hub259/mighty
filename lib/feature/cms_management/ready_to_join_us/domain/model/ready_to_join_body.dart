class ReadyToJoinBody {
  String? title;
  String? description;
  String? buttonName;
  String? buttonLink;
  String? method;

  ReadyToJoinBody({this.title, this.description, this.buttonName, this.buttonLink, this.method});

  ReadyToJoinBody.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    description = json['description'];
    buttonName = json['button_name'];
    buttonLink = json['button_link'];
    method = json['_method'];
  }

  Map<String, String> toJson() {
    final Map<String, String> data = <String, String>{};
    data['title'] = title??'';
    data['description'] = description??'';
    data['button_name'] = buttonName??'';
    data['button_link'] = buttonLink??'';
    data['_method'] = method??'';
    return data;
  }
}
