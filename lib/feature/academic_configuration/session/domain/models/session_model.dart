class SessionModel {
  bool? status;
  String? message;
  Data? data;


  SessionModel({this.status, this.message, this.data});

  SessionModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
    
  }
  
}

class Data {
  int? currentPage;
  List<SessionItem>? data;
  int? total;

  Data(
      {this.currentPage,
        this.data,
        this.total});

  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <SessionItem>[];
      json['data'].forEach((v) {
        data!.add(SessionItem.fromJson(v));
      });
    }
    total = json['total'];
  }
}

class SessionItem {
  int? id;
  String? session;
  String? year;

  SessionItem({this.id, this.session, this.year});

  SessionItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    session = json['session'];
    year = json['year'];
  }
  
}


