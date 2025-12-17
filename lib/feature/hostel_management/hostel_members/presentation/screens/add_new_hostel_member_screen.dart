import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/controller/datepicker_controller.dart';
import 'package:mighty_school/common/widget/custom_app_bar.dart';
import 'package:mighty_school/common/widget/custom_button.dart';
import 'package:mighty_school/common/widget/custom_contaner.dart';
import 'package:mighty_school/common/widget/custom_dropdown.dart';
import 'package:mighty_school/common/widget/date_selection_widget.dart';
import 'package:mighty_school/feature/hostel_management/hostel/logic/hostel_controller.dart';
import 'package:mighty_school/feature/hostel_management/hostel/presentation/widgets/select_hostel_widget.dart';
import 'package:mighty_school/feature/hostel_management/hostel_members/domain/model/hostel_member_body.dart';
import 'package:mighty_school/feature/hostel_management/hostel_members/logic/hostel_members_controller.dart';
import 'package:mighty_school/feature/students_information/student/controller/student_controller.dart';
import 'package:mighty_school/feature/students_information/student/presentation/widgets/select_student_widget.dart';
import 'package:mighty_school/helper/responsive_helper.dart';
import 'package:mighty_school/util/dimensions.dart';

class AddNewHostelMemberScreen extends StatefulWidget {
  final int? memberId;
  const AddNewHostelMemberScreen({super.key, this.memberId});

  @override
  State<AddNewHostelMemberScreen> createState() => _AddNewHostelMemberScreenState();
}

class _AddNewHostelMemberScreenState extends State<AddNewHostelMemberScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }




  @override
  Widget build(BuildContext context) {
    return GetBuilder<HostelMembersController>(
      builder: (memberController) {
        return SingleChildScrollView(
          padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
          child: Form(
            key: formKey,
            child: CustomContainer(
              showShadow: ResponsiveHelper.isDesktop(context),
              child: Column(
                children: [
                  // Student selection
                  const SelectStudentWidget(),

                  const SizedBox(height: Dimensions.paddingSizeDefault),

                  // Hostel selection
                  const SelectHostelWidget(),

                  const SizedBox(height: Dimensions.paddingSizeDefault),

                  // Join date
                  const DateSelectionWidget(title: "join_date"),

                  const SizedBox(height: Dimensions.paddingSizeDefault),

                  // Leave date (optional)
                  const DateSelectionWidget(title: "leave_date", end: true),

                  const SizedBox(height: Dimensions.paddingSizeDefault),



                  const SizedBox(height: Dimensions.paddingSizeLarge),

                  // Submit button
                  CustomButton(
                    text: widget.memberId != null ? "update".tr : "add".tr,
                    onTap: () => _submitForm(memberController),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _submitForm(HostelMembersController memberController) {
    final studentController = Get.find<StudentController>();
    final hostelController = Get.find<HostelController>();
    final dateController = Get.find<DatePickerController>();

    // Validation
    if (studentController.selectedStudentItem == null) {
      Get.snackbar("Error", "Please select a student");
      return;
    }
    
    if (hostelController.selectedHostelItem == null) {
      Get.snackbar("Error", "Please select a hostel");
      return;
    }
    
    if (dateController.formatedDate.isEmpty) {
      Get.snackbar("Error", "Please select join date");
      return;
    }

    HostelMemberBody memberBody = HostelMemberBody(
      studentId: studentController.selectedStudentItem!.id.toString(),
      hostelId: hostelController.selectedHostelItem!.id.toString(),
      joinDate: dateController.formatedDate,
      leaveDate: dateController.formatedEndDate.isEmpty ? null : dateController.formatedEndDate,

    );
    
    if (widget.memberId != null) {
      memberController.updateHostelMember(widget.memberId!, memberBody);
    } else {
      memberController.addNewHostelMember(memberBody);
    }
  }
}
