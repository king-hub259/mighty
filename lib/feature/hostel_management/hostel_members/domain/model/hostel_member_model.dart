
class HostelMemberItem {
  int? id;
  int? instituteId;
  int? branchId;
  String? name;
  String? email;
  String? password;
  String? phone;
  String? image;
  int? roleId;
  String? emailVerifiedAt;
  int? status;
  String? userType;
  String? facebook;
  String? twitter;
  String? linkedin;
  String? googlePlus;
  String? userStatus;
  String? roll;
  String? className;
  String? sectionName;

  HostelMemberItem(
      {this.id,
        this.instituteId,
        this.branchId,
        this.name,
        this.email,
        this.password,
        this.phone,
        this.image,
        this.roleId,
        this.emailVerifiedAt,
        this.status,
        this.userType,
        this.facebook,
        this.twitter,
        this.linkedin,
        this.googlePlus,
        this.userStatus,
        this.roll,
        this.className,
        this.sectionName});

  HostelMemberItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    instituteId = json['institute_id'];
    branchId = json['branch_id'];
    name = json['name'];
    email = json['email'];
    password = json['password'];
    phone = json['phone'];
    image = json['image'];
    roleId = json['role_id'];
    emailVerifiedAt = json['email_verified_at'];
    status = json['status'];
    userType = json['user_type'];
    facebook = json['facebook'];
    twitter = json['twitter'];
    linkedin = json['linkedin'];
    googlePlus = json['google_plus'];
    userStatus = json['user_status'];
    roll = json['roll'];
    className = json['class_name'];
    sectionName = json['section_name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['institute_id'] = instituteId;
    data['branch_id'] = branchId;
    data['name'] = name;
    data['email'] = email;
    data['password'] = password;
    data['phone'] = phone;
    data['image'] = image;
    data['role_id'] = roleId;
    data['email_verified_at'] = emailVerifiedAt;
    data['status'] = status;
    data['user_type'] = userType;
    data['facebook'] = facebook;
    data['twitter'] = twitter;
    data['linkedin'] = linkedin;
    data['google_plus'] = googlePlus;
    data['user_status'] = userStatus;
    data['roll'] = roll;
    data['class_name'] = className;
    data['section_name'] = sectionName;
    return data;
  }
}
