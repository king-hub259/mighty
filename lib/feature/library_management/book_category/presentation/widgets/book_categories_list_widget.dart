import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/layout/list_layout_widget.dart';
import 'package:mighty_school/feature/library_management/book_category/controller/book_category_controller.dart';
import 'package:mighty_school/feature/library_management/book_category/domain/model/book_category_model.dart';
import 'package:mighty_school/feature/library_management/book_category/presentation/screens/create_new_book_category_dialog.dart';
import 'package:mighty_school/feature/library_management/book_category/presentation/widgets/book_category_item_widget.dart';

class BookCategoriesListWidget extends StatelessWidget {
  final ScrollController? scrollController;
  const BookCategoriesListWidget({super.key, this.scrollController});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BookCategoryController>(
      initState: (_) => Get.find<BookCategoryController>().getBookCategoriesList(page:1),
      builder: (controller) {
        final categoryModel = controller.bookCategoryModel;
        final categoryData = categoryModel?.data;
        return GenericListSection<BookCategoryItem>(
          sectionTitle: "library_management".tr,
          pathItems: ["book_category".tr],
          headings: const ["name", "action"],
          scrollController: scrollController ?? ScrollController(),
          isLoading: categoryModel == null,
          totalSize: categoryData?.total ?? 0,
          offset: categoryData?.currentPage ?? 0,
          onPaginate: (offset) async => await controller.getBookCategoriesList(page:offset ?? 1),
          items: categoryData?.data ?? [],
          itemBuilder: (item, index) => BookCategoryItemWidget(bookCategoryItem: item, index: index),

        );
      },
    );
  }
}
