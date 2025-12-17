import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:mighty_school/common/widget/custom_app_bar.dart';
import 'package:mighty_school/common/widget/no_data_found.dart';
import 'package:mighty_school/feature/parent_module/parent_library/controller/parent_library_controller.dart';
import 'package:mighty_school/feature/parent_module/parent_library/domain/model/library_history_model.dart';
import 'package:mighty_school/feature/parent_module/parent_library/presentation/widgets/library_history_item_widget.dart';
import 'package:mighty_school/feature/parent_module/parent_subject/controller/parent_subject_controller.dart';
import 'package:mighty_school/util/styles.dart';

class ParentLibraryScreen extends StatefulWidget {
  const ParentLibraryScreen({super.key});

  @override
  State<ParentLibraryScreen> createState() => _ParentLibraryScreenState();
}

class _ParentLibraryScreenState extends State<ParentLibraryScreen> {
  @override
  void initState() {
    Get.find<ParentLibraryController>().getLibraryHistoryList();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar : CustomAppBar(title: "library_history".tr),
    body: CustomWebScrollView(slivers: [


      SliverToBoxAdapter(child: GetBuilder<ParentSubjectController>(
          builder: (subjectController) {
            return GetBuilder<ParentLibraryController>(
                builder: (libraryController) {
                  LibraryHistoryModel? libraryHistoryModel = libraryController.libraryHistoryModel;
                  var libraryHistory = libraryHistoryModel?.data?.issues;
                  return Column(children: [
                    libraryHistoryModel != null? (libraryHistory != null && libraryHistory.isNotEmpty)?
                    ListView.builder(
                        itemCount: libraryHistory.length,
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index){
                          return LibraryHistoryItemWidget(index: index, bookIssueItem: libraryHistory[index],);
                        }):
                    Padding(padding: ThemeShadow.getPadding(),
                      child: const Center(child: NoDataFound()),
                    ):
                    Padding(padding: ThemeShadow.getPadding(), child: const CircularProgressIndicator()),
                  ],);
                }
            );
          }
      ),)
    ],));
  }
}
