
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:mighty_school/common/widget/custom_app_bar.dart';
import 'package:mighty_school/feature/master_configuration/employee/domain/models/employee_model.dart';
import 'package:mighty_school/feature/master_configuration/employee/presentation/widgets/create_new_employee_widget.dart';
import 'package:mighty_school/util/dimensions.dart';

class CreateNewEmployeeScreen extends StatefulWidget {
  final EmployeeItem? employeeItem;
  const CreateNewEmployeeScreen({super.key, this.employeeItem});

  @override
  State<CreateNewEmployeeScreen> createState() => _CreateNewEmployeeScreenState();
}

class _CreateNewEmployeeScreenState extends State<CreateNewEmployeeScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: CustomAppBar(title: "add_new_employee".tr,),
      body: CustomWebScrollView(slivers: [
        SliverToBoxAdapter(child: Column(children: [
          Padding(padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
            child: CreateNewEmployeeWidget(employeeItem: widget.employeeItem),),
        ],),)
      ],),
    );
  }
}
