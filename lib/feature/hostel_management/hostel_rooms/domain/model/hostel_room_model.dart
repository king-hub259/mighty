
class HostelRoomItem {
  int? id;
  int? instituteId;
  int? branchId;
  int? hostelCategoryId;
  String? roomNumber;
  int? capacity;
  String? createdAt;
  String? updatedAt;

  HostelRoomItem(
      {this.id,
        this.instituteId,
        this.branchId,
        this.hostelCategoryId,
        this.roomNumber,
        this.capacity,
        this.createdAt,
        this.updatedAt});

  HostelRoomItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    instituteId = json['institute_id'];
    branchId = json['branch_id'];
    hostelCategoryId = json['hostel_category_id'];
    roomNumber = json['room_number'];
    capacity = json['capacity'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['institute_id'] = instituteId;
    data['branch_id'] = branchId;
    data['hostel_category_id'] = hostelCategoryId;
    data['room_number'] = roomNumber;
    data['capacity'] = capacity;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
