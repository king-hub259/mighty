
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/layout/list_layout_widget.dart';
import 'package:mighty_school/feature/hostel_management/hostel_bill/domain/model/hostel_bill_model.dart';
import 'package:mighty_school/feature/hostel_management/hostel_bill/logic/hostel_bill_controller.dart';
import 'package:mighty_school/feature/hostel_management/hostel_bill/presentation/widgets/hostel_bill_item_widget.dart';

class HostelBillListWidget extends StatelessWidget {
  final ScrollController? scrollController;

  const HostelBillListWidget({super.key, this.scrollController});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HostelBillController>(
      initState: (val) => Get.find<HostelBillController>().getHostelBill(1),
      builder: (billController) {
        final categoryModel = billController.hostelBillModel;
        final categoryData = categoryModel?.data;

        return GenericListSection<HostelBillItem>(
          sectionTitle: "hostel_management".tr,
          pathItems: ["hostel_bill".tr],
          headings: const [
            "student",
            "hostel_fee",
            "meal_fee",
            "total",
          ],

          scrollController: scrollController ?? ScrollController(),
          isLoading: categoryModel == null,
          totalSize: categoryData?.total ?? 0,
          offset: categoryData?.currentPage ?? 0,
          onPaginate: (offset) async => await billController.getHostelBill(offset ?? 1),

          items: categoryData?.data ?? [],
          itemBuilder: (item, index) => HostelBillItemWidget(
              billItem: item,
              index: index
          ),
        );
      },
    );
  }
}
