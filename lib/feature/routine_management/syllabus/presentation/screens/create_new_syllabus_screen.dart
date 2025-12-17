
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:mighty_school/common/widget/custom_app_bar.dart';
import 'package:mighty_school/feature/routine_management/syllabus/domain/models/syllabus_model.dart';
import 'package:mighty_school/feature/routine_management/syllabus/presentation/widgets/create_new_syllabus_widget.dart';
import 'package:mighty_school/util/dimensions.dart';

class CreateNewSyllabusScreen extends StatefulWidget {
  final SyllabusItem? syllabusItem;
  const CreateNewSyllabusScreen({super.key, this.syllabusItem});

  @override
  State<CreateNewSyllabusScreen> createState() => _CreateNewSyllabusScreenState();
}

class _CreateNewSyllabusScreenState extends State<CreateNewSyllabusScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
   bool update = false;
  @override
  void initState() {
    if(widget.syllabusItem != null){
      update = true;
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: update? "update_new_syllabus".tr : "add_new_syllabus".tr),
      body: CustomWebScrollView(slivers: [

        SliverToBoxAdapter(child: Padding(padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
          child: CreateNewSyllabusWidget(syllabusItem: widget.syllabusItem,),
        ))
      ],),
    );
  }
}
