import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/custom_app_bar.dart';
import 'package:mighty_school/common/widget/custom_floating_button.dart';
import 'package:mighty_school/feature/transportation_management/transport_bus_route/logic/transport_bus_route_controller.dart';
import 'package:mighty_school/feature/transportation_management/transport_bus_route/presentation/screens/create_new_transport_bus_route_dialog.dart';
import 'package:mighty_school/feature/transportation_management/transport_bus_route/presentation/widgets/transport_bus_route_widget.dart';

class TransportBusRouteScreen extends StatefulWidget {
  const TransportBusRouteScreen({super.key});

  @override
  State<TransportBusRouteScreen> createState() => _TransportBusRouteScreenState();
}

class _TransportBusRouteScreenState extends State<TransportBusRouteScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    Get.find<TransportBusRouteController>().getTransportBusRouteList(1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(title: "Transport Bus Route"),
      body: TransportBusRouteWidget(scrollController: _scrollController),
      floatingActionButton: CustomFloatingButton(onTap: () => Get.dialog(const CreateNewTransportBusRouteDialog()),
      ),
    );
  }
}