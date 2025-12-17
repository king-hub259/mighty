import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/custom_button.dart';
import 'package:mighty_school/common/widget/custom_contaner.dart';
import 'package:mighty_school/common/widget/custom_divider.dart';
import 'package:mighty_school/common/widget/custom_snackbar.dart';
import 'package:mighty_school/common/widget/custom_title.dart';
import 'package:mighty_school/common/widget/no_data_found.dart';
import 'package:mighty_school/common/widget/paginated_list_widget.dart';
import 'package:mighty_school/feature/library_management/book/controller/book_controller.dart';
import 'package:mighty_school/feature/library_management/book/domain/model/book_issue_model.dart';
import 'package:mighty_school/feature/library_management/book/domain/model/book_return_body.dart';
import 'package:mighty_school/feature/library_management/book/presentation/widgets/book_return_item_widget.dart';
import 'package:mighty_school/feature/library_management/library_member/presentation/widgets/member_selection_dropdown_widget.dart';
import 'package:mighty_school/helper/responsive_helper.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/styles.dart';

class BookReturnWidget extends StatefulWidget {
  final ScrollController scrollController;
  const BookReturnWidget({super.key, required this.scrollController});

  @override
  State<BookReturnWidget> createState() => _BookReturnWidgetState();
}

class _BookReturnWidgetState extends State<BookReturnWidget> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<BookController>(
      initState: (val) => Get.find<BookController>().getIssuedBookList(1),
      builder: (bookController) {
        BookIssueModel? bookIssueModel = bookController.bookIssueModel;
        var book = bookIssueModel?.data;
        return CustomContainer(child: Column(children: [




          const CustomTitle(title: "book_return"),
          Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
            const Expanded(flex: 5,child: SelectMemberDropdownWidget()),
            const SizedBox(width: Dimensions.paddingSizeSmall),
            Expanded(flex: 1, child: Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: CustomButton(onTap: (){}, text: "search".tr),
            ))
          ],),

          if(ResponsiveHelper.isDesktop(context))...[

            const CustomDivider(),
            Row(children: [
              SizedBox(width: 20, child: Checkbox(value: bookController.allSelected, onChanged: (val){
                bookController.toggleAllBookIssues();
              }),),
              const SizedBox(width: Dimensions.paddingSizeSmall),

              Expanded(child: Text("code".tr, style: textMedium.copyWith())),
              const SizedBox(width: Dimensions.paddingSizeSmall),

              Expanded(child: Text("id".tr, style: textMedium.copyWith())),
              const SizedBox(width: Dimensions.paddingSizeSmall),

              Expanded(child: Text("name".tr, style: textMedium.copyWith())),
              const SizedBox(width: Dimensions.paddingSizeSmall),


              Expanded(child: Text("issue_date".tr, style: textMedium.copyWith())),
              const SizedBox(width: Dimensions.paddingSizeSmall),

              Expanded(child: Text("return_date".tr, style: textMedium.copyWith())),
              const SizedBox(width: Dimensions.paddingSizeSmall),

              Expanded(child: Text("fine".tr, style: textMedium.copyWith())),
              const SizedBox(width: Dimensions.paddingSizeSmall),

              Expanded(child: Text("lost".tr, style: textMedium.copyWith())),
              const SizedBox(width: Dimensions.paddingSizeSmall),

              Expanded(child: Text("status".tr, style: textMedium.copyWith())),


            ]),
            const CustomDivider(),
          ],

          bookIssueModel != null? (bookIssueModel.data != null && bookIssueModel.data!.data != null && bookIssueModel.data!.data!.isNotEmpty)?
          PaginatedListWidget(scrollController: widget.scrollController,
              onPaginate: (int? offset) async {
                bookController.getIssuedBookList(offset??1);
              }, totalSize: book?.total??0,
              offset: book?.currentPage??0,
              itemView: ListView.builder(
                  itemCount: book?.data?.length??0,
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index){
                    return BookReturnItemWidget(bookIssueItem: book?.data?[index], index: index);
                  })):const NoDataFound(): const Center(child: CircularProgressIndicator(),),

          Align(alignment: Alignment.centerRight,
              child: SizedBox(width: 120, child: CustomButton(onTap: (){
                BookReturnBody body = BookReturnBody(bookIssues: bookController.bookIssues);
                if(bookController.bookIssues.isNotEmpty){
                  bookController.bookReturn(body);
                }else{
                  showCustomSnackBar("select_book".tr);
                }
              }, text: "return_book".tr)))

        ]));
      }
    );
  }
}
