class NoticeModel {
  bool? status;
  String? message;
  Data? data;


  NoticeModel({this.status, this.message, this.data});

  NoticeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

}

class Data {
  int? currentPage;
  List<NoticeItem>? data;
  int? total;

  Data(
      {this.currentPage,
        this.data,
        this.total});

  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <NoticeItem>[];
      json['data'].forEach((v) {
        data!.add(NoticeItem.fromJson(v));
      });
    }
    total = json['total'];
  }

}

class NoticeItem {
  int? id;
  String? title;
  String? notice;
  String? date;
  String? createdBy;
  List<UserType>? userType;

  NoticeItem(
      {this.id,
        this.title,
        this.notice,
        this.date,
        this.createdBy,
        this.userType});

  NoticeItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    notice = json['notice'];
    date = json['date'];
    createdBy = json['created_by'].toString();
    if (json['user_type'] != null) {
      userType = <UserType>[];
      json['user_type'].forEach((v) {
        userType!.add(UserType.fromJson(v));
      });
    }
  }


}

class UserType {
  int? id;
  String? noticeId;
  String? userType;
  String? createdAt;
  String? updatedAt;

  UserType(
      {this.id, this.noticeId, this.userType, this.createdAt, this.updatedAt});

  UserType.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    noticeId = json['notice_id'].toString();
    userType = json['user_type'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }


}


