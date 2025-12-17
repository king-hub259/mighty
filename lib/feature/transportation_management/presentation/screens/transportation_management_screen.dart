import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:mighty_school/common/widget/custom_app_bar.dart';
import 'package:mighty_school/common/widget/sub_menu_item_widget.dart';
import 'package:mighty_school/feature/menu_section/controller/menu_type_controller.dart';
import 'package:mighty_school/feature/transportation_management/transport_bus/presentation/screens/transport_bus_screen.dart';
import 'package:mighty_school/feature/transportation_management/transport_bus_route/presentation/screens/transport_bus_route_screen.dart';
import 'package:mighty_school/feature/transportation_management/transport_bus_stop/presentation/screens/transport_bus_stop_screen.dart';
import 'package:mighty_school/feature/transportation_management/transport_driver/presentation/screens/transport_driver_screen.dart';
import 'package:mighty_school/feature/transportation_management/transport_member/presentation/screens/transport_member_screen.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/images.dart';

class TransportationManagementScreen extends StatefulWidget {
  const TransportationManagementScreen({super.key});

  @override
  State<TransportationManagementScreen> createState() => _TransportationManagementScreenState();
}

class _TransportationManagementScreenState extends State<TransportationManagementScreen> {
  List<MainMenuModel> transportationManagementItems = [
    MainMenuModel(icon: Images.warehouse, title: 'transport_buses', widget: const TransportBusScreen()),
    MainMenuModel(icon: Images.staff, title: 'transport_drivers', widget: const TransportDriverScreen()),
    MainMenuModel(icon: Images.routine, title: 'bus_routes', widget: const TransportBusRouteScreen()),
    MainMenuModel(icon: Images.branch, title: 'bus_stops', widget: const TransportBusStopScreen()),
    MainMenuModel(icon: Images.student, title: 'transport_members', widget: const TransportMemberScreen()),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(title: "transportation_management".tr,),
        body: CustomWebScrollView(slivers: [
          SliverToBoxAdapter(child:Padding(padding: const EdgeInsets.only(top: Dimensions.paddingSizeDefault),
            child: ListView.builder(
                itemCount: transportationManagementItems.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                itemBuilder: (context, index){
                  return InkWell(onTap: ()=> Get.to(transportationManagementItems[index].widget),
                      child: SubMenuItemWidget(icon: transportationManagementItems[index].icon, title: transportationManagementItems[index].title)
                  );
                }),
          ),)
        ],)
    );
  }
}


