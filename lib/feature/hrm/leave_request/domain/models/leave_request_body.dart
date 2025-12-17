class LeaveRequestBody {
  int? userId;
  int? leaveTypeId;
  String? startDate;
  String? endDate;
  String? approvalStatus;
  String? notes;

  LeaveRequestBody(
      {this.userId,
        this.leaveTypeId,
        this.startDate,
        this.endDate,
        this.approvalStatus,
        this.notes});

  LeaveRequestBody.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    leaveTypeId = json['leave_type_id'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    approvalStatus = json['approval_status'];
    notes = json['notes'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = userId;
    data['leave_type_id'] = leaveTypeId;
    data['start_date'] = startDate;
    data['end_date'] = endDate;
    data['approval_status'] = approvalStatus;
    data['notes'] = notes;
    return data;
  }
}
