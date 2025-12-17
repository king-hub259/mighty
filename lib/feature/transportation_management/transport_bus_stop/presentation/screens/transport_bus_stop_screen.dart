import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/custom_app_bar.dart';
import 'package:mighty_school/common/widget/custom_floating_button.dart';
import 'package:mighty_school/feature/transportation_management/transport_bus_stop/logic/transport_bus_stop_controller.dart';
import 'package:mighty_school/feature/transportation_management/transport_bus_stop/presentation/screens/create_new_transport_bus_stop_dialog.dart';
import 'package:mighty_school/feature/transportation_management/transport_bus_stop/presentation/widgets/transport_bus_stop_widget.dart';


class TransportBusStopScreen extends StatefulWidget {
  const TransportBusStopScreen({super.key});

  @override
  State<TransportBusStopScreen> createState() => _TransportBusStopScreenState();
}

class _TransportBusStopScreenState extends State<TransportBusStopScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    Get.find<TransportBusStopController>().getTransportBusStopList(1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Transport Bus Stop"),
      body: TransportBusStopWidget(scrollController: _scrollController),
      floatingActionButton:  CustomFloatingButton(
        onTap: () => Get.dialog(const CreateNewTransportBusStopDialog()),
      ),
    );
  }
}