import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:mighty_school/common/widget/custom_app_bar.dart';
import 'package:mighty_school/feature/cms_management/academic_image/presentation/widgets/academic_image_list_widget.dart';
import 'package:mighty_school/util/dimensions.dart';


class AcademicImageScreen extends StatefulWidget {
  const AcademicImageScreen({super.key});

  @override
  State<AcademicImageScreen> createState() => _AcademicImageScreenState();
}

class _AcademicImageScreenState extends State<AcademicImageScreen> {
  ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return  Scaffold(appBar: CustomAppBar(title: "academic_image".tr),
      body: CustomWebScrollView(controller: scrollController, slivers: [

        SliverToBoxAdapter(child: Padding(padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
          child: Padding(padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
            child: AcademicImageListWidget(scrollController: scrollController),
          ),
        ),)
      ],),
    );
  }
}
