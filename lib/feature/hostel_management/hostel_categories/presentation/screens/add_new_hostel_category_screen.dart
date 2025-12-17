import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/custom_button.dart';
import 'package:mighty_school/common/widget/custom_snackbar.dart';
import 'package:mighty_school/common/widget/custom_text_field.dart';
import 'package:mighty_school/feature/hostel_management/hostel/domain/model/hostel_model.dart';
import 'package:mighty_school/feature/hostel_management/hostel/logic/hostel_controller.dart';
import 'package:mighty_school/feature/hostel_management/hostel/presentation/widgets/select_hostel_widget.dart';
import 'package:mighty_school/feature/hostel_management/hostel_categories/domain/model/hostel_category_body.dart';
import 'package:mighty_school/feature/hostel_management/hostel_categories/domain/model/hostel_category_model.dart';
import 'package:mighty_school/feature/hostel_management/hostel_categories/logic/hostel_categories_controller.dart';
import 'package:mighty_school/helper/responsive_helper.dart';
import 'package:mighty_school/util/app_constants.dart';
import 'package:mighty_school/util/dimensions.dart';

class AddNewHostelCategoryScreen extends StatefulWidget {
  final HostelCategoryItem? categoryItem;
  const AddNewHostelCategoryScreen({super.key, this.categoryItem});

  @override
  State<AddNewHostelCategoryScreen> createState() => _AddNewHostelCategoryScreenState();
}

class _AddNewHostelCategoryScreenState extends State<AddNewHostelCategoryScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    Get.find<HostelController>().setSelectedHostel(HostelItem(
      id: widget.categoryItem?.hostelId,
      hostelName: widget.categoryItem?.hostelName
    ), notify: false);
    nameController.text = widget.categoryItem?.hostelName??'';
    priceController.text = widget.categoryItem?.hostelFee?.toString()??'';
    super.initState();

  }



  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: SizedBox(width: ResponsiveHelper.isDesktop(context)? 600 : Get.width,
        child: Padding(padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
          child: GetBuilder<HostelCategoriesController>(builder: (categoryController) {
              return Form(key: formKey,
                child: Column(mainAxisSize: MainAxisSize.min, spacing: Dimensions.paddingSizeDefault,
                  crossAxisAlignment: CrossAxisAlignment.start, children: [

                  const SelectHostelWidget(),

                    CustomTextField(controller: nameController,
                      title: "standard".tr,
                      hintText: "enter_standard".tr),

                    CustomTextField(
                      controller: priceController,
                      title: "hostel_fee".tr,
                      hintText: "enter_hostel_fee".tr,
                      inputType: TextInputType.number,
                      inputFormatters: [AppConstants.numberFormat],
                     ),
                  const SizedBox(height: Dimensions.paddingSizeDefault),


                  GetBuilder<HostelCategoriesController>(
                    builder: (hostelCategoryController) {
                      return hostelCategoryController.isLoading?const Center(child: CircularProgressIndicator(),):
                      CustomButton(onTap: (){
                        String? hostelId = Get.find<HostelController>().selectedHostelItem?.id.toString();
                        String? standard = nameController.text.trim();
                        String? price = priceController.text.trim();

                        if(hostelId == null){
                          showCustomSnackBar("select_hostel".tr);
                        }else if(standard.isEmpty){
                          showCustomSnackBar("standard_is_empty".tr);
                        }else if(price.isEmpty){
                          showCustomSnackBar("price_is_empty".tr);
                        }else{
                          HostelCategoryBody body =HostelCategoryBody(
                            hostelId: hostelId,
                            standard: standard,
                            price: price,

                          );
                          if(widget.categoryItem != null){
                            hostelCategoryController.updateHostelCategory(widget.categoryItem!.id!, body);
                          }else{
                         hostelCategoryController.addNewHostelCategory(body);
                        }}

                      }, text: widget.categoryItem != null? "update".tr : "save".tr);
                    }
                  )


                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
