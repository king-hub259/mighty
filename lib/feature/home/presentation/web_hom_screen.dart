import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:mighty_school/feature/home/widget/home_main_section_widget.dart';
import 'package:mighty_school/feature/sidebar/controller/side_menu_bar_controller.dart';





class WebHomScreen extends StatefulWidget {
  const WebHomScreen({super.key});

  @override
  WebHomScreenState createState() => WebHomScreenState();
}

class WebHomScreenState extends State<WebHomScreen> {
  ScrollController scrollController = ScrollController();


  @override
  Widget build(BuildContext context) {
    return GetBuilder<SideMenuBarController>(
      builder: (sideMenuController) {
        return CustomWebScrollView(controller: scrollController, slivers: [
          SliverToBoxAdapter(child:
            HomeMainSectionWidget(scrollController: scrollController,)),
        ],);
      }
    );
  }
}