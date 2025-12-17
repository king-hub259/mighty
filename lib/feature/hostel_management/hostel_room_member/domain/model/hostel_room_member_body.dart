class HostelRoomMemberBody {
  String? roomId;
  String? studentId;
  String? assignDate;
  String? leaveDate;
  String? status;

  HostelRoomMemberBody({
    this.roomId,
    this.studentId,
    this.assignDate,
    this.leaveDate,
    this.status,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['room_id'] = roomId;
    data['student_id'] = studentId;
    data['assign_date'] = assignDate;
    data['leave_date'] = leaveDate;
    data['status'] = status;
    return data;
  }
}
