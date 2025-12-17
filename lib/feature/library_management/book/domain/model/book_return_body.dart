class BookReturnBody {
  List<BookIssues>? bookIssues;

  BookReturnBody({this.bookIssues});

  BookReturnBody.fromJson(Map<String, dynamic> json) {
    if (json['bookIssues'] != null) {
      bookIssues = <BookIssues>[];
      json['bookIssues'].forEach((v) {
        bookIssues!.add(BookIssues.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (bookIssues != null) {
      data['bookIssues'] = bookIssues!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BookIssues {
  int? bookIssueId;
  String? expireDate;
  String? fine;
  String? lostBooks;

  BookIssues({this.bookIssueId, this.expireDate, this.fine, this.lostBooks});

  BookIssues.fromJson(Map<String, dynamic> json) {
    bookIssueId = json['book_issue_id'];
    expireDate = json['expire_date'];
    fine = json['fine'];
    lostBooks = json['lost_books'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['book_issue_id'] = bookIssueId;
    data['expire_date'] = expireDate;
    data['fine'] = fine;
    data['lost_books'] = lostBooks;
    return data;
  }
}
