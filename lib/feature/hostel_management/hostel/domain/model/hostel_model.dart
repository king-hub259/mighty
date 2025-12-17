
class HostelItem {
  int? id;
  int? instituteId;
  int? branchId;
  String? hostelName;
  String? type;
  String? address;
  String? note;
  String? createdAt;
  String? updatedAt;

  HostelItem(
      {this.id,
        this.instituteId,
        this.branchId,
        this.hostelName,
        this.type,
        this.address,
        this.note,
        this.createdAt,
        this.updatedAt});

  HostelItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    instituteId = json['institute_id'];
    branchId = json['branch_id'];
    hostelName = json['hostel_name'];
    type = json['type'];
    address = json['address'];
    note = json['note'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['institute_id'] = instituteId;
    data['branch_id'] = branchId;
    data['hostel_name'] = hostelName;
    data['type'] = type;
    data['address'] = address;
    data['note'] = note;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
