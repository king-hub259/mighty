import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/custom_button.dart';
import 'package:mighty_school/common/widget/custom_snackbar.dart';
import 'package:mighty_school/common/widget/custom_text_field.dart';
import 'package:mighty_school/common/widget/custom_title.dart';
import 'package:mighty_school/feature/sms/phone_book/controller/phone_book_controller.dart';
import 'package:mighty_school/feature/sms/phone_book/domain/models/phone_book_body.dart';
import 'package:mighty_school/feature/sms/phone_book/domain/models/phone_book_model.dart';
import 'package:mighty_school/helper/responsive_helper.dart';
import 'package:mighty_school/util/dimensions.dart';

class CreateNewPhoneBookScreen extends StatefulWidget {
  final PhoneBookItem? phoneBookItem;
  const CreateNewPhoneBookScreen({super.key, this.phoneBookItem});

  @override
  State<CreateNewPhoneBookScreen> createState() => _CreateNewPhoneBookScreenState();
}

class _CreateNewPhoneBookScreenState extends State<CreateNewPhoneBookScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
   bool update = false;
  @override
  void initState() {
    if(widget.phoneBookItem != null){
      update = true;
      nameController.text = widget.phoneBookItem?.name??'';
      descriptionController.text = widget.phoneBookItem?.note??'';
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Dialog(insetPadding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall)),
      child: SizedBox(width: ResponsiveHelper.isDesktop(context)? 500 : Get.width,
        child: Padding(
          padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
          child: GetBuilder<PhoneBookController>(
            builder: (phoneBookController) {
              return Column(mainAxisSize: MainAxisSize.min, children: [
                const Padding(padding: EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault),
                  child: CustomTitle(title: "add_new_sms_template")),

                CustomTextField(title: "name".tr,
                  controller: nameController,
                  hintText: "enter_name".tr,),

                CustomTextField(title: "description".tr,
                  controller: descriptionController,
                  hintText: "description".tr,),


                phoneBookController.isLoading? const Padding(padding: EdgeInsets.all(Dimensions.paddingSizeDefault),
                  child: Center(child: CircularProgressIndicator())):

                Padding(padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault),
                  child: CustomButton(onTap: (){
                    String name = nameController.text.trim();
                    String description = descriptionController.text.trim();
                    if(name.isEmpty){
                      showCustomSnackBar("name_is_empty");
                    }else if(description.isEmpty){
                      showCustomSnackBar("priority_is_empty");
                    }else{
                      PhoneBookBody body = PhoneBookBody(
                        name: name,
                        note: description,
                      );
                      if(update){
                        phoneBookController.updatePhoneBook(body, widget.phoneBookItem!.id!);
                      }else{
                        phoneBookController.createPhoneBook(body);
                      }

                    }
                  }, text: update? "update".tr : "save".tr))
              ],);
            }
          ),
        ),
      ),
    );
  }
}
