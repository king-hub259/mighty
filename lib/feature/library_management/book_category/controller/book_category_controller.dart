
import 'package:get/get.dart';
import 'package:mighty_school/api_handle/api_checker.dart';
import 'package:mighty_school/common/widget/custom_snackbar.dart';
import 'package:mighty_school/feature/library_management/book_category/domain/model/book_category_model.dart';
import 'package:mighty_school/feature/library_management/book_category/domain/repository/book_category_repository.dart';

class BookCategoryController extends GetxController implements GetxService{
  final BookCategoryRepository bookCategoryRepository;
  BookCategoryController({required this.bookCategoryRepository});

  BookCategoryModel? bookCategoryModel;
  Future<void> getBookCategoriesList({int perPage = 10, int page =1}) async {
    Response? response = await bookCategoryRepository.getBookCategoriesList(perPage: perPage, page: page);
    if(response?.statusCode == 200){
      if(page == 1){
        bookCategoryModel = BookCategoryModel.fromJson(response?.body);
      }else{
        bookCategoryModel?.data?.data?.addAll(BookCategoryModel.fromJson(response?.body).data!.data!);
        bookCategoryModel?.data?.currentPage = BookCategoryModel.fromJson(response?.body).data?.currentPage;
        bookCategoryModel?.data?.total = BookCategoryModel.fromJson(response?.body).data?.total;

      }

    }else{
      ApiChecker.checkApi(response!);
    }
    update();

  }



  BookCategoryItem? selectedBookCategoryItem;
  void setSelectBookCategory(BookCategoryItem? item) async {
    selectedBookCategoryItem = item;
    update();
  }

  bool isLoading = false;

  Future<void> addNewBookCategory(String name) async {
    isLoading = true;
    update();
    Response? response = await bookCategoryRepository.addNewBookCategory(name);
    if(response!.statusCode == 200){
      isLoading = false;
      showCustomSnackBar("added_successfully".tr, isError: false);
      getBookCategoriesList();
      Get.back();
    }else{
      isLoading = false;
      ApiChecker.checkApi(response);
    }
    update();

  }

  Future<void> updateBookCategory(String name, int id) async {
    isLoading = true;
    update();
    Response? response = await bookCategoryRepository.bookCategoriesEdit(name, id);
    if(response!.statusCode == 200){
      isLoading = false;
      Get.back();
      showCustomSnackBar("updated_successfully".tr.tr, isError: false);
      getBookCategoriesList();

    }else{
      isLoading = false;
      ApiChecker.checkApi(response);
    }
    update();

  }

  Future<void> bookCategoryDetails(int id) async {
    Response? response = await bookCategoryRepository.bookCategoriesDetails(id);
    if(response!.statusCode == 200){

    }else{
      ApiChecker.checkApi(response);
    }
    update();

  }

  Future<void> deleteBookCategory(int id) async {
    Response? response = await bookCategoryRepository.bookCategoriesDelete(id);
    if(response!.statusCode == 200){
      showCustomSnackBar("deleted_successfully".tr, isError: false);
      getBookCategoriesList();
    }else{
      ApiChecker.checkApi(response);
    }
    update();

  }
}