import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/custom_title.dart';
import 'package:mighty_school/feature/library_management/book/controller/book_controller.dart';
import 'package:mighty_school/feature/library_management/book/presentation/widgets/book_dropdown_widget.dart';

class SelectBookDropdownWidget extends StatefulWidget {
  const SelectBookDropdownWidget({super.key});

  @override
  State<SelectBookDropdownWidget> createState() => _SelectBookDropdownWidgetState();
}

class _SelectBookDropdownWidgetState extends State<SelectBookDropdownWidget> {
  @override
  void initState() {
    if(Get.find<BookController>().bookModel == null){
      Get.find<BookController>().getBookList(1);
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const CustomTitle(title: "book"),
      GetBuilder<BookController>(
          builder: (bookController) {
            return Padding(padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: BookDropdown(width: Get.width, title: "select".tr,
                items: bookController.bookModel?.data?.data??[],
                selectedValue: bookController.selectedBookItem,
                onChanged: (val){
                  bookController.setSelectBook(val!);
                },
              ),);
          }
      ),
    ],);
  }
}
