import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:mighty_school/common/widget/custom_app_bar.dart';
import 'package:mighty_school/common/widget/sub_menu_item_widget.dart';
import 'package:mighty_school/feature/menu_section/controller/menu_type_controller.dart';
import 'package:mighty_school/feature/sms/phone_book/presentation/screens/phone_book_screen.dart';
import 'package:mighty_school/feature/sms/phone_book_category/presentation/screens/phone_book_category_screen.dart';
import 'package:mighty_school/feature/sms/purchase_sms/presentation/screens/purchase_sms_screen.dart';
import 'package:mighty_school/feature/sms/sms_template/presentation/screens/sms_template_screen.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/images.dart';


class SmsManagementScreen extends StatefulWidget {
  const SmsManagementScreen({super.key});

  @override
  State<SmsManagementScreen> createState() => _SmsManagementScreenState();
}

class _SmsManagementScreenState extends State<SmsManagementScreen> {
  List<MainMenuModel> studentInformationItems = [
    MainMenuModel(icon: Images.purchase, title: 'sms_template', widget:  const SmsTemplateScreen()),
    MainMenuModel(icon: Images.productReturn, title: 'phone_book_category', widget:  const PhoneBookCategoryScreen()),
    MainMenuModel(icon: Images.productReturn, title: 'phone_book', widget:  const PhoneBookScreen()),
    MainMenuModel(icon: Images.productReturn, title: 'sms_sent', widget:  const PurchaseSmsScreen()),
    MainMenuModel(icon: Images.productReturn, title: 'purchase_sms', widget:  const PurchaseSmsScreen()),
    MainMenuModel(icon: Images.productReturn, title: 'sms_report', widget:  const PurchaseSmsScreen()),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(title: "academic_configuration".tr,),
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
