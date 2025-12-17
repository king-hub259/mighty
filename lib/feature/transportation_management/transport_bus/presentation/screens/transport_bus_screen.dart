import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/custom_app_bar.dart';
import 'package:mighty_school/common/widget/custom_floating_button.dart';
import 'package:mighty_school/feature/transportation_management/transport_bus/logic/transport_bus_controller.dart';
import 'package:mighty_school/feature/transportation_management/transport_bus/presentation/screens/create_new_transport_bus_dialog.dart';
import 'package:mighty_school/feature/transportation_management/transport_bus/presentation/widgets/transport_bus_widget.dart';

class TransportBusScreen extends StatefulWidget {
  const TransportBusScreen({super.key});

  @override
  State<TransportBusScreen> createState() => _TransportBusScreenState();
}

class _TransportBusScreenState extends State<TransportBusScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    Get.find<TransportBusController>().getTransportBusList(1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Transport Bus"),
      body: TransportBusWidget(scrollController: _scrollController),
      floatingActionButton: CustomFloatingButton(
        onTap: () => Get.dialog(const CreateNewTransportBusDialog()),
      ),
    );
  }
}