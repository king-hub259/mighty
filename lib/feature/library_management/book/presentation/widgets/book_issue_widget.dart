import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/custom_button.dart';
import 'package:mighty_school/common/widget/custom_contaner.dart';
import 'package:mighty_school/common/widget/custom_image.dart';
import 'package:mighty_school/common/widget/custom_snackbar.dart';
import 'package:mighty_school/common/widget/custom_text_field.dart';
import 'package:mighty_school/common/widget/custom_title.dart';
import 'package:mighty_school/feature/library_management/book/controller/book_controller.dart';
import 'package:mighty_school/feature/library_management/book/domain/model/book_issue_body.dart';
import 'package:mighty_school/feature/library_management/book/presentation/widgets/book_selection_dropdown_widget.dart';
import 'package:mighty_school/feature/library_management/book/presentation/widgets/selected_book_list_widget.dart';
import 'package:mighty_school/feature/library_management/library_member/controller/library_member_controller.dart';
import 'package:mighty_school/feature/library_management/library_member/presentation/widgets/member_selection_dropdown_widget.dart';
import 'package:mighty_school/helper/responsive_helper.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/styles.dart';

class BookIssueWidget extends StatefulWidget {
  const BookIssueWidget({super.key});

  @override
  State<BookIssueWidget> createState() => _BookIssueWidgetState();
}

class _BookIssueWidgetState extends State<BookIssueWidget> {
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return GetBuilder<BookController>(
      builder: (bookController) {
        return GetBuilder<LibraryMemberController>(
          builder: (memberController) {
            return CustomContainer(color: ResponsiveHelper.isDesktop(context)? Theme.of(context).cardColor : Colors.transparent, showShadow: false,
              child: Column(children: [
                CustomTitle(title: "book_issue".tr),
                Row(children: [
                  const Expanded(child: SelectBookDropdownWidget()),
                  const SizedBox(width: Dimensions.paddingSizeSmall),
                  Expanded(child: CustomTextField(title: "search_book".tr, hintText: "search", controller: searchController,))
                ],),

                const SelectedBookListWidget(),


                Row(children: [
                  const Expanded(child: SelectMemberDropdownWidget()),
                  const SizedBox(width: Dimensions.paddingSizeSmall),
                  Expanded(child: CustomTextField(title: "search_book".tr, hintText: "search", controller: searchController,))
                ],),

                if(memberController.selectedMemberItem != null)
                Row(children: [
                  CustomImage(width: 100, height:100, image: memberController.selectedMemberItem?.user?.image),
                  const SizedBox(width: Dimensions.paddingSizeSmall),
                  Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text("${"id".tr} : ${memberController.selectedMemberItem?.libraryId}", style: textRegular),
                    Text("${"name".tr} : ${memberController.selectedMemberItem?.user?.name}", style: textRegular),
                    Text("${"occupation".tr} : ${memberController.selectedMemberItem?.memberType}",  style: textRegular),
                    Text("${"phone".tr} : ${memberController.selectedMemberItem?.user?.phone}",  style: textRegular),
                  ]))
                ],),

                Align(alignment: Alignment.centerRight, child: SizedBox(width: 120, child: CustomButton(onTap: (){
                  String? libraryId = memberController.selectedMemberItem?.libraryId;
                  if(bookController.selectedBookItems.isEmpty){
                    showCustomSnackBar("select_book_items".tr);
                  }else if(libraryId == null){
                    showCustomSnackBar("select_member".tr);
                  }else{
                    BookIssueBody body = BookIssueBody(
                     libraryId: libraryId,
                      bookIds: bookController.selectedBookItems.map((book) => book.id.toString()).toList(),
                      returnDates : bookController.selectedBookItems.map((book) => book.returnDate.toString()).toList(),
                    );
                    bookController.bookIssue(body);
                  }
                }, text: "book_issue".tr)))

              ],),
            );
          }
        );
      }
    );
  }
}
