class EventModel {
  bool? status;
  String? message;
  Data? data;

  EventModel({this.status, this.message, this.data});

  EventModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;

  }

}

class Data {
  int? currentPage;
  List<EventItem>? data;
  int? total;

  Data(
      {this.currentPage,
        this.data,
        this.total});

  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <EventItem>[];
      json['data'].forEach((v) {
        data!.add(EventItem.fromJson(v));
      });
    }
    total = json['total'];
  }

}

class EventItem {
  int? id;
  String? startDate;
  String? endDate;
  String? name;
  String? details;
  String? location;
  String? image;

  EventItem(
      {this.id,
        this.startDate,
        this.endDate,
        this.name,
        this.details,
        this.location,
        this.image
      });

  EventItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    name = json['name'];
    details = json['details'];
    location = json['location'];
    location = json['image'];
  }

}


