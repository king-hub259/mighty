import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:mighty_school/common/widget/custom_app_bar.dart';
import 'package:mighty_school/common/widget/sub_menu_item_widget.dart';
import 'package:mighty_school/feature/fees_management/fees_amount_config/presentation/screens/fees_amount_config_screen.dart';
import 'package:mighty_school/feature/fees_management/fees_date/presentation/screens/fee_date_config_screen.dart';
import 'package:mighty_school/feature/fees_management/fees_mapping/presentation/screens/fees_mapping_screen.dart';
import 'package:mighty_school/feature/fees_management/fees_start_up/presentation/screens/fees_startup_screen.dart';
import 'package:mighty_school/feature/fees_management/paid_info/presentation/screens/paid_reports_screen.dart';
import 'package:mighty_school/feature/fees_management/paid_info/presentation/screens/unpaid_report_screen.dart';
import 'package:mighty_school/feature/fees_management/smart_collection/presentation/screens/smart_collection_screen.dart';
import 'package:mighty_school/feature/fees_management/waiver/presentation/screens/waiver_screen.dart';
import 'package:mighty_school/feature/fees_management/waiver_config/presentation/screens/waiver_config_screen.dart';
import 'package:mighty_school/feature/menu_section/controller/menu_type_controller.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/images.dart';


class FeesManagementScreen extends StatefulWidget {
  const FeesManagementScreen({super.key});

  @override
  State<FeesManagementScreen> createState() => _FeesManagementScreenState();
}

class _FeesManagementScreenState extends State<FeesManagementScreen> {
  List<MainMenuModel> studentInformationItems = [
    MainMenuModel(icon: Images.fine, title: 'fees_startup', widget:  const FeesStartupScreen()),
    MainMenuModel(icon: Images.fine, title: 'fees_mapping', widget:  const FeesMappingScreen()),
    MainMenuModel(icon: Images.pay, title: 'amount_config', widget:  const FeesAmountConfigScreen()),
    MainMenuModel(icon: Images.calender, title: 'date_config', widget:  const FeeDateConfigScreen()),
    MainMenuModel(icon: Images.fine, title: 'fine_waiver', widget:  const WaiverConfigScreen()),
    MainMenuModel(icon: Images.pay, title: 'waiver', widget:  const WaiverScreen()),
    MainMenuModel(icon: Images.smartCollection, title: 'smart_collection', widget:  const SmartCollectionScreen()),
    MainMenuModel(icon: Images.paid, title: 'paid_info', widget:  const PaidReportScreen()),
    MainMenuModel(icon: Images.unpaid, title: 'unpaid_info', widget:  const UnPaidReportScreen()),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(title: "fees_management".tr,),
        body: CustomWebScrollView(slivers: [
          SliverToBoxAdapter(child:Padding(padding: const EdgeInsets.only(top: Dimensions.paddingSizeDefault),
            child: ListView.builder(
                itemCount: studentInformationItems.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                itemBuilder: (context, index){
                  return InkWell(onTap: ()=> Get.to(studentInformationItems[index].widget),
                      child: SubMenuItemWidget(icon: studentInformationItems[index].icon, title: studentInformationItems[index].title)
                  );
                }),
          ),)
        ],)
    );
  }
}
