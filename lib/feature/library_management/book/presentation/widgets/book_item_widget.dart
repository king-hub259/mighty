import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/confirmation_dialog.dart';
import 'package:mighty_school/common/widget/custom_contaner.dart';
import 'package:mighty_school/common/widget/custom_divider.dart';
import 'package:mighty_school/common/widget/custom_item_text_widget.dart';
import 'package:mighty_school/common/widget/edit_delete_section.dart';
import 'package:mighty_school/common/widget/numbering_widget.dart';
import 'package:mighty_school/feature/library_management/book/controller/book_controller.dart';
import 'package:mighty_school/feature/library_management/book/domain/model/book_model.dart';
import 'package:mighty_school/feature/library_management/book/presentation/screens/create_new_book_dialog.dart';
import 'package:mighty_school/helper/responsive_helper.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/styles.dart';

class BookItemWidget extends StatelessWidget {
  final BookItem? bookItem;
  final int index;

  const BookItemWidget({super.key, required this.bookItem, required this.index});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<BookController>();

    if (ResponsiveHelper.isDesktop(context)) {
      return Row(spacing: Dimensions.paddingSizeDefault, children: [
        NumberingWidget(index: index),
        Expanded(child: CustomItemTextWidget(text: bookItem?.bookName ?? '')),
          EditDeleteSection(horizontal: true, onEdit: _onEdit, onDelete: () => _onDelete(controller)),
        ]);
    }

    return Padding(padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeExtraSmall),
      child: CustomContainer(borderRadius: Dimensions.paddingSizeExtraSmall,
        child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Expanded(child: CustomItemTextWidget(text: bookItem?.bookName ?? '')),
            EditDeleteSection(horizontal: true, onEdit: _onEdit, onDelete: () => _onDelete(controller),
            )])),
    );
  }

  void _onDelete(BookController controller) {
    Get.dialog(ConfirmationDialog(title: "book".tr,
      content: "are_you_sure_to_delete".tr,
      onTap: () {
      Get.back();
      if (bookItem?.id != null) {
        controller.deleteBook(bookItem!.id!);
      }
      }),
    );
  }

  void _onEdit() {
    Get.dialog(CreateNewBookScreen(bookItem: bookItem));
  }
}
