import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:mighty_school/common/widget/custom_app_bar.dart';
import 'package:mighty_school/feature/administrator/event/domain/models/event_model.dart';
import 'package:mighty_school/feature/administrator/event/presentation/widgets/create_new_event_widget.dart';

class CreateNewEventScreen extends StatefulWidget {
  final EventItem? eventItem;
  const CreateNewEventScreen({super.key, this.eventItem});

  @override
  State<CreateNewEventScreen> createState() => _CreateNewEventScreenState();
}

class _CreateNewEventScreenState extends State<CreateNewEventScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: widget.eventItem != null? "update_event".tr :  "create_new_event".tr,),
      body: CustomWebScrollView(slivers: [
        SliverToBoxAdapter(child: CreateNewEventWidget(eventItem: widget.eventItem))
      ],),
    );
  }
}
