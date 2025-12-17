class HostelMemberBody {
  String? hostelId;
  String? studentId;
  String? joinDate;
  String? leaveDate;
  String? status;

  HostelMemberBody({
    this.hostelId,
    this.studentId,
    this.joinDate,
    this.leaveDate,
    this.status,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['hostel_id'] = hostelId;
    data['student_id'] = studentId;
    data['join_date'] = joinDate;
    data['leave_date'] = leaveDate;
    data['status'] = status;
    return data;
  }
}
