import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/coutom_royte_path/custom_route_path_widget.dart';
import 'package:mighty_school/common/widget/custom_contaner.dart';
import 'package:mighty_school/common/widget/custom_divider.dart';
import 'package:mighty_school/common/widget/no_data_found.dart';
import 'package:mighty_school/common/widget/paginated_list_widget.dart';
import 'package:mighty_school/feature/institute/controller/institute_controller.dart';
import 'package:mighty_school/feature/institute/presentation/widgets/institute_item_widget.dart';
import 'package:mighty_school/helper/responsive_helper.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/styles.dart';

class InstituteListWidget extends StatefulWidget {
  final ScrollController scrollController;
  const InstituteListWidget({super.key, required this.scrollController});

  @override
  State<InstituteListWidget> createState() => _InstituteListWidgetState();
}

class _InstituteListWidgetState extends State<InstituteListWidget> {
  @override
  void initState() {
    Get.find<InstituteController>().getInstituteList(1);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return GetBuilder<InstituteController>(
        builder: (instituteController) {
          var institute = instituteController.instituteModel?.data;
          return Column(children: [
            if(ResponsiveHelper.isDesktop(context))
              Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault),
                child: CustomRoutePathWidget(title: "institute".tr, subWidget: PathItemWidget(title : "institute_list".tr))),
              CustomContainer(horizontalPadding: 0, color: ResponsiveHelper.isDesktop(context)? Theme.of(context).cardColor : Theme.of(context).scaffoldBackgroundColor, showShadow: false,
                child: Padding(
                  padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
                  child: Column(children: [
                    if(ResponsiveHelper.isDesktop(context))...[
                      const SizedBox(height: Dimensions.paddingSizeDefault,),

                      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                        SizedBox(width: 50, child: Text("#".tr, style: textMedium.copyWith(fontSize: Dimensions.fontSizeLarge),)),
                        Expanded(child: Text("institute".tr, style: textMedium.copyWith(fontSize: Dimensions.fontSizeLarge),)),
                        Expanded(child: Text("domain".tr, style: textMedium.copyWith(fontSize: Dimensions.fontSizeLarge),)),
                        Expanded(child: Text("phone".tr, style: textMedium.copyWith(fontSize: Dimensions.fontSizeLarge),)),
                        Expanded(child: Text("email".tr, style: textMedium.copyWith(fontSize: Dimensions.fontSizeLarge),)),
                        Expanded(child: Text("type".tr, style: textMedium.copyWith(fontSize: Dimensions.fontSizeLarge),)),
                      ]),

                      const Padding(padding: EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall),
                        child: CustomDivider())
                    ],

                    instituteController.instituteModel != null? (instituteController.instituteModel!.data!= null && instituteController.instituteModel!.data!.data!.isNotEmpty)?
                    PaginatedListWidget(scrollController: widget.scrollController,
                        onPaginate: (int? offset) async {
                          await instituteController.getInstituteList(offset??1);
                        }, totalSize: institute?.total??0,
                        offset: institute?.currentPage??0,
                        itemView: Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: ListView.builder(
                              itemCount: institute?.data?.length??0,
                              padding: EdgeInsets.zero,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemBuilder: (context, index){
                                return InstituteItemWidget(index: index, instituteItem: institute?.data?[index],);
                              }),
                        )):
                    Padding(padding: EdgeInsets.only(top: Get.height/4),
                      child: const Center(child: NoDataFound()),
                    ):
                    Padding(padding: EdgeInsets.only(top: Get.height / 4), child: const CircularProgressIndicator()),
                  ],),
                ),
              ),
            ],
          );
        }
    );
  }
}
