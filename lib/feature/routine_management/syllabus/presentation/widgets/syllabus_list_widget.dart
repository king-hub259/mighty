import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/custom_button.dart';
import 'package:mighty_school/common/widget/custom_title.dart';
import 'package:mighty_school/common/widget/no_data_found.dart';
import 'package:mighty_school/common/widget/paginated_list_widget.dart';
import 'package:mighty_school/feature/routine_management/syllabus/controller/syllabus_controller.dart';
import 'package:mighty_school/feature/routine_management/syllabus/presentation/widgets/syllabus_item_widget.dart';
import 'package:mighty_school/helper/responsive_helper.dart';
import 'package:mighty_school/helper/route_helper.dart';
import 'package:mighty_school/util/dimensions.dart';

class SyllabusListWidget extends StatefulWidget {
  final ScrollController scrollController;
  const SyllabusListWidget({super.key, required this.scrollController});

  @override
  State<SyllabusListWidget> createState() => _SyllabusListWidgetState();
}

class _SyllabusListWidgetState extends State<SyllabusListWidget> {
  @override
  void initState() {
    Get.find<SyllabusController>().getSyllabusList(1);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SyllabusController>(
        builder: (syllabusController) {
          var syllabus = syllabusController.syllabusModel?.data;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
            child: Column(children: [
              if(ResponsiveHelper.isDesktop(context))
                CustomTitle(title: "syllabus_list", widget: SizedBox(width: 120, child: CustomButton(onTap: (){
                  Get.toNamed(RouteHelper.getAddNewSyllabusRoute());
                }, text: "add".tr)),),

              const SizedBox(height: Dimensions.paddingSizeDefault),
              syllabusController.syllabusModel != null? (syllabusController.syllabusModel!.data!= null && syllabusController.syllabusModel!.data!.data!.isNotEmpty)?
              PaginatedListWidget(scrollController: widget.scrollController,
                  onPaginate: (int? offset) async => syllabusController.getSyllabusList(offset??1),
                  totalSize: syllabus?.total??0,
                  offset: syllabus?.currentPage??0,
                  itemView: ListView.builder(
                      itemCount: syllabus?.data?.length??0,
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index){
                        return SyllabusItemWidget(index: index, syllabusItem: syllabus?.data?[index],);
                      })):
              Padding(padding: EdgeInsets.only(top: Get.height/4),
                child: const Center(child: NoDataFound()),
              ):
              Padding(padding: EdgeInsets.only(top: Get.height / 4), child: const CircularProgressIndicator()),
            ],),
          );
        }
    );
  }
}
