import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/custom_app_bar.dart';
import 'package:mighty_school/common/widget/custom_floating_button.dart';
import 'package:mighty_school/feature/transportation_management/transport_driver/logic/transport_driver_controller.dart';
import 'package:mighty_school/feature/transportation_management/transport_driver/presentation/screens/create_new_transport_driver_dialog.dart';
import 'package:mighty_school/feature/transportation_management/transport_driver/presentation/widgets/transport_driver_widget.dart';

class TransportDriverScreen extends StatefulWidget {
  const TransportDriverScreen({super.key});

  @override
  State<TransportDriverScreen> createState() => _TransportDriverScreenState();
}

class _TransportDriverScreenState extends State<TransportDriverScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    Get.find<TransportDriverController>().getTransportDriverList(1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Transport Driver"),
      body: TransportDriverWidget(scrollController: _scrollController),
      floatingActionButton: CustomFloatingButton(
        onTap: () => Get.dialog(const CreateNewTransportDriverDialog()),
      ),
    );
  }
}