class ZoomBody {
  String? topic;
  String? startTime;
  int? duration;
  String? password;
  String? agenda;

  ZoomBody(
      {this.topic, this.startTime, this.duration, this.password, this.agenda});

  ZoomBody.fromJson(Map<String, dynamic> json) {
    topic = json['topic'];
    startTime = json['start_time'];
    duration = json['duration'];
    password = json['password'];
    agenda = json['agenda'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['topic'] = topic;
    data['start_time'] = startTime;
    data['duration'] = duration;
    data['password'] = password;
    data['agenda'] = agenda;
    return data;
  }
}
