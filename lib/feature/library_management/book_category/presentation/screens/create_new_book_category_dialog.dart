import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/custom_button.dart';
import 'package:mighty_school/common/widget/custom_snackbar.dart';
import 'package:mighty_school/common/widget/custom_text_field.dart';
import 'package:mighty_school/common/widget/custom_title.dart';
import 'package:mighty_school/feature/library_management/book_category/controller/book_category_controller.dart';
import 'package:mighty_school/feature/library_management/book_category/domain/model/book_category_model.dart';
import 'package:mighty_school/util/dimensions.dart';

class CreateNewBookCategoryScreen extends StatefulWidget {
  final BookCategoryItem? bookCategoryItem;
  const CreateNewBookCategoryScreen({super.key, this.bookCategoryItem});

  @override
  State<CreateNewBookCategoryScreen> createState() => _CreateNewBookCategoryScreenState();
}

class _CreateNewBookCategoryScreenState extends State<CreateNewBookCategoryScreen> {
  TextEditingController nameController = TextEditingController();
  bool update = false;
  @override
  void initState() {
    if(widget.bookCategoryItem != null){
      update = true;
      nameController.text = widget.bookCategoryItem?.categoryName??'';
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Dialog(insetPadding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall)),
      child: Padding(
        padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
        child: GetBuilder<BookCategoryController>(
            builder: (bookCategoryController) {
              return Column(mainAxisSize: MainAxisSize.min, children: [
                 Padding(padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault),
                    child: CustomTitle(title: update?  "update_book_category".tr : "add_new_book_category".tr)),

                CustomTextField(title: "name".tr,
                  controller: nameController,
                  hintText: "enter_name".tr,),



                bookCategoryController.isLoading? const Padding(padding: EdgeInsets.all(Dimensions.paddingSizeDefault),
                  child: Center(child: CircularProgressIndicator())):
                Padding(padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault),
                    child: CustomButton(onTap: (){
                      String name = nameController.text.trim();
                      if(name.isEmpty){
                        showCustomSnackBar("name_is_empty".tr);
                      }else{
                        if(update){
                          bookCategoryController.updateBookCategory(name,  widget.bookCategoryItem!.id!);
                        }else{
                          bookCategoryController.addNewBookCategory(name);
                        }

                      }
                    }, text: "confirm".tr))
              ],);
            }
        ),
      ),
    );
  }
}
