class ReMarkConfigBody {
  int? sessionId;
  String? remarkTitle;
  String? remarks;
  String? method;

  ReMarkConfigBody({this.sessionId, this.remarkTitle, this.remarks, this.method});

  ReMarkConfigBody.fromJson(Map<String, dynamic> json) {
    sessionId = json['session_id'];
    remarkTitle = json['remark_title'];
    remarks = json['remarks'];
    method = json['_method'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['session_id'] = sessionId;
    data['remark_title'] = remarkTitle;
    data['remarks'] = remarks;
    data['_method'] = method;
    return data;
  }
}
