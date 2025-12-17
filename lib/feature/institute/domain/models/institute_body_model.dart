class InstituteBodyModel {
  String? instituteName;
  String? instituteEmail;
  String? institutePhone;
  String? instituteDomain;
  String? instituteType;
  String? instituteAddress;
  String? userName;
  String? userEmail;
  String? userPhone;
  String? password;
  String? passwordConfirmation;

  InstituteBodyModel(
      {this.instituteName,
        this.instituteEmail,
        this.institutePhone,
        this.instituteDomain,
        this.instituteType,
        this.instituteAddress,
        this.userName,
        this.userEmail,
        this.userPhone,
        this.password,
        this.passwordConfirmation});

  InstituteBodyModel.fromJson(Map<String, dynamic> json) {
    instituteName = json['institute_name'];
    instituteEmail = json['institute_email'];
    institutePhone = json['institute_phone'];
    instituteDomain = json['institute_domain'];
    instituteType = json['institute_type'];
    instituteAddress = json['institute_address'];
    userName = json['user_name'];
    userEmail = json['user_email'];
    userPhone = json['user_phone'];
    password = json['password'];
    passwordConfirmation = json['password_confirmation'];
  }

  Map<String, String> toJson() {
    final Map<String, String> data = <String, String>{};
    data['institute_name'] = instituteName??'';
    data['institute_email'] = instituteEmail??'';
    data['institute_phone'] = institutePhone??'';
    data['institute_domain'] = instituteDomain??'';
    data['institute_type'] = instituteType??'';
    data['institute_address'] = instituteAddress??'';
    data['user_name'] = userName??'';
    data['user_email'] = userEmail??'';
    data['user_phone'] = userPhone??'';
    data['password'] = password??'';
    data['password_confirmation'] = passwordConfirmation??'';
    return data;
  }
}
