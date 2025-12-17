import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/controller/pick_image_controller.dart';
import 'package:mighty_school/common/widget/custom_button.dart';
import 'package:mighty_school/common/widget/custom_pick_image_widget.dart';
import 'package:mighty_school/common/widget/custom_snackbar.dart';
import 'package:mighty_school/common/widget/custom_text_field.dart';
import 'package:mighty_school/common/widget/custom_title.dart';
import 'package:mighty_school/feature/academic_configuration/signature/controller/signature_controller.dart';
import 'package:mighty_school/feature/academic_configuration/signature/domain/models/signature_list_model.dart';
import 'package:mighty_school/helper/responsive_helper.dart';
import 'package:mighty_school/util/dimensions.dart';

class CreateNewSignatureScreen extends StatefulWidget {
  final SignatureItem? signatureItem;
  const CreateNewSignatureScreen({super.key, this.signatureItem});

  @override
  State<CreateNewSignatureScreen> createState() => _CreateNewSignatureScreenState();
}

class _CreateNewSignatureScreenState extends State<CreateNewSignatureScreen> {

  TextEditingController placeAtController = TextEditingController();
  TextEditingController titleController = TextEditingController();
   bool update = false;
  @override
  void initState() {
    if(widget.signatureItem != null){
      update = true;
      placeAtController.text = widget.signatureItem?.placeAt??'';
      titleController.text = widget.signatureItem?.title??'';
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Dialog(insetPadding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall)),
      child: SizedBox(width: ResponsiveHelper.isDesktop(context)? 500 : Get.width,
        child: Padding(padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
          child: GetBuilder<SignatureController>(
            builder: (signatureController) {
              return Column(mainAxisSize: MainAxisSize.min, children: [
                const Padding(padding: EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault),
                  child: CustomTitle(title: "add_new_signature")),



                CustomTextField(title: "place_at".tr,
                  controller: placeAtController,
                  hintText: "place_at".tr,),

                CustomTextField(title: "title".tr,
                  controller: titleController,
                  hintText: "title".tr,),
                const SizedBox(height: Dimensions.paddingSizeSmall,),


                const CustomPickImageWidget(),


                signatureController.isLoading? const Padding(padding: EdgeInsets.all(Dimensions.paddingSizeDefault),
                  child: Center(child: CircularProgressIndicator())):

                Padding(padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault),
                  child: CustomButton(onTap: (){


                    String title = titleController.text.trim();
                    String placeAt = placeAtController.text.trim();

                    if(title.isEmpty){
                      showCustomSnackBar("priority_is_empty".tr);
                    }
                    else if(placeAt.isEmpty){
                      showCustomSnackBar("place_at_is_empty".tr);
                    }
                    else if(Get.find<PickImageController>().thumbnail == null){
                      showCustomSnackBar("signature_is_empty".tr);
                    }
                    else{
                      if(update){
                        signatureController.updateSignature(placeAt, title, widget.signatureItem!.id!);
                      }else{
                        signatureController.createNewSignature(placeAt, title,);
                      }

                    }
                  }, text:  "confirm".tr))
              ],);
            }
          ),
        ),
      ),
    );
  }
}
