class BookIssueBody {
  String? libraryId;
  List<String>? bookIds;
  List<String>? returnDates;

  BookIssueBody({this.libraryId, this.bookIds, this.returnDates});

  BookIssueBody.fromJson(Map<String, dynamic> json) {
    libraryId = json['library_id'];
    bookIds = json['book_ids'].cast<String>();
    returnDates = json['return_dates'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['library_id'] = libraryId;
    data['book_ids'] = bookIds;
    data['return_dates'] = returnDates;
    return data;
  }
}
