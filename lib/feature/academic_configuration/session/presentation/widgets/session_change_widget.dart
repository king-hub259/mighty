import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/feature/academic_configuration/session/controller/session_controller.dart';
import 'package:mighty_school/feature/academic_configuration/session/presentation/widgets/change_session_dropdown.dart';

class ChangeSessionWidget extends StatefulWidget {
  const ChangeSessionWidget({super.key});

  @override
  State<ChangeSessionWidget> createState() => _ChangeSessionWidgetState();
}

class _ChangeSessionWidgetState extends State<ChangeSessionWidget> {
  @override
  void initState() {
    if(Get.find<SessionController>().sessionModel == null){
      Get.find<SessionController>().getSessionList(1);
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SessionController>(
        builder: (sessionController) {
          return Padding(padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: ChangeSessionDropdown(width: Get.width,
              title: "${"session".tr}: ${sessionController.sessionName??"".tr}",
              items: sessionController.sessionModel?.data?.data??[],
              selectedValue: sessionController.selectedSessionItem,
              onChanged: (val){
                sessionController.selectSession(val!, change: true);
              },
            ),);
        }
    );
  }
}
