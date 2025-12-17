class FeedbackBody {
  String? name;
  String? university;
  String? rank;
  String? description;
  String? videoUrl;
  String? method;

  FeedbackBody(
      {this.name, this.university, this.rank, this.description, this.videoUrl, this.method});

  FeedbackBody.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    university = json['university'];
    rank = json['rank'];
    description = json['description'];
    videoUrl = json['video_url'];
    method = json['_method'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['university'] = university;
    data['rank'] = rank;
    data['description'] = description;
    data['video_url'] = videoUrl;
    data['_method'] = method;
    return data;
  }
}
