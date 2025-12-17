import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/custom_button.dart';
import 'package:mighty_school/common/widget/custom_contaner.dart';
import 'package:mighty_school/common/widget/custom_divider.dart';
import 'package:mighty_school/common/widget/custom_dropdown.dart';
import 'package:mighty_school/common/widget/custom_text_field.dart';
import 'package:mighty_school/common/widget/no_data_found.dart';
import 'package:mighty_school/common/widget/paginated_list_widget.dart';
import 'package:mighty_school/feature/library_management/book/controller/book_controller.dart';
import 'package:mighty_school/feature/library_management/book/domain/model/book_issue_report_model.dart';
import 'package:mighty_school/feature/library_management/book/presentation/widgets/book_issue_report_result_item_widget.dart';
import 'package:mighty_school/helper/responsive_helper.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/styles.dart';

class BookIssueReportListWidget extends StatefulWidget {
  final ScrollController scrollController;
  const BookIssueReportListWidget({super.key, required this.scrollController});

  @override
  State<BookIssueReportListWidget> createState() => _BookIssueReportListWidgetState();
}

class _BookIssueReportListWidgetState extends State<BookIssueReportListWidget> {
  TextEditingController idController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return CustomContainer(color: ResponsiveHelper.isDesktop(context)? Theme.of(context).cardColor : Colors.transparent,showShadow: false,
      child: GetBuilder<BookController>(
        initState: (val) => Get.find<BookController>().getBookIssueReport(1),
        builder: (bookController) {
          return Column(children: [
            if(ResponsiveHelper.isDesktop(context))...[

              Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
                  child: Row(spacing: Dimensions.paddingSizeSmall, children: [
                    Expanded(
                      child: Padding(padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: CustomDropdown(width: Get.width, title: "select".tr,
                          items: bookController.statusTypes,
                          selectedValue: bookController.selectedType,
                          onChanged: (val){
                            bookController.setSelectedStatusType(val!);
                          },
                        ),),
                    ),
                    Expanded(child: CustomTextField(hintText: "name".tr, controller: idController)),
                    SizedBox(width: 70,child: CustomButton(onTap: (){

                      bookController.getBookIssueReport(1, statusId : bookController.selectedTypeIndex.toString(), userId: idController.text.trim());
                    }, text: "search".tr)),
                  ])),

              const CustomDivider(),
              Row(spacing: Dimensions.paddingSizeSmall, children: [
                Expanded(child: Text('code'.tr, style: textRegular.copyWith(),)),
                Expanded(child: Text('name'.tr, maxLines: 1,overflow: TextOverflow.ellipsis, style: textRegular.copyWith(),)),
                Expanded(child: Text('type'.tr, style: textRegular.copyWith(),)),
                Expanded(child: Text('id'.tr, style: textRegular.copyWith(),)),
                Expanded(child: Text('name', style: textRegular.copyWith(),)),
                Expanded(child: Text('issue_date', style: textRegular.copyWith(),)),
                Expanded(child: Text('status', style: textRegular.copyWith(),)),


              ]), const CustomDivider(),
            ],

              GetBuilder<BookController>(
                  builder: (bookController) {
                    BookIssueReportModel? bookIssueReportModel = bookController.bookIssueReportModel;
                    var bookIssueReport = bookIssueReportModel?.data;
                    return  bookIssueReportModel != null? (bookIssueReport != null && bookIssueReport.issues != null && bookIssueReport.issues!.data!.isNotEmpty)?
                    PaginatedListWidget(scrollController: widget.scrollController,
                        onPaginate: (int? offset) async {
                          await bookController.getBookIssueReport(offset??1, statusId :bookController.selectedTypeIndex.toString(), userId: idController.text.trim());
                        }, totalSize: bookIssueReport.issues?.total??0,
                        offset: bookIssueReport.issues?.currentPage??0,
                        itemView: ListView.builder(
                            itemCount: bookIssueReport.issues?.data?.length??0,
                            padding: EdgeInsets.zero,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index){
                              return BookIssueReportResultItemWidget(issueItem: bookIssueReport.issues?.data?[index], index: index);
                            })) :
                    Padding(padding: EdgeInsets.symmetric(vertical: Get.height/2),
                      child: const Center(child: NoDataFound()),):

                    Padding(padding: ThemeShadow.getPadding(),
                        child: const Center(child: CircularProgressIndicator()));
                  }
              ),
            ],
          );
        }
      ),
    );
  }
}
