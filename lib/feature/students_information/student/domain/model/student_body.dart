class StudentBody {
  String? firstName;
  String? lastName;
  String? fatherName;
  String? motherName;
  String? classId;
  String? group;
  String? sectionId;
  String? gender;
  String? registerNo;
  String? roll;
  String? bloodGroup;
  String? religion;
  String? address;
  String? email;
  String? phone;
  String? password;
  String? passwordConfirmation;

  StudentBody(
      {this.firstName,
        this.lastName,
        this.fatherName,
        this.motherName,
        this.classId,
        this.group,
        this.sectionId,
        this.gender,
        this.registerNo,
        this.roll,
        this.bloodGroup,
        this.religion,
        this.address,
        this.email,
        this.phone,
        this.password,
        this.passwordConfirmation});

  StudentBody.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name'];
    lastName = json['last_name'];
    fatherName = json['father_name'];
    motherName = json['mother_name'];
    classId = json['class_id'];
    group = json['group'];
    sectionId = json['section_id'];
    gender = json['gender'];
    registerNo = json['register_no'];
    roll = json['roll'];
    bloodGroup = json['blood_group'];
    religion = json['religion'];
    address = json['address'];
    email = json['email'];
    phone = json['phone'];
    password = json['password'];
    passwordConfirmation = json['password_confirmation'];
  }

  Map<String, String> toJson() {
    final Map<String, String> data = <String, String>{};
    data['first_name'] = firstName??'';
    data['last_name'] = lastName??'';
    data['father_name'] = fatherName??'';
    data['mother_name'] = motherName??'';
    data['class_id'] = classId??'';
    data['group'] = group??'';
    data['section_id'] = sectionId??'';
    data['gender'] = gender??'';
    data['register_no'] = registerNo??'';
    data['roll'] = roll??'';
    data['blood_group'] = bloodGroup??'';
    data['religion'] = religion??'';
    data['address'] = address??'';
    data['email'] = email??'';
    data['phone'] = phone??'';
    data['password'] = password??'';
    data['password_confirmation'] = passwordConfirmation??'';
    return data;
  }
}
