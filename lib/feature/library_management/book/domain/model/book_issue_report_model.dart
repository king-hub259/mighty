class BookIssueReportModel {
  bool? status;
  String? message;
  BookIssueReportItem? data;


  BookIssueReportModel({this.status, this.message, this.data});

  BookIssueReportModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? BookIssueReportItem.fromJson(json['data']) : null;
  }

}

class BookIssueReportItem {
  Issues? issues;
  String? idSelect;

  BookIssueReportItem({this.issues, this.idSelect});

  BookIssueReportItem.fromJson(Map<String, dynamic> json) {
    issues =
    json['issues'] != null ? Issues.fromJson(json['issues']) : null;
    idSelect = json['idSelect'];
  }

}

class Issues {
  int? currentPage;
  List<BookIssueReportResultItem>? data;
  int? total;

  Issues(
      {this.currentPage,
        this.data,
        this.total});

  Issues.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <BookIssueReportResultItem>[];
      json['data'].forEach((v) {
        data!.add(BookIssueReportResultItem.fromJson(v));
      });
    }
    total = json['total'];
  }

}

class BookIssueReportResultItem {
  String? id;
  String? type;
  String? issueDate;
  String? returnDate;
  String? status;
  String? studentId;
  String? libraryId;
  String? dueDate;
  String? bookName;
  String? code;
  String? studentFirstName;
  String? studentLastName;
  String? studentPhone;


  BookIssueReportResultItem(
      {this.id,
        this.type,
        this.issueDate,
        this.returnDate,
        this.status,
        this.studentId,
        this.libraryId,
        this.dueDate,
        this.bookName,
        this.code,
        this.studentFirstName,
        this.studentLastName,
        this.studentPhone,
       });

  BookIssueReportResultItem.fromJson(Map<String, dynamic> json) {
    id = json['id'].toString();
    type = json['type'];
    issueDate = json['issue_date'];
    returnDate = json['return_date'];
    status = json['status'].toString();
    studentId = json['student_id'].toString();
    libraryId = json['library_id'].toString();
    dueDate = json['due_date'];
    bookName = json['book_name'];
    code = json['code'];
    studentFirstName = json['student_first_name'];
    studentLastName = json['student_last_name'];
    studentPhone = json['student_phone'];
  }

}

