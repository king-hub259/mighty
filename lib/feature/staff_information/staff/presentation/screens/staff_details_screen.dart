import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:mighty_school/common/widget/custom_app_bar.dart';
import 'package:mighty_school/common/widget/custom_image.dart';
import 'package:mighty_school/feature/staff_information/staff/controller/staff_controller.dart';
import 'package:mighty_school/feature/staff_information/staff/domain/models/staff_details_model.dart';
import 'package:mighty_school/util/dimensions.dart';

class StaffDetailsScreen extends StatefulWidget {
  final String name;
  final int id;
  const StaffDetailsScreen({super.key, required this.name, required this.id});

  @override
  State<StaffDetailsScreen> createState() => _StaffDetailsScreenState();
}

class _StaffDetailsScreenState extends State<StaffDetailsScreen> {
  @override
  void initState() {
    Get.find<StaffController>().staffDetails(widget.id);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: widget.name,),
      body: CustomWebScrollView(slivers: [
        SliverToBoxAdapter(child: Padding(
          padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
          child: GetBuilder<StaffController>(
            builder: (studentController) {
              StaffDetailsModel? staff = studentController.staffDetailsModel;
              return staff != null?
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                const Center(child: CustomImage(image: "", width: 120, height: 120,)),
                const SizedBox(height: Dimensions.paddingSizeDefault),
                Text('${"student_name".tr}: ${widget.name}'),
                Text('${"gender".tr}: ${staff.data?.gender??''}'),
                Text('${"religion".tr}: ${staff.data?.religion??''}'),
                Text('${"phone".tr}: ${staff.data?.phone??''}'),
                Text('${"blood_group".tr}: ${staff.data?.blood??''}'),
                Text('${"address".tr}: ${staff.data?.address??''}'),
                Text('${"birthday".tr}: ${staff.data?.birthday??''}'),
              ],): const Center(child: CircularProgressIndicator());
            }
          ),
        ),)
      ],),
    );
  }
}
