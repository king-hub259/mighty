import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:mighty_school/common/widget/custom_app_bar.dart';
import 'package:mighty_school/feature/cms_management/academic_image/domain/model/academic_image_model.dart';
import 'package:mighty_school/feature/cms_management/academic_image/presentation/widgets/create_new_academic_image_widget.dart';
import 'package:mighty_school/util/dimensions.dart';

class CreateNewFeedbackScreen extends StatefulWidget {
  final AcademicImageItem? imageItem;
  const CreateNewFeedbackScreen({super.key, this.imageItem});

  @override
  State<CreateNewFeedbackScreen> createState() => _CreateNewFeedbackScreenState();
}

class _CreateNewFeedbackScreenState extends State<CreateNewFeedbackScreen> {
  ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "academic_image".tr),
      body: CustomWebScrollView(controller: scrollController, slivers: [

        SliverToBoxAdapter(child: Padding(padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
          child: Padding(padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
            child: CreateNewAcademicImageWidget(imageItem: widget.imageItem),
          ),
        ),)
      ],),
    );
  }
}
