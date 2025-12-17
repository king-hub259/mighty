class StudentProfileModel {
  bool? success;
  int? statusCode;
  String? message;
  ProfileInfo? data;
  String? metadata;

  StudentProfileModel(
      {this.success, this.statusCode, this.message, this.data, this.metadata});

  StudentProfileModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    statusCode = json['status_code'];
    message = json['message'];
    data = json['data'] != null ? ProfileInfo.fromJson(json['data']) : null;
    metadata = json['metadata'];
  }

}

class ProfileInfo {
  int? id;
  String? name;
  String? username;
  String? phone;
  String? email;
  String? department;
  String? role;
  String? imageUrl;

  ProfileInfo(
      {this.id,
        this.name,
        this.username,
        this.phone,
        this.email,
        this.department,
        this.role,
        this.imageUrl});

  ProfileInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    username = json['username'];
    phone = json['phone'];
    email = json['email'];
    department = json['department'];
    role = json['role'];
    imageUrl = json['image_url'];
  }


}
