class TransportDriverBody {
  String? name;
  String? phone;
  String? email;
  String? address;
  String? licenseNumber;
  String? licenseExpiry;
  String? experience;
  String? status;
  String? joiningDate;
  String? salary;

  TransportDriverBody({
    this.name,
    this.phone,
    this.email,
    this.address,
    this.licenseNumber,
    this.licenseExpiry,
    this.experience,
    this.status,
    this.joiningDate,
    this.salary,
  });

  TransportDriverBody.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    phone = json['phone'];
    email = json['email'];
    address = json['address'];
    licenseNumber = json['license_number'];
    licenseExpiry = json['license_expiry'];
    experience = json['experience'];
    status = json['status'];
    joiningDate = json['joining_date'];
    salary = json['salary'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['phone'] = phone;
    data['email'] = email;
    data['address'] = address;
    data['license_number'] = licenseNumber;
    data['license_expiry'] = licenseExpiry;
    data['experience'] = experience;
    data['status'] = status;
    data['joining_date'] = joiningDate;
    data['salary'] = salary;
    return data;
  }
}
