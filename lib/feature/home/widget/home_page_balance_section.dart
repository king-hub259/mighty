
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/feature/sidebar/controller/side_menu_bar_controller.dart';
import 'package:mighty_school/feature/home/domain/model/config_model.dart';
import 'package:mighty_school/helper/price_converter.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/styles.dart';

class HomePageBalanceSection extends StatelessWidget {
  const HomePageBalanceSection({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SideMenuBarController>(
        builder: (homeController) {
          ConfigModel? configModel = homeController.configModel;
          String? balance = configModel?.data?.balance??"0";
          return Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),decoration: BoxDecoration(
              color: Theme.of(context).cardColor, borderRadius: BorderRadius.circular(5)),
            child: Text("${"balance".tr} ${PriceConverter.convertPrice(context, double.parse(balance) )}",
              style: textMedium.copyWith(fontSize: Dimensions.fontSizeDefault),),);
        }
    );
  }
}
