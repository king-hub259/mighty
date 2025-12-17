import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/custom_button.dart';
import 'package:mighty_school/common/widget/custom_contaner.dart';
import 'package:mighty_school/common/widget/custom_snackbar.dart';
import 'package:mighty_school/common/widget/custom_text_field.dart';
import 'package:mighty_school/common/widget/custom_title.dart';
import 'package:mighty_school/feature/administrator/notice/controller/notice_controller.dart';
import 'package:mighty_school/feature/administrator/notice/domain/models/notice_body.dart';
import 'package:mighty_school/feature/administrator/notice/domain/models/notice_model.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/styles.dart';

class CreateNewNoticeScreen extends StatefulWidget {
  final NoticeItem? noticeItem;
  const CreateNewNoticeScreen({super.key, this.noticeItem});

  @override
  State<CreateNewNoticeScreen> createState() => _CreateNewNoticeScreenState();
}

class _CreateNewNoticeScreenState extends State<CreateNewNoticeScreen> {
  TextEditingController noticeTitleController = TextEditingController();
  TextEditingController noticeDetailsController = TextEditingController();
   bool update = false;
  @override
  void initState() {
    if(widget.noticeItem != null){
      update = true;
      noticeTitleController.text = widget.noticeItem?.title??'';
      noticeDetailsController.text = widget.noticeItem?.notice??'';
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall)),
      child: Padding(
        padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
        child: GetBuilder<NoticeController>(
          builder: (noticeController) {
            return Column(mainAxisSize: MainAxisSize.min, children: [
              const Padding(padding: EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault),
                child: CustomTitle(title: "add_new_notice")),

              CustomTextField(title: "title".tr,
                controller: noticeTitleController,
                hintText: "title".tr,),

              CustomTextField(title: "description".tr,
                controller: noticeDetailsController,
                hintText: "description".tr,),


              SizedBox(height: 50,
                child: ListView.builder(
                  itemCount: noticeController.noticeTypes.length,
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index){
                    String type = noticeController.noticeTypes[index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CustomContainer(borderRadius: 5, verticalPadding: 0,horizontalPadding: 5,
                          child: InkWell(onTap: ()=> noticeController.toggleType(type),
                            child: Row(children: [
                              Icon(size: 20,
                                  noticeController.selectedTypes.contains(type)? Icons.check_circle : Icons.radio_button_off),
                            const SizedBox(width: Dimensions.paddingSizeSmall),
                              Text(type, style: textRegular.copyWith(),)
                            ]),
                          ),
                        ),
                      );
                    }),
              ),


              noticeController.isLoading? const Padding(padding: EdgeInsets.all(Dimensions.paddingSizeDefault),
                child: Center(child: CircularProgressIndicator())):

              Padding(padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault),
                child: CustomButton(onTap: (){

                  String title = noticeTitleController.text.trim();
                  String details = noticeDetailsController.text.trim();
                  if(title.isEmpty){
                    showCustomSnackBar("title_is_empty".tr);
                  }
                  else if(details.isEmpty){
                    showCustomSnackBar("details_is_empty".tr);
                  }
                  else if(noticeController.selectedTypes.isEmpty){
                    showCustomSnackBar("select_notice_type".tr);
                  }
                  else{
                    NoticeBody noticeBody = NoticeBody(
                      title: title,
                      notice: details,
                      userType: noticeController.selectedTypes
                    );
                    if(update){
                      noticeController.updateNotice(noticeBody, widget.noticeItem!.id!);
                    }else{
                      noticeController.createNewNotice(noticeBody);
                    }

                  }
                }, text: "confirm".tr))
            ],);
          }
        ),
      ),
    );
  }
}
