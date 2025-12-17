import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/custom_button.dart';
import 'package:mighty_school/common/widget/custom_snackbar.dart';
import 'package:mighty_school/common/widget/custom_text_field.dart';
import 'package:mighty_school/common/widget/custom_title.dart';
import 'package:mighty_school/feature/academic_configuration/session/controller/session_controller.dart';
import 'package:mighty_school/feature/academic_configuration/session/domain/models/session_model.dart';
import 'package:mighty_school/util/dimensions.dart';

class CreateNewSessionWidget extends StatefulWidget {
  final SessionItem? sessionItem;
  const CreateNewSessionWidget({super.key, this.sessionItem});

  @override
  State<CreateNewSessionWidget> createState() => _CreateNewSessionWidgetState();
}

class _CreateNewSessionWidgetState extends State<CreateNewSessionWidget> {
  TextEditingController sessionTitleController = TextEditingController();
  TextEditingController sessionYearController = TextEditingController();
  bool update = false;
  @override
  void initState() {
    if(widget.sessionItem != null){
      update = true;
      sessionTitleController.text = widget.sessionItem?.session??'';
      sessionYearController.text = widget.sessionItem?.year??'';
    }
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SessionController>(
        builder: (sessionController) {
          return Padding(
            padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              const Padding(padding: EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault),
                  child: CustomTitle(title: "add_new_session")),

              CustomTextField(title: "session".tr,
                controller: sessionTitleController,
                hintText: "2021".tr,),

              CustomTextField(title: "year".tr,
                controller: sessionYearController,
                hintText: "2020-2021".tr,),


              sessionController.isLoading? const Padding(padding: EdgeInsets.all(Dimensions.paddingSizeDefault),
                  child: Center(child: CircularProgressIndicator())):

              Padding(padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault),
                  child: CustomButton(onTap: (){

                    String session = sessionTitleController.text.trim();
                    String year = sessionYearController.text.trim();
                    if(session.isEmpty){
                      showCustomSnackBar("session_is_empty".tr);
                    }
                    else if(year.isEmpty){
                      showCustomSnackBar("year_is_empty".tr);
                    }
                    else{
                      if(update){
                        sessionController.updateSession(session, year, widget.sessionItem!.id!);
                      }else{
                        sessionController.createNewSession(session, year);
                      }

                    }
                  }, text: "confirm".tr))
            ],),
          );
        }
    );
  }
}
