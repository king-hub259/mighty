import 'package:intl/intl.dart';

class BookModel {
  bool? status;
  String? message;
  Data? data;

  BookModel({this.status, this.message, this.data});

  BookModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
}

class Data {
  int? currentPage;
  List<BookItem>? data;
  int? total;

  Data(
      {this.currentPage,
        this.data,
        this.total});

  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <BookItem>[];
      json['data'].forEach((v) {
        data!.add(BookItem.fromJson(v));
      });
    }

    total = json['total'];
  }

}

class BookItem {
  int? id;
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
  int? quantity;
  String? price;
  String? bookself;
  String? rack;
  String? path;
  String? status;
  String? returnDate;


  BookItem(
      {this.id,
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
        this.status,
        this.returnDate,
      });

  BookItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    datetime = json['datetime'];
    code = json['code'];
    bookGroup = json['book_group'].toString();
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
    status = json['status'];
    returnDate = DateFormat('yyyy-MM-dd').format(DateTime.now().add(const Duration(days: 14)));
  }

}

