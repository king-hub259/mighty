
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:mighty_school/common/widget/custom_app_bar.dart';
import 'package:mighty_school/common/widget/no_data_found.dart';
import 'package:mighty_school/common/widget/paginated_list_widget.dart';
import 'package:mighty_school/feature/hrm/payroll/controller/payroll_controller.dart';
import 'package:mighty_school/feature/hrm/payroll/presentation/screens/create_new_payroll_screen.dart';
import 'package:mighty_school/feature/hrm/payroll/presentation/widgets/payroll_item_widget.dart';
import 'package:mighty_school/util/styles.dart';

class PayrollScreen extends StatefulWidget {
  const PayrollScreen({super.key});

  @override
  State<PayrollScreen> createState() => _PayrollScreenState();
}

class _PayrollScreenState extends State<PayrollScreen> {
  ScrollController scrollController = ScrollController();
  @override
  void initState() {
    Get.find<PayrollController>().getPayrollList(1);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "payroll".tr),
      body: CustomWebScrollView(slivers: [
        SliverToBoxAdapter(child: GetBuilder<PayrollController>(
            builder: (payrollController) {
              var payroll = payrollController.payrollModel?.data;
              return  payrollController.payrollModel != null? (payrollController.payrollModel!.data!= null && payrollController.payrollModel!.data!.data!.isNotEmpty)?

              Column(children: [
                PaginatedListWidget(scrollController: scrollController,
                    onPaginate: (int? offset){
                      payrollController.getPayrollList(offset??1);
                    }, totalSize: payroll?.total??0,
                    offset: payroll?.currentPage??0,
                    itemView: ListView.builder(
                        itemCount: payroll?.data?.length??0,
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index){
                          return PayrollItemWidget(index: index,
                            payrollItem: payroll?.data?[index],);
                        }))
              ],):
              Padding(padding: ThemeShadow.getPadding(), child: const Center(child: NoDataFound()),
              ):
              Padding(padding: ThemeShadow.getPadding(), child: const Center(child: CircularProgressIndicator()));
            }
        ),)
      ],),


      floatingActionButton: FloatingActionButton.extended(onPressed: (){
        Get.to(()=> const CreateNewPayrollScreen());
      },
        label: Row(children: [
          const Icon(Icons.add), Text("add_new_payroll".tr)
        ],),),
    );
  }
}



