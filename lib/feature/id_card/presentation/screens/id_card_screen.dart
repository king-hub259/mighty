
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:mighty_school/common/widget/custom_app_bar.dart';
import 'package:mighty_school/feature/id_card/logic/id_card_controller.dart';
import 'package:mighty_school/feature/id_card/presentation/widgets/id_card_type_selection_widget_widget.dart';
import 'package:mighty_school/feature/layout_and_certificate/enum/certificate_type_enum.dart';
import 'package:mighty_school/feature/layout_and_certificate/presentation/widgets/certificate_and_letter_widget.dart';
import 'package:mighty_school/feature/id_card/presentation/widgets/id_card_widget.dart';

class IdCardScreen extends StatefulWidget {
  const IdCardScreen({super.key});

  @override
  State<IdCardScreen> createState() => _IdCardScreenState();
}

class _IdCardScreenState extends State<IdCardScreen> {
  ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: CustomAppBar(title: "id_card".tr),
      body: CustomWebScrollView(controller: scrollController, slivers: [

        SliverToBoxAdapter(child:
         GetBuilder<IdCardController>(
           builder: (idCardController) {
             return Column(mainAxisSize: MainAxisSize.min,
               children: [
                 const IdCardTypeSelectionWidget(),
                 if(idCardController.idTypeIndex == 2)
                 const IdCardWidget(),
               ],
             );
           }
         ))
      ],),
    );
  }
}



