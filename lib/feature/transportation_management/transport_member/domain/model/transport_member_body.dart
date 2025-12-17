class TransportMemberBody {
  int? studentId;
  int? routeId;
  int? stopId;
  String? membershipType;
  String? startDate;
  String? endDate;
  String? monthlyFee;
  String? status;
  String? pickupTime;
  String? dropTime;

  TransportMemberBody({
    this.studentId,
    this.routeId,
    this.stopId,
    this.membershipType,
    this.startDate,
    this.endDate,
    this.monthlyFee,
    this.status,
    this.pickupTime,
    this.dropTime,
  });

  TransportMemberBody.fromJson(Map<String, dynamic> json) {
    studentId = json['student_id'];
    routeId = json['route_id'];
    stopId = json['stop_id'];
    membershipType = json['membership_type'];
    startDate = json['start_date'];
    endDate = json['end_date'];
    monthlyFee = json['monthly_fee'];
    status = json['status'];
    pickupTime = json['pickup_time'];
    dropTime = json['drop_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['student_id'] = studentId;
    data['route_id'] = routeId;
    data['stop_id'] = stopId;
    data['membership_type'] = membershipType;
    data['start_date'] = startDate;
    data['end_date'] = endDate;
    data['monthly_fee'] = monthlyFee;
    data['status'] = status;
    data['pickup_time'] = pickupTime;
    data['drop_time'] = dropTime;
    return data;
  }
}
