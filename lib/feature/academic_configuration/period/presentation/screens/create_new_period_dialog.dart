import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/custom_button.dart';
import 'package:mighty_school/common/widget/custom_snackbar.dart';
import 'package:mighty_school/common/widget/custom_text_field.dart';
import 'package:mighty_school/common/widget/custom_title.dart';
import 'package:mighty_school/feature/academic_configuration/period/controller/period_controller.dart';
import 'package:mighty_school/feature/academic_configuration/period/domain/model/period_model.dart';
import 'package:mighty_school/helper/responsive_helper.dart';
import 'package:mighty_school/util/dimensions.dart';

class CreateNewPeriodScreen extends StatefulWidget {
  final PeriodItem? periodItem;
  const CreateNewPeriodScreen({super.key, this.periodItem});

  @override
  State<CreateNewPeriodScreen> createState() => _CreateNewPeriodScreenState();
}

class _CreateNewPeriodScreenState extends State<CreateNewPeriodScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController serialController = TextEditingController();
  bool update = false;
  @override
  void initState() {
    if(widget.periodItem != null){
      update = true;
      nameController.text = widget.periodItem?.period??'';
      serialController.text = widget.periodItem?.serialNo??'';
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Dialog(insetPadding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall)),
      child: Padding(
        padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
        child: SizedBox(width: ResponsiveHelper.isDesktop(context)? 500 : Get.width,
          child: GetBuilder<PeriodController>(
              builder: (periodController) {
                return Column(mainAxisSize: MainAxisSize.min, children: [
                   Padding(padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault),
                      child: CustomTitle(title: update?  "update_period".tr : "add_new_period".tr)),

                  CustomTextField(title: "period_name".tr,
                    controller: nameController,
                    hintText: "enter_period_name".tr,),

                  CustomTextField(title: "serial_no".tr,
                    controller: serialController,
                    inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                    hintText: "enter_period_name".tr,),



                  periodController.isLoading? const Padding(padding: EdgeInsets.all(Dimensions.paddingSizeDefault),
                    child: Center(child: CircularProgressIndicator())):
                  Padding(padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault),
                      child: CustomButton(onTap: (){
                        String name = nameController.text.trim();
                        String serial = serialController.text.trim();
                        if(name.isEmpty){
                          showCustomSnackBar("name_is_empty".tr);
                        }
                        else if(serial.isEmpty){
                          showCustomSnackBar("serial_is_empty".tr);
                        }
                        else{
                          if(update){
                            periodController.updateNewPeriod(name, serial, widget.periodItem!.id!);
                          }else{
                            periodController.addNewPeriod(name, serial);
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
