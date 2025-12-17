class UserModel {
  bool? status;
  String? message;
  List<UserItem>? data;

  UserModel({this.status, this.message, this.data});

  UserModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <UserItem>[];
      json['data'].forEach((v) {
        data!.add(UserItem.fromJson(v));
      });
    }
  }

}

class UserItem {
  int? id;
  String? name;
  String? phone;
  String? userType;
  String? presentType;
  String? checkIn;
  String? checkOut;

  UserItem({this.id, this.name, this.phone, this.userType, this.presentType, this.checkIn, this.checkOut});

  UserItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    userType = json['user_type'];
    presentType = "present";
    checkIn = "09:00";
    checkOut = "05:00";
  }

}
