class NoticeBody {
  String? title;
  String? notice;
  List<String>? userType;

  NoticeBody({this.title, this.notice, this.userType});

  NoticeBody.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    notice = json['notice'];
    userType = json['user_type'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['notice'] = notice;
    data['user_type'] = userType;
    return data;
  }
}
