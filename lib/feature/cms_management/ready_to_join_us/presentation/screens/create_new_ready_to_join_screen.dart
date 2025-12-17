import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:mighty_school/common/widget/custom_app_bar.dart';
import 'package:mighty_school/feature/cms_management/ready_to_join_us/presentation/widgets/create_new_ready_to_join_widget.dart';
import 'package:mighty_school/util/dimensions.dart';

class CreateNewReadyToJoinScreen extends StatefulWidget {
  const CreateNewReadyToJoinScreen({super.key});

  @override
  State<CreateNewReadyToJoinScreen> createState() => _CreateNewReadyToJoinScreenState();
}

class _CreateNewReadyToJoinScreenState extends State<CreateNewReadyToJoinScreen> {
  ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: CustomAppBar(title: "banner".tr),
      body: CustomWebScrollView(controller: scrollController, slivers: const [

        SliverToBoxAdapter(child: Padding(padding: EdgeInsets.all(Dimensions.paddingSizeDefault),
          child: Padding(padding: EdgeInsets.all(Dimensions.paddingSizeDefault),
            child: CreateNewReadyToJoinWidget(),
          ),
        ),)
      ],),
    );
  }
}
