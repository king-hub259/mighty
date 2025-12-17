import 'package:flutter/cupertino.dart';

class BookIssueModel {
  bool? status;
  String? message;
  Data? data;


  BookIssueModel({this.status, this.message, this.data});

  BookIssueModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

}

class Data {
  int? currentPage;
  List<BookIssueItem>? data;
  int? total;

  Data(
      {this.currentPage,
        this.data,
        this.total});

  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <BookIssueItem>[];
      json['data'].forEach((v) {
        data!.add(BookIssueItem.fromJson(v));
      });
    }
    total = json['total'];
  }

}

class BookIssueItem {
  int? id;
  String? bookId;
  String? libraryId;
  String? userId;
  String? note;
  String? issueDate;
  String? dueDate;
  String? returnDate;
  String? status;
  String? studentId;
  String? staffId;
  String? type;
  String? updatedAt;
  String? datetime;
  String? code;
  String? bookGroup;
  String? bookName;
  String? bookCopyNo;
  String? publisher;
  String? publishYear;
  String? provider;
  String? totalPage;
  String? identificationPage;
  String? aa;
  String? author;
  String? edition;
  String? description;
  String? category;
  String? quantity;
  String? price;
  String? bookself;
  String? rack;
  String? path;
  String? issueStatus;
  bool? isSelected;
  TextEditingController? fineController;
  TextEditingController? lostController;

  BookIssueItem(
      {this.id,
        this.bookId,
        this.libraryId,
        this.userId,
        this.note,
        this.issueDate,
        this.dueDate,
        this.returnDate,
        this.status,
        this.studentId,
        this.staffId,
        this.type,
        this.updatedAt,
        this.datetime,
        this.code,
        this.bookGroup,
        this.bookName,
        this.bookCopyNo,
        this.publisher,
        this.publishYear,
        this.provider,
        this.totalPage,
        this.identificationPage,
        this.aa,
        this.author,
        this.edition,
        this.description,
        this.category,
        this.quantity,
        this.price,
        this.bookself,
        this.rack,
        this.path,
        this.issueStatus,
        this.isSelected = false,
        this.fineController,
        this.lostController

      });

  BookIssueItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    bookId = json['book_id'].toString();
    libraryId = json['library_id'].toString();
    userId = json['user_id'].toString();
    note = json['note'];
    issueDate = json['issue_date'];
    dueDate = json['due_date'];
    returnDate = json['return_date'];
    status = json['status'];
    studentId = json['student_id'].toString();
    staffId = json['staff_id'].toString();
    type = json['type'];
    updatedAt = json['updated_at'];
    datetime = json['datetime'];
    code = json['code'];
    bookGroup = json['book_group'];
    bookName = json['book_name'];
    bookCopyNo = json['book_copy_no'];
    publisher = json['publisher'];
    publishYear = json['publish_year'];
    provider = json['provider'];
    totalPage = json['total_page'];
    identificationPage = json['identification_page'];
    aa = json['aa'];
    author = json['author'];
    edition = json['edition'];
    description = json['description'];
    category = json['category'];
    quantity = json['quantity'];
    price = json['price'];
    bookself = json['bookself'];
    rack = json['rack'];
    path = json['path'];
    issueStatus = json['issue_status'].toString();
    isSelected = false;
    fineController = TextEditingController();
    lostController = TextEditingController();
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['book_id'] = bookId;
    data['library_id'] = libraryId;
    data['user_id'] = userId;
    data['note'] = note;
    data['issue_date'] = issueDate;
    data['due_date'] = dueDate;
    data['return_date'] = returnDate;
    data['status'] = status;
    data['student_id'] = studentId;
    data['staff_id'] = staffId;
    data['type'] = type;
    data['updated_at'] = updatedAt;
    data['datetime'] = datetime;
    data['code'] = code;
    data['book_group'] = bookGroup;
    data['book_name'] = bookName;
    data['book_copy_no'] = bookCopyNo;
    data['publisher'] = publisher;
    data['publish_year'] = publishYear;
    data['provider'] = provider;
    data['total_page'] = totalPage;
    data['identification_page'] = identificationPage;
    data['aa'] = aa;
    data['author'] = author;
    data['edition'] = edition;
    data['description'] = description;
    data['category'] = category;
    data['quantity'] = quantity;
    data['price'] = price;
    data['bookself'] = bookself;
    data['rack'] = rack;
    data['path'] = path;
    return data;
  }
}

