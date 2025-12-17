import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/custom_title.dart';
import 'package:mighty_school/feature/library_management/library_member/controller/library_member_controller.dart';
import 'package:mighty_school/feature/library_management/library_member/presentation/widgets/member_dropdown_widget.dart';

class SelectMemberDropdownWidget extends StatefulWidget {
  const SelectMemberDropdownWidget({super.key});

  @override
  State<SelectMemberDropdownWidget> createState() => _SelectMemberDropdownWidgetState();
}

class _SelectMemberDropdownWidgetState extends State<SelectMemberDropdownWidget> {
  @override
  void initState() {
    if(Get.find<LibraryMemberController>().libraryMemberModel == null){
      Get.find<LibraryMemberController>().getMemberList(1);
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const CustomTitle(title: "member"),
      GetBuilder<LibraryMemberController>(
          builder: (memberController) {
            return Padding(padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: MemberDropdown(width: Get.width, title: "select".tr,
                items: memberController.libraryMemberModel?.data?.data??[],
                selectedValue: memberController.selectedMemberItem,
                onChanged: (val){
                  memberController.selectMember(val!);
                },
              ),);
          }
      ),
    ],);
  }
}
