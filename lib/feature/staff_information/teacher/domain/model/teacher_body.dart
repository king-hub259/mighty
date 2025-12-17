class TeacherBody {
  String? name;
  String? designation;
  String? departmentId;
  String? gender;
  String? religion;
  String? blood;
  String? joiningDate;
  String? address;
  String? sl;
  String? email;
  String? phone;
  String? password;
  String? passwordConfirmation;
  String? sMethod;

  TeacherBody(
      {this.name,
        this.designation,
        this.departmentId,
        this.gender,
        this.religion,
        this.blood,
        this.joiningDate,
        this.address,
        this.sl,
        this.email,
        this.phone,
        this.password,
        this.passwordConfirmation,
        this.sMethod
      });

  TeacherBody.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    designation = json['designation'];
    departmentId = json['department_id'];
    gender = json['gender'];
    religion = json['religion'];
    blood = json['blood'];
    joiningDate = json['joining_date'];
    address = json['address'];
    sl = json['sl'];
    email = json['email'];
    phone = json['phone'];
    password = json['password'];
    passwordConfirmation = json['password_confirmation'];
    sMethod = json["_method"];
  }

  Map<String, String> toJson() {
    final Map<String, String> data = <String, String>{};
    data['name'] = name??'';
    data['designation'] = designation??'';
    data['department_id'] = departmentId??'';
    data['gender'] = gender??'';
    data['religion'] = religion??'';
    data['blood'] = blood??'';
    data['joining_date'] = joiningDate??'';
    data['address'] = address??'';
    data['sl'] = sl??'';
    data['email'] = email??'';
    data['phone'] = phone??'';
    data['password'] = password??'';
    data['password_confirmation'] = passwordConfirmation??'';
    data['_method'] = sMethod??"post";
    return data;
  }
}
