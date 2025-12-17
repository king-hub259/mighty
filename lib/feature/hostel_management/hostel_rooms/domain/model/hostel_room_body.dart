class HostelRoomBody {
  String? categoryId;
  String? roomNumber;
  String? capacity;
  String? cMethod;

  HostelRoomBody({
    this.categoryId,
    this.roomNumber,
    this.capacity,
    this.cMethod,
  });

  factory HostelRoomBody.fromJson(Map<String, dynamic> json) {
    return HostelRoomBody(
      categoryId: json['hostel_category_id'],
      roomNumber: json['room_number'],
      capacity: json['capacity'],
      cMethod: json['_method'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'hostel_category_id': categoryId,
      'room_number': roomNumber,
      'capacity': capacity,
      '_method': cMethod,
    };
  }
}