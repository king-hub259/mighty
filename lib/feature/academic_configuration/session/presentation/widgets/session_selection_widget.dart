import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/custom_title.dart';
import 'package:mighty_school/feature/academic_configuration/session/controller/session_controller.dart';
import 'package:mighty_school/feature/academic_configuration/session/presentation/widgets/change_session_dropdown.dart';

class SelectSessionWidget extends StatefulWidget {
  const SelectSessionWidget({super.key});

  @override
  State<SelectSessionWidget> createState() => _SelectSessionWidgetState();
}

class _SelectSessionWidgetState extends State<SelectSessionWidget> {
  @override
  void initState() {
    if(Get.find<SessionController>().sessionModel == null){
      Get.find<SessionController>().getSessionList(1);
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      const CustomTitle(title: "academic_session"),
      GetBuilder<SessionController>(
          builder: (sessionController) {
            return Padding(padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: ChangeSessionDropdown(width: Get.width, title: "select".tr,
                items: sessionController.sessionModel?.data?.data??[],
                selectedValue: sessionController.selectedSessionItem,
                onChanged: (val){
                  sessionController.selectSession(val!);
                },
              ),);
          }
      ),
    ],);
  }
}
