import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/custom_button.dart';
import 'package:mighty_school/common/widget/custom_text_field.dart';
import 'package:mighty_school/feature/cms_management/academic_image/domain/model/academic_image_model.dart';
import 'package:mighty_school/feature/cms_management/academic_image/logic/academic_image_controller.dart';
import 'package:mighty_school/feature/cms_management/academic_image/presentation/widgets/academic_image_widget.dart';
import 'package:mighty_school/util/dimensions.dart';


class CreateNewAcademicImageWidget extends StatefulWidget {
  final AcademicImageItem? imageItem;
  const CreateNewAcademicImageWidget({super.key, this.imageItem});

  @override
  State<CreateNewAcademicImageWidget> createState() => _CreateNewAcademicImageWidgetState();
}

class _CreateNewAcademicImageWidgetState extends State<CreateNewAcademicImageWidget> {
  TextEditingController nameController = TextEditingController();


  @override
  void initState() {
    if(widget.imageItem != null) {
      nameController.text = widget.imageItem?.title??'';
    }
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return GetBuilder<AcademicImageController>(
        builder: (academicImageController) {
          return Column(mainAxisSize: MainAxisSize.min, children: [
            CustomTextField(title: "name".tr, hintText: "name".tr, controller: nameController, maxLength: 100),
            AcademicImageWidget(imageItem: widget.imageItem,),

            const SizedBox(height: Dimensions.paddingSizeLarge),
            academicImageController.loading? const Center(child: CircularProgressIndicator()) :
            CustomButton(
              onTap: () {
                String name = nameController.text.trim();
                if(widget.imageItem != null){
                  academicImageController.editAcademicImage(name, widget.imageItem?.id??0);
                }else {
                  academicImageController.createAcademicImage(name);
                }
              },
              text: widget.imageItem != null?"update".tr : "add".tr,
            ),
          ]);
        }
    );
  }
}
