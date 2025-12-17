import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/custom_button.dart';
import 'package:mighty_school/common/widget/custom_contaner.dart';
import 'package:mighty_school/common/widget/custom_divider.dart';
import 'package:mighty_school/common/widget/custom_title.dart';
import 'package:mighty_school/common/widget/no_data_found.dart';
import 'package:mighty_school/feature/sms/phone_book_category/controller/phone_book_category_controller.dart';
import 'package:mighty_school/feature/sms/phone_book_category/presentation/screens/create_new_phone_book_category_screen.dart';
import 'package:mighty_school/feature/sms/phone_book_category/presentation/widgets/phone_book_category_item_widget.dart';
import 'package:mighty_school/helper/responsive_helper.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/styles.dart';

class PhoneBookCategoryListWidget extends StatefulWidget {
  final ScrollController scrollController;
  const PhoneBookCategoryListWidget({super.key, required this.scrollController});

  @override
  State<PhoneBookCategoryListWidget> createState() => _PhoneBookCategoryListWidgetState();
}

class _PhoneBookCategoryListWidgetState extends State<PhoneBookCategoryListWidget> {
  @override
  void initState() {
    Get.find<PhoneBookCategoryController>().getPhoneBookCategoryList();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return GetBuilder<PhoneBookCategoryController>(
        builder: (phoneBookCategoryController) {
          var phoneBook = phoneBookCategoryController.phoneBookCategoryModel?.data;
          return CustomContainer(color: ResponsiveHelper.isDesktop(context)? Theme.of(context).cardColor : Colors.transparent, showShadow: ResponsiveHelper.isDesktop(context),
            child: Column(spacing: Dimensions.paddingSizeExtraSmall, children: [
              if(ResponsiveHelper.isDesktop(context))...[

                CustomTitle(title: "phone_book_category_list", widget: SizedBox(width: 120, child: CustomButton(onTap: (){
                  Get.dialog(const CreateNewPhoneBookCategoryScreen());
                }, text: "add".tr)),),


                const CustomDivider(),
                Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall),
                  child: Row(spacing: Dimensions.paddingSizeSmall, children: [
                    Expanded(child: Text("name".tr, style: textRegular.copyWith(fontSize: Dimensions.fontSizeDefault))),
                    Text("action".tr,  style: textRegular.copyWith(fontSize: Dimensions.fontSizeDefault)),

                  ])),
                const CustomDivider(),
              ],


              phoneBookCategoryController.phoneBookCategoryModel != null? (phoneBookCategoryController.phoneBookCategoryModel!.data!= null && phoneBookCategoryController.phoneBookCategoryModel!.data!.isNotEmpty)?
              ListView.builder(
                  itemCount: phoneBook?.length??0,
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index){
                    return PhoneBookCategoryItemWidget(index: index, phoneBookCategoryItem: phoneBook?[index]);
                  }):
              Padding(padding: EdgeInsets.symmetric(vertical: Get.height/3),
                child: const Center(child: NoDataFound()),
              ):
              Padding(padding: EdgeInsets.symmetric(vertical: Get.height / 3), child: const CircularProgressIndicator()),
            ],),
          );
        }
    );
  }
}
