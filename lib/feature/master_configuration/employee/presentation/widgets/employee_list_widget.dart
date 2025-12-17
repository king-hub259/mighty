
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/custom_button.dart';
import 'package:mighty_school/common/widget/custom_contaner.dart';
import 'package:mighty_school/common/widget/custom_divider.dart';
import 'package:mighty_school/common/widget/custom_title.dart';
import 'package:mighty_school/common/widget/no_data_found.dart';
import 'package:mighty_school/common/widget/paginated_list_widget.dart';
import 'package:mighty_school/feature/master_configuration/employee/controller/employee_controller.dart';
import 'package:mighty_school/feature/master_configuration/employee/presentation/widgets/create_new_employee_widget.dart';
import 'package:mighty_school/feature/master_configuration/employee/presentation/widgets/employee_item_widget.dart';
import 'package:mighty_school/helper/responsive_helper.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/styles.dart';

class EmployeeListWidget extends StatelessWidget {
  final ScrollController scrollController;
  const EmployeeListWidget({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<EmployeeController>(
      initState: (val) => Get.find<EmployeeController>().getEmployeeList(1),
        builder: (employeeController) {
          var employee = employeeController.employeeModel?.data;
          return  employeeController.employeeModel != null? (employeeController.employeeModel!.data!= null && employeeController.employeeModel!.data!.data!.isNotEmpty)?
          CustomContainer(color: ResponsiveHelper.isDesktop(context)? Theme.of(context).cardColor : Theme.of(context).scaffoldBackgroundColor,
            child: Column(children: [
              if(ResponsiveHelper.isDesktop(context))...[
                CustomTitle(title: "employee_list", widget: SizedBox(width: 120, child: CustomButton(onTap: (){
                  Get.bottomSheet(isScrollControlled: true, Container(width: Get.width,
                    padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
                    decoration: BoxDecoration(borderRadius: const BorderRadius.vertical(top: Radius.circular(Dimensions.radiusLarge)),
                        color: Theme.of(context).cardColor),
                      child: const CreateNewEmployeeWidget()));
                }, text: "add".tr)),),
                const SizedBox(height: Dimensions.paddingSizeSmall),
                const CustomDivider(),
                Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
                  child: Row(spacing: Dimensions.paddingSizeSmall, children: [
                    Text("#".tr, style: textRegular.copyWith(fontSize: Dimensions.fontSizeDefault),),
                    Expanded(child: Text("name".tr, style: textRegular.copyWith(fontSize: Dimensions.fontSizeDefault),)),
                    Expanded(child: Text("role".tr, style: textRegular.copyWith(),)),
                    Expanded(child: Text("phone".tr, style: textRegular.copyWith(),)),
                    Expanded(child: Text("department".tr, style: textRegular.copyWith(),)),
                    SizedBox(width: 60, child: Text("action".tr, style: textRegular.copyWith(),)),
                  ])),
                const CustomDivider(),
              ],
              PaginatedListWidget(scrollController: scrollController,
                  onPaginate: (int? offset){
                    employeeController.getEmployeeList(offset??1);
                  }, totalSize: employee?.total??0,
                  offset: employee?.currentPage??0,
                  itemView: ListView.builder(
                      itemCount: employee?.data?.length??0,
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index){
                        return EmployeeItemWidget(index: index,
                          employeeItem: employee?.data?[index],);
                      }))
            ],),
          ):
          Padding(padding: EdgeInsets.symmetric(vertical: Get.height/2),
            child: const Center(child: NoDataFound()),
          ):
          Padding(padding: ThemeShadow.getPadding(), child: const Center(child: CircularProgressIndicator()));
        }
    );
  }
}
