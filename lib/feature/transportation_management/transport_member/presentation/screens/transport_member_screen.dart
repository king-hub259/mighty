import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/custom_app_bar.dart';
import 'package:mighty_school/common/widget/custom_floating_button.dart';
import 'package:mighty_school/feature/transportation_management/transport_member/logic/transport_member_controller.dart';
import 'package:mighty_school/feature/transportation_management/transport_member/presentation/screens/create_new_transport_member_dialog.dart';
import 'package:mighty_school/feature/transportation_management/transport_member/presentation/widgets/transport_member_widget.dart';

class TransportMemberScreen extends StatefulWidget {
  const TransportMemberScreen({super.key});

  @override
  State<TransportMemberScreen> createState() => _TransportMemberScreenState();
}

class _TransportMemberScreenState extends State<TransportMemberScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    Get.find<TransportMemberController>().getTransportMemberList(1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Transport Member"),
      body: TransportMemberWidget(scrollController: _scrollController),
      floatingActionButton:  CustomFloatingButton(
        onTap: () => Get.dialog(const CreateNewTransportMemberDialog()),
      ),
    );
  }
}