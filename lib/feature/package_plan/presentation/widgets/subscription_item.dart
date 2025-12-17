import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/custom_button.dart';
import 'package:mighty_school/common/widget/custom_contaner.dart';
import 'package:mighty_school/common/widget/custom_snackbar.dart';
import 'package:mighty_school/feature/institute/controller/institute_controller.dart';
import 'package:mighty_school/feature/package_plan/domain/models/package_model.dart';
import 'package:mighty_school/feature/package_plan/presentation/widgets/call_widget.dart';
import 'package:mighty_school/feature/profile/domain/model/profile_model.dart';
import 'package:mighty_school/feature/profile/logic/profile_controller.dart';
import 'package:mighty_school/helper/price_converter.dart';
import 'package:mighty_school/util/app_constants.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/styles.dart';

class SubscriptionItem extends StatelessWidget {
  final int index;
  final PackageItem? packageItem;
  const SubscriptionItem({super.key, required this.index, this.packageItem});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(
      builder: (profileController) {
        ProfileModel? profileModel = profileController.profileModel;
        return GetBuilder<InstituteController>(
          builder: (instituteController) {
            return Stack(children: [
                CustomContainer(border: Border.all(color: Theme.of(context).primaryColor, width: 1),
                  showShadow: false,
                  borderRadius: Dimensions.paddingSizeExtraSmall,
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text(packageItem?.name??'', style: textRegular.copyWith(fontSize: Dimensions.fontSizeSmall)),
                    if(packageItem?.name?.toLowerCase() != "enterprise" && packageItem!.price! > 0)
                    Row(children: [
                        Text(PriceConverter.convertPrice(context, packageItem?.price??0),
                            style: textSemiBold.copyWith(fontSize: Dimensions.fontSizeExtraLarge)),
                        const SizedBox(width: Dimensions.paddingSizeExtraSmall,),

                      ]),

                    Text("${"duration".tr} : ${packageItem?.durationDays?.toString()??''} ${"days".tr}", style: textRegular.copyWith(fontSize: Dimensions.fontSizeSmall)),

                    Row(children: [
                      Flexible(child: Text(packageItem?.description??'', style: textRegular.copyWith())),
                      if(packageItem?.name?.toLowerCase() == "enterprise")
                      const Padding(padding:  EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
                        child: CallWidget()),
                      ]),
                    if(MediaQuery.sizeOf(context).width>1000)
                    Padding(
                      padding: const EdgeInsets.only(top: Dimensions.paddingSizeDefault),
                      child: CustomButton(text: "subscribe", onTap: (){
                        if(AppConstants.demo){
                          showCustomSnackBar(AppConstants.demoModeMessage.tr);
                        }else {
                          instituteController.updateSubscriptionPlan(packageItem!.id!, profileModel!.data!.instituteInfo!.id! );
                        }
                      },)
                    )
                  ],),),
              ],
            );
          }
        );
      }
    );
  }
}
