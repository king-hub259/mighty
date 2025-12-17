import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/feature/sms/purchase_sms/domain/models/purchase_sms_model.dart';
import 'package:mighty_school/feature/sms/purchase_sms/presentation/widgets/create_new_purchase_sms_widget.dart';
import 'package:mighty_school/helper/responsive_helper.dart';
import 'package:mighty_school/util/dimensions.dart';

class CreateNewPurchaseSmsScreen extends StatefulWidget {
  final PurchaseSmsItem? purchaseSmsItem;
  const CreateNewPurchaseSmsScreen({super.key, this.purchaseSmsItem});

  @override
  State<CreateNewPurchaseSmsScreen> createState() => _CreateNewPurchaseSmsScreenState();
}

class _CreateNewPurchaseSmsScreenState extends State<CreateNewPurchaseSmsScreen> {


  @override
  Widget build(BuildContext context) {
    return Dialog(insetPadding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall)),
      child: SizedBox(width: ResponsiveHelper.isDesktop(context)? 500 : Get.width,
        child: const Padding(padding: EdgeInsets.all(Dimensions.paddingSizeSmall),
          child: CreateNewPurchaseSmsWidget(),),
      ),
    );
  }
}
