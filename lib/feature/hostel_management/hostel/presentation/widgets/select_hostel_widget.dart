import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/custom_generic_dropdown.dart';
import 'package:mighty_school/common/widget/custom_title.dart';
import 'package:mighty_school/feature/hostel_management/hostel/domain/model/hostel_model.dart';
import 'package:mighty_school/feature/hostel_management/hostel/logic/hostel_controller.dart';

class SelectHostelWidget extends StatefulWidget {
  const SelectHostelWidget({super.key});

  @override
  State<SelectHostelWidget> createState() => _SelectHostelWidgetState();
}

class _SelectHostelWidgetState extends State<SelectHostelWidget> {
  @override
  void initState() {
    super.initState();
    if (Get.find<HostelController>().hostelModel == null) {
      Get.find<HostelController>().getHostelList(1);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const CustomTitle(title: "hostel"),
        GetBuilder<HostelController>(builder: (hostelController) {
            return Padding(padding: const EdgeInsets.symmetric(vertical: 8.0),
              child:  CustomGenericDropdown<HostelItem>(
                title: "Select Hostel",
                items: hostelController.hostelModel?.data?.data ?? [],
                selectedValue: hostelController.selectedHostelItem,
                onChanged: (val) {
                  hostelController.setSelectedHostel(val!);
                  },
                getLabel: (item) => item.hostelName ?? '',
              ),
            );
          }
        ),
      ],
    );
  }
}
