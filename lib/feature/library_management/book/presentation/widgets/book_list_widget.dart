import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/layout/list_layout_widget.dart';
import 'package:mighty_school/feature/library_management/book/controller/book_controller.dart';
import 'package:mighty_school/feature/library_management/book/domain/model/book_model.dart';
import 'package:mighty_school/feature/library_management/book/presentation/screens/create_new_book_dialog.dart';
import 'package:mighty_school/feature/library_management/book/presentation/widgets/book_item_widget.dart';

class BookListWidget extends StatelessWidget {
  final ScrollController? scrollController;

  const BookListWidget({super.key, this.scrollController});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BookController>(
      initState: (_) => Get.find<BookController>().getBookList(1),
      builder: (bookController) {
        final bookModel = bookController.bookModel;
        final bookData = bookModel?.data;
        return GenericListSection<BookItem>(
          sectionTitle: "library_management".tr,
          pathItems: ["book".tr],
          headings: const ["name", "action"],
          scrollController: scrollController ?? ScrollController(),
          isLoading: bookModel == null,
          totalSize: bookData?.total ?? 0,
          offset: bookData?.currentPage ?? 0,
          onPaginate: (offset) async => await bookController.getBookList(offset ?? 1),
          items: bookData?.data ?? [],
          itemBuilder: (item, index) => BookItemWidget(bookItem: item, index: index),
        );
      },
    );
  }
}
