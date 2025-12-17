import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/custom_button.dart';
import 'package:mighty_school/common/widget/custom_contaner.dart';
import 'package:mighty_school/common/widget/custom_title.dart';
import 'package:mighty_school/common/widget/no_data_found.dart';
import 'package:mighty_school/feature/sms/phone_book/controller/phone_book_controller.dart';
import 'package:mighty_school/feature/sms/phone_book/presentation/screens/create_new_phone_book_screen.dart';
import 'package:mighty_school/feature/sms/phone_book/presentation/widgets/phone_book_item_widget.dart';
import 'package:mighty_school/helper/responsive_helper.dart';

class PhoneBookListWidget extends StatefulWidget {
  final ScrollController scrollController;
  const PhoneBookListWidget({super.key, required this.scrollController});

  @override
  State<PhoneBookListWidget> createState() => _PhoneBookListWidgetState();
}

class _PhoneBookListWidgetState extends State<PhoneBookListWidget> {
  @override
  void initState() {
    Get.find<PhoneBookController>().getPhoneBookList();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return GetBuilder<PhoneBookController>(
        builder: (phoneBookController) {
          var phoneBook = phoneBookController.phoneBookModel?.data;
          return CustomContainer(color: ResponsiveHelper.isDesktop(context)? Theme.of(context).cardColor : Theme.of(context).scaffoldBackgroundColor,
            child: Column(children: [
              if(ResponsiveHelper.isDesktop(context))
                CustomTitle(title: "phone_book_list", widget: SizedBox(width: 120, child: CustomButton(onTap: (){
                  Get.dialog(const CreateNewPhoneBookScreen());
                }, text: "add".tr)),),

              phoneBookController.phoneBookModel != null? (phoneBookController.phoneBookModel!.data!= null && phoneBookController.phoneBookModel!.data!.isNotEmpty)?
              ListView.builder(
                  itemCount: phoneBook?.length??0,
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index){
                    return PhoneBookItemWidget(index: index, phoneBookItem: phoneBook?[index]);
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
