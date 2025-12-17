import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/custom_contaner.dart';
import 'package:mighty_school/common/widget/edit_delete_section.dart';
import 'package:mighty_school/feature/sms/phone_book/controller/phone_book_controller.dart';
import 'package:mighty_school/feature/sms/phone_book/domain/models/phone_book_model.dart';
import 'package:mighty_school/feature/sms/phone_book/presentation/screens/create_new_phone_book_screen.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/styles.dart';

class PhoneBookItemWidget extends StatelessWidget {
  final PhoneBookItem? phoneBookItem;
  final int index;
  const PhoneBookItemWidget({super.key, this.phoneBookItem, required this.index});

  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault, vertical: Dimensions.paddingSizeSeven),
      child: CustomContainer(borderRadius: Dimensions.paddingSizeExtraSmall, child: Row(children: [
          Expanded(child: Text("${phoneBookItem?.name}", style: textMedium.copyWith(fontSize: Dimensions.fontSizeDefault))),
          EditDeleteSection(horizontal: true, onEdit: (){
            Get.dialog(CreateNewPhoneBookScreen(phoneBookItem: phoneBookItem));
          },
            onDelete: (){
            Get.find<PhoneBookController>().deletePhoneBook(phoneBookItem!.id!);
          },)
        ],
      )),
    );
  }
}