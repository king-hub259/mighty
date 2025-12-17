
import 'package:get/get.dart';
import 'package:mighty_school/api_handle/api_checker.dart';
import 'package:mighty_school/common/widget/custom_snackbar.dart';
import 'package:mighty_school/feature/library_management/book/domain/model/book_issue_body.dart';
import 'package:mighty_school/feature/library_management/book/domain/model/book_issue_model.dart';
import 'package:mighty_school/feature/library_management/book/domain/model/book_issue_report_model.dart';
import 'package:mighty_school/feature/library_management/book/domain/model/book_model.dart';
import 'package:mighty_school/feature/library_management/book/domain/model/book_return_body.dart';
import 'package:mighty_school/feature/library_management/book/domain/repository/book_repository.dart';
import 'package:mighty_school/feature/library_management/library_member/controller/library_member_controller.dart';

class BookController extends GetxController implements GetxService{
  final BookRepository bookRepository;
  BookController({required this.bookRepository});

  BookModel? bookModel;
  Future<void> getBookList(int page) async {
    Response? response = await bookRepository.getBookList(page);
    if(response?.statusCode == 200){
      if(page == 1){
        bookModel = BookModel.fromJson(response?.body);
      }else{
        bookModel?.data?.data?.addAll(BookModel.fromJson(response?.body).data!.data!);
        bookModel?.data?.currentPage = BookModel.fromJson(response?.body).data?.currentPage;
        bookModel?.data?.total = BookModel.fromJson(response?.body).data?.total;

      }

    }else{
      ApiChecker.checkApi(response!);
    }
    update();

  }

  String selectedType = "ALL";
  int selectedTypeIndex = 0;
  List<String> statusTypes = ["ALL", "OPEN", "RETURNED"];
  void setSelectedStatusType(String index){
    selectedType = index;
    selectedTypeIndex = statusTypes.indexOf(index);
    update();
  }


  BookItem? selectedBookItem;
  void setSelectBook(BookItem? item) async {
    selectedBookItem = item;
    addSelectedBook(selectedBookItem);
    update();
  }


  List<BookItem> selectedBookItems = [];
  void addSelectedBook(BookItem? item) {
    if (selectedBookItems.contains(item)) {
      selectedBookItems.remove(item);
    } else {
      selectedBookItems.add(item!);
    }
    update();
  }


  void removeBook(int index) {
    selectedBookItems.removeAt(index);
    update();
  }




  bool isLoading = false;
  Future<void> addNewBook(String name) async {
    isLoading = true;
    update();
    Response? response = await bookRepository.addNewBook(name);
    if(response!.statusCode == 200){
      isLoading = false;
      showCustomSnackBar("added_successfully".tr, isError: false);
      getBookList(1);
      Get.back();
    }else{
      isLoading = false;
      ApiChecker.checkApi(response);
    }
    update();

  }

  Future<void> updateBook(String name, int id) async {
    isLoading = true;
    update();
    Response? response = await bookRepository.bookEdit(name, id);
    if(response!.statusCode == 200){
      isLoading = false;
      Get.back();
      showCustomSnackBar("updated_successfully".tr.tr, isError: false);
      getBookList(1);

    }else{
      isLoading = false;
      ApiChecker.checkApi(response);
    }
    update();

  }

  Future<void> bookDetails(int id) async {
    Response? response = await bookRepository.bookDetails(id);
    if(response!.statusCode == 200){

    }else{
      ApiChecker.checkApi(response);
    }
    update();

  }

  Future<void> deleteBook(int id) async {
    Response? response = await bookRepository.bookDelete(id);
    if(response!.statusCode == 200){
      showCustomSnackBar("deleted_successfully".tr, isError: false);
      getBookList(1);
    }else{
      ApiChecker.checkApi(response);
    }
    update();

  }

  Future<void> bookIssue(BookIssueBody body) async {
    Response? response = await bookRepository.bookIssue(body);
    if(response!.statusCode == 200){
      selectedBookItems.clear();
      Get.find<LibraryMemberController>().clearMember();
      showCustomSnackBar("issued_successfully".tr, isError: false);
    }else{
      ApiChecker.checkApi(response);
    }
    update();

  }
  BookIssueModel? bookIssueModel;
  Future<void> getIssuedBookList(int page) async {
    Response? response = await bookRepository.getIssuedBook(page);
    if(response?.statusCode == 200){
      if(page == 1){
        bookIssueModel = BookIssueModel.fromJson(response?.body);
      } else{
        bookIssueModel?.data?.data?.addAll(BookIssueModel.fromJson(response?.body).data!.data!);
        bookIssueModel?.data?.currentPage = BookIssueModel.fromJson(response?.body).data?.currentPage;
        bookIssueModel?.data?.total = BookIssueModel.fromJson(response?.body).data?.total;

      }
    }else{
      ApiChecker.checkApi(response!);
    }
    update();
  }


  List<BookIssues> bookIssues = [];
  bool allSelected = false;
  toggleAllBookIssues(){
    allSelected =!allSelected;
    if (allSelected) {
      bookIssueModel?.data?.data?.forEach((item) => item.isSelected = true);
      bookIssueModel?.data?.data?.forEach((item) {
        if(item.isSelected?? false){
          bookIssues.add(BookIssues(bookIssueId: item.id, expireDate: "0", fine: "0", lostBooks: "0"));
        }
      });

    } else {
      bookIssueModel?.data?.data?.forEach((item) => item.isSelected = false);
      bookIssues.clear();
    }
    update();

  }

  void toggleBookIssues(int index) {
    if (bookIssueModel?.data?.data?[index].isSelected == true) {
      bookIssueModel?.data?.data?[index].isSelected = false;
      bookIssues.removeWhere((item) => item.bookIssueId == bookIssueModel?.data?.data?[index].id);
    } else {
      bookIssueModel?.data?.data?[index].isSelected = true;
      bookIssues.add(BookIssues(bookIssueId: bookIssueModel?.data?.data?[index].id, expireDate: "", fine: "0", lostBooks: "0"));
    }
    update();
  }


  Future<void> bookReturn(BookReturnBody body) async {
    Response? response = await bookRepository.bookReturn(body);
    if(response?.statusCode == 200){
      showCustomSnackBar("successfully_returned".tr, isError: false);
    }else{
      ApiChecker.checkApi(response!);
    }
    update();

  }

  BookIssueReportModel? bookIssueReportModel;
  Future<void> getBookIssueReport(int page, {String statusId = "", String userId = ""}) async {
    Response? response = await bookRepository.bookIssueReport(page, statusId, userId);
    if(response?.statusCode == 200){
      if(page == 1){
        bookIssueReportModel = BookIssueReportModel.fromJson(response?.body);
      }else{
        bookIssueReportModel?.data?.issues?.data?.addAll(BookIssueReportModel.fromJson(response?.body).data!.issues!.data!);
        bookIssueReportModel?.data?.issues?.currentPage = BookIssueReportModel.fromJson(response?.body).data?.issues?.currentPage;
        bookIssueReportModel?.data?.issues?.total = BookIssueReportModel.fromJson(response?.body).data?.issues?.total;
      }

    }else{
      ApiChecker.checkApi(response!);
    }
    update();

  }





}