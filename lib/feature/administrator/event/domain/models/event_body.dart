class EventBody {
  String? startDate;
  String? endDate;
  String? name;
  String? details;
  String? location;
  String? sMethod;

  EventBody(
      {this.startDate, this.endDate, this.name, this.details, this.location, this.sMethod});

  EventBody.fromJson(Map<String, dynamic> json) {
    startDate = json['start_date'];
    endDate = json['end_date'];
    name = json['name'];
    details = json['details'];
    location = json['location'];
    sMethod = json['_method'];
  }

  Map<String, String> toJson() {
    final Map<String, String> data = <String, String>{};
    data['start_date'] = startDate??'';
    data['end_date'] = endDate??'';
    data['name'] = name??'';
    data['details'] = details??'';
    data['location'] = location??'';
    data['_method'] = sMethod?? "post";
    return data;
  }
}
