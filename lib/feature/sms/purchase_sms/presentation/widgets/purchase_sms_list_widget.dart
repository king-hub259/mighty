import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/custom_title.dart';
import 'package:mighty_school/common/widget/no_data_found.dart';
import 'package:mighty_school/common/widget/paginated_list_widget.dart';
import 'package:mighty_school/feature/sms/purchase_sms/controller/purchase_sms_controller.dart';
import 'package:mighty_school/feature/sms/purchase_sms/presentation/widgets/create_new_purchase_sms_widget.dart';
import 'package:mighty_school/feature/sms/purchase_sms/presentation/widgets/purchase_sms_item_widget.dart';
import 'package:mighty_school/helper/responsive_helper.dart';

class PurchaseSmsListWidget extends StatefulWidget {
  final ScrollController scrollController;
  const PurchaseSmsListWidget({super.key, required this.scrollController});

  @override
  State<PurchaseSmsListWidget> createState() => _PurchaseSmsListWidgetState();
}

class _PurchaseSmsListWidgetState extends State<PurchaseSmsListWidget> {
  @override
  void initState() {
    Get.find<PurchaseSmsController>().getPurchaseSmsList(1);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return GetBuilder<PurchaseSmsController>(
        builder: (purchaseSmsController) {
          var purchaseSms = purchaseSmsController.purchaseSmsModel?.data;
          return Column(children: [
            if(ResponsiveHelper.isDesktop(context))
              const CreateNewPurchaseSmsWidget(),
            if(ResponsiveHelper.isDesktop(context))
              const CustomTitle(title: "purchase_sms_list"),

            purchaseSmsController.purchaseSmsModel != null? (purchaseSmsController.purchaseSmsModel!.data!= null && purchaseSmsController.purchaseSmsModel!.data!.data!.isNotEmpty)?
            PaginatedListWidget(scrollController: widget.scrollController,
                onPaginate: (int? offset) async => purchaseSmsController.getPurchaseSmsList(offset??1), totalSize: purchaseSms?.total??0,
                offset: purchaseSms?.currentPage??0,
                itemView: ListView.builder(
                    itemCount: purchaseSms?.data?.length??0,
                    padding: EdgeInsets.zero,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index){
                      return PurchaseSmsItemWidget(index: index, purchaseSmsItem: purchaseSms?.data?[index]);
                    })):

            Padding(padding: EdgeInsets.only(top: Get.height/4),
              child: const Center(child: NoDataFound())):
            Padding(padding: EdgeInsets.only(top: Get.height / 4), child: const CircularProgressIndicator()),
          ],);
        }
    );
  }
}
