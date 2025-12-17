
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:mighty_school/common/widget/custom_app_bar.dart';
import 'package:mighty_school/common/widget/custom_floating_button.dart';
import 'package:mighty_school/feature/master_configuration/employee/presentation/screens/create_new_employee_screen.dart';
import 'package:mighty_school/feature/master_configuration/employee/presentation/widgets/employee_list_widget.dart';

class EmployeeScreen extends StatefulWidget {
  const EmployeeScreen({super.key});

  @override
  State<EmployeeScreen> createState() => _EmployeeScreenState();
}

class _EmployeeScreenState extends State<EmployeeScreen> {
  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "employee".tr),
      body: CustomWebScrollView(slivers: [
        SliverToBoxAdapter(child: EmployeeListWidget(scrollController: scrollController))
      ],),


      floatingActionButton: CustomFloatingButton(onTap: ()=>Get.to(()=> const CreateNewEmployeeScreen()))

    );
  }
}



