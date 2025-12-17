import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/custom_button.dart';
import 'package:mighty_school/common/widget/custom_snackbar.dart';
import 'package:mighty_school/common/widget/custom_text_field.dart';
import 'package:mighty_school/common/widget/custom_title.dart';
import 'package:mighty_school/feature/library_management/book/controller/book_controller.dart';
import 'package:mighty_school/feature/library_management/book/domain/model/book_model.dart';
import 'package:mighty_school/util/dimensions.dart';

class CreateNewBookScreen extends StatefulWidget {
  final BookItem? bookItem;
  const CreateNewBookScreen({super.key, this.bookItem});

  @override
  State<CreateNewBookScreen> createState() => _CreateNewBookScreenState();
}

class _CreateNewBookScreenState extends State<CreateNewBookScreen> {
  TextEditingController nameController = TextEditingController();
  bool update = false;
  @override
  void initState() {
    if(widget.bookItem != null){
      update = true;
      nameController.text = widget.bookItem?.bookName??'';
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Dialog(insetPadding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall)),
      child: Padding(
        padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
        child: GetBuilder<BookController>(
            builder: (bookController) {
              return Column(mainAxisSize: MainAxisSize.min, children: [
                 Padding(padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault),
                    child: CustomTitle(title: update?  "update_book".tr : "add_new_book".tr)),

                CustomTextField(title: "name".tr,
                  controller: nameController,
                  hintText: "enter_name".tr,),



                bookController.isLoading? const Padding(padding: EdgeInsets.all(Dimensions.paddingSizeDefault),
                  child: Center(child: CircularProgressIndicator())):
                Padding(padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault),
                    child: CustomButton(onTap: (){
                      String name = nameController.text.trim();
                      if(name.isEmpty){
                        showCustomSnackBar("name_is_empty".tr);
                      }else{
                        if(update){
                          bookController.updateBook(name,  widget.bookItem!.id!);
                        }else{
                          bookController.addNewBook(name);
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
