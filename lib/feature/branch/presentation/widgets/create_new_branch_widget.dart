import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/custom_button.dart';
import 'package:mighty_school/common/widget/custom_snackbar.dart';
import 'package:mighty_school/common/widget/custom_text_field.dart';
import 'package:mighty_school/common/widget/custom_title.dart';
import 'package:mighty_school/feature/branch/controller/branch_controller.dart';
import 'package:mighty_school/feature/branch/domain/models/branch_model.dart';
import 'package:mighty_school/util/dimensions.dart';

class CreateNewBranchWidget extends StatefulWidget {
  final BranchItem? branchItem;
  const CreateNewBranchWidget({super.key, this.branchItem});

  @override
  State<CreateNewBranchWidget> createState() => _CreateNewBranchWidgetState();
}

class _CreateNewBranchWidgetState extends State<CreateNewBranchWidget> {
  TextEditingController branchTitleController = TextEditingController();
  bool update = false;
  @override
  void initState() {
    if(widget.branchItem != null){
      update = true;
      branchTitleController.text = widget.branchItem?.name??'';
      
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Dialog(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimensions.radiusDefault)),
      child: GetBuilder<BranchController>(
          builder: (branchController) {
            return Padding(
              padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                const Padding(padding: EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault),
                    child: CustomTitle(title: "add_new_branch")),

                CustomTextField(title: "branch".tr,
                  controller: branchTitleController,
                  hintText: "name".tr,),


                branchController.isLoading? const Padding(padding: EdgeInsets.all(Dimensions.paddingSizeDefault),
                    child: Center(child: CircularProgressIndicator())):

                Padding(padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault),
                    child: CustomButton(onTap: (){

                      String branch = branchTitleController.text.trim();

                      if(branch.isEmpty){
                        showCustomSnackBar("branch_is_empty".tr);
                      }

                      else{
                        if(update){
                          branchController.updateBranch(branch, widget.branchItem!.id!);
                        }else{
                          branchController.createNewBranch(branch);
                        }

                      }
                    }, text: "confirm".tr))
              ],),
            );
          }
      ),
    );
  }
}
