import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/custom_divider.dart';
import 'package:mighty_school/feature/library_management/book/controller/book_controller.dart';
import 'package:mighty_school/feature/library_management/book/domain/model/book_model.dart';
import 'package:mighty_school/feature/library_management/book/presentation/widgets/selected_book_item_widget.dart';
import 'package:mighty_school/helper/responsive_helper.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/styles.dart';

class SelectedBookListWidget extends StatefulWidget {

  const SelectedBookListWidget({super.key});

  @override
  State<SelectedBookListWidget> createState() => _SelectedBookListWidgetState();
}

class _SelectedBookListWidgetState extends State<SelectedBookListWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(children: [
      if(ResponsiveHelper.isDesktop(context))...[
        const CustomDivider(),
        Row(children: [
          Expanded(child: Text('name'.tr, style: textMedium.copyWith())),
          const SizedBox(width: Dimensions.paddingSizeSmall),

          Expanded(child: Text('code'.tr, style: textMedium.copyWith())),
          const SizedBox(width: Dimensions.paddingSizeSmall),

          Expanded(child: Text('writer'.tr, style: textMedium.copyWith())),
          const SizedBox(width: Dimensions.paddingSizeSmall),

          Expanded(child: Text('quantity'.tr, style: textMedium.copyWith())),
          const SizedBox(width: Dimensions.paddingSizeSmall),

          Expanded(child: Text('return_date'.tr, style: textMedium.copyWith())),
          const SizedBox(width: Dimensions.paddingSizeSmall),

          Text('action'.tr, style: textMedium.copyWith())

        ]),
        const CustomDivider(),
      ],
        GetBuilder<BookController>(
          builder: (bookController) {
            List<BookItem> bookItems = bookController.selectedBookItems;
            return bookItems.isNotEmpty?
            ListView.builder(
              itemCount: bookItems.length,
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index){
              return SelectedBookItemWidget(bookItem: bookItems[index], index: index);
            }): const SizedBox();
          }
        ),
      ],
    );
  }
}
