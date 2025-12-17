import 'package:get/get_connect/http/src/response/response.dart';
import 'package:mighty_school/api_handle/api_client.dart';
import 'package:mighty_school/feature/library_management/book/domain/model/book_issue_body.dart';
import 'package:mighty_school/feature/library_management/book/domain/model/book_return_body.dart';
import 'package:mighty_school/util/app_constants.dart';

class BookRepository{
  final ApiClient apiClient;
  BookRepository({required this.apiClient});

  Future<Response?> getBookList(int page) async {
    return await apiClient.getData("${AppConstants.books}?per_page=30&page=$page");
  }


  Future<Response?> addNewBook(String name) async {
    return await apiClient.postData(AppConstants.books, {"book_name": name});
  }

  Future<Response?> bookDetails(int id) async {
    return await apiClient.getData("${AppConstants.books}/$id");
  }

  Future<Response?> bookEdit(String name, int id) async {
    return await apiClient.postData("${AppConstants.books}/$id", {"_method" :"PUT", "book_name": name});
  }

  Future<Response?> bookDelete(int id) async {
    return await apiClient.deleteData("${AppConstants.books}/$id");
  }

  Future<Response?> bookIssue(BookIssueBody body) async {
    return await apiClient.postData(AppConstants.bookIssue, body.toJson());
  }
  Future<Response?> getIssuedBook(int page) async {
    return await apiClient.getData("${AppConstants.bookIssue}?per_page=30&page=$page");
  }

  Future<Response?> bookReturn(BookReturnBody body) async {
    return await apiClient.postData(AppConstants.bookReturn, body.toJson());
  }

  Future<Response?> bookIssueReport(int page, String statusId, String userId) async {
    return await apiClient.getData("${AppConstants.bookIssueReport}?per_page=20&page=$page&status_id=$statusId&user_id=$userId");
  }
}