class HostelBody {
  String? hostelName;
  String? type;
  String? address;
  String? cMethod;

  HostelBody({this.hostelName, this.type, this.address, this.cMethod});

  HostelBody.fromJson(Map<String, dynamic> json) {
    hostelName = json['hostel_name'];
    type = json['type'];
    address = json['address'];
    cMethod = json['_method'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['hostel_name'] = hostelName;
    data['type'] = type;
    data['address'] = address;
    data['_method'] = cMethod;
    return data;
  }
}
