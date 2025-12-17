import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/custom_button.dart';
import 'package:mighty_school/common/widget/custom_contaner.dart';
import 'package:mighty_school/common/widget/custom_snackbar.dart';
import 'package:mighty_school/common/widget/custom_text_field.dart';
import 'package:mighty_school/feature/hostel_management/hostel/domain/model/hostel_body.dart';
import 'package:mighty_school/feature/hostel_management/hostel/domain/model/hostel_model.dart';
import 'package:mighty_school/feature/hostel_management/hostel/logic/hostel_controller.dart';
import 'package:mighty_school/helper/responsive_helper.dart';
import 'package:mighty_school/util/dimensions.dart';

class AddNewHostelScreen extends StatefulWidget {
  final HostelItem? hostelItem;
  const AddNewHostelScreen({super.key, this.hostelItem});

  @override
  State<AddNewHostelScreen> createState() => _AddNewHostelScreenState();
}

class _AddNewHostelScreenState extends State<AddNewHostelScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController typeController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  void initState() {
    nameController.text = widget.hostelItem?.hostelName??'';
    addressController.text = widget.hostelItem?.address??'';
    typeController.text = widget.hostelItem?.type??'';
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HostelController>(
      builder: (hostelController) {
        return Dialog(
          child: CustomContainer(showShadow: ResponsiveHelper.isDesktop(context),
            child: Column(mainAxisSize: MainAxisSize.min,spacing: Dimensions.paddingSizeDefault, children: [


              CustomTextField(controller: nameController,
                  hintText: "hostel_name".tr,
                  title: "hostel_name".tr),

              CustomTextField(controller: addressController,
                  hintText: "address".tr,
                  title: "address".tr),

              CustomTextField(controller: typeController,
                  hintText: "type".tr,
                  title: "type".tr),


              hostelController.isLoading? const Center(child: CircularProgressIndicator()):
              CustomButton(
                text: widget.hostelItem?.id != null ? "update".tr : "add".tr,
                onTap: () {
                  String name = nameController.text.trim();
                  String address = addressController.text.trim();
                  String type = typeController.text.trim();
                  if (name.isEmpty || address.isEmpty || type.isEmpty) {
                    showCustomSnackBar("please_fill_all_fields".tr);
                  }else{
                    HostelBody hostelBody = HostelBody(
                      hostelName: name,
                      address: address,
                      type: type,
                      cMethod: widget.hostelItem?.id != null? "put":"post");
                    if (widget.hostelItem?.id != null) {
                      hostelController.updateHostel(widget.hostelItem!.id!, hostelBody);
                    } else {
                      hostelController.addNewHostel(hostelBody);
                    }
                  }
                },
              ),
            ],
            ),
          ),
        );
      },
    );
  }
  
  @override
  void dispose() {
    nameController.dispose();
    addressController.dispose();
    typeController.dispose();
    super.dispose();
  }
}
