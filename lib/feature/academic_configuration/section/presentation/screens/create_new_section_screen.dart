import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:mighty_school/common/widget/custom_app_bar.dart';
import 'package:mighty_school/feature/academic_configuration/section/domain/model/section_model.dart';
import 'package:mighty_school/feature/academic_configuration/section/presentation/widgets/create_new_section_widget.dart';
import 'package:mighty_school/util/dimensions.dart';

class CreateNewSectionScreen extends StatefulWidget {
  final SectionItem? sectionItem;
  const CreateNewSectionScreen({super.key, this.sectionItem});

  @override
  State<CreateNewSectionScreen> createState() => _CreateNewSectionScreenState();
}

class _CreateNewSectionScreenState extends State<CreateNewSectionScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "add_new_section".tr),
      body: CustomWebScrollView(slivers: [
        SliverToBoxAdapter(child: Padding(
          padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
          child: CreateNewSectionWidget(sectionItem: widget.sectionItem,),
        ),)
      ],),
    );
  }
}
