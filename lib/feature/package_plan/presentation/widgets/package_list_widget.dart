import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/custom_button.dart';
import 'package:mighty_school/common/widget/custom_contaner.dart';
import 'package:mighty_school/common/widget/custom_divider.dart';
import 'package:mighty_school/common/widget/custom_title.dart';
import 'package:mighty_school/common/widget/no_data_found.dart';
import 'package:mighty_school/common/widget/paginated_list_widget.dart';
import 'package:mighty_school/feature/package_plan/controller/package_controller.dart';
import 'package:mighty_school/feature/package_plan/domain/models/package_model.dart';
import 'package:mighty_school/feature/package_plan/presentation/screens/create_new_package_screen.dart';
import 'package:mighty_school/feature/package_plan/presentation/widgets/package_item_widget.dart';
import 'package:mighty_school/helper/responsive_helper.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/styles.dart';

class PackageListWidget extends StatefulWidget {
  final ScrollController scrollController;
  const PackageListWidget({super.key, required this.scrollController});

  @override
  State<PackageListWidget> createState() => _PackageListWidgetState();
}

class _PackageListWidgetState extends State<PackageListWidget> {
  @override
  void initState() {
    Get.find<PackageController>().getPackageList(1);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return GetBuilder<PackageController>(
        builder: (packageController) {
          PackageModel? packageModel = packageController.packageModel;
          var package = packageModel?.data;
          return Padding(padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
            child: CustomContainer(
              child: Column(children: [
                if(ResponsiveHelper.isDesktop(context))...[
                  CustomTitle(title: "package_list", widget: SizedBox(width: 120, child: CustomButton(onTap: (){
                    Get.dialog(const CreateNewPackageScreen());
                  }, text: "add".tr)),),
                  const SizedBox(height: Dimensions.paddingSizeSmall),

                  Row(children: [
                    Expanded(child: Text("name".tr, style: textMedium.copyWith(fontSize: Dimensions.fontSizeDefault))),
                    Expanded(child: Text("description".tr, style: textMedium.copyWith(fontSize: Dimensions.fontSizeDefault))),
                    Expanded(child: Text("price".tr, style: textMedium.copyWith(fontSize: Dimensions.fontSizeDefault))),
                    Expanded(child: Text("duration".tr, style: textMedium.copyWith(fontSize: Dimensions.fontSizeDefault))),
                    SizedBox(width: 70,child: Text("action".tr, style: textMedium.copyWith(fontSize: Dimensions.fontSizeDefault))),

                  ],),
                  const CustomDivider()
                ],


                packageModel != null? (packageModel.data!= null && packageModel.data!.data!.isNotEmpty)?
                PaginatedListWidget(scrollController: widget.scrollController,
                    onPaginate: (int? offset) async{
                      packageController.getPackageList(offset??1);
                    }, totalSize: package?.total??0,
                    offset: package?.currentPage??0,
                    itemView: ListView.builder(
                        itemCount: package?.data?.length??0,
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index){
                          return PackageItemWidget(index: index,
                            packageItem: package?.data?[index],);
                        })):
                Padding(padding: ThemeShadow.getPadding(),
                  child: const Center(child: NoDataFound())):
                Padding(padding: ThemeShadow.getPadding(), child: const CircularProgressIndicator()),
              ],),
            ),
          );
        }
    );
  }
}
