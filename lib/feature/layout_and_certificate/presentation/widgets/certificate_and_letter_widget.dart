import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/custom_button.dart';
import 'package:mighty_school/common/widget/custom_contaner.dart';
import 'package:mighty_school/common/widget/custom_snackbar.dart';
import 'package:mighty_school/common/widget/custom_text_field.dart';
import 'package:mighty_school/common/widget/custom_title.dart';
import 'package:mighty_school/feature/academic_configuration/class/controller/class_controller.dart';
import 'package:mighty_school/feature/academic_configuration/class/presentation/widgets/select_class_widget.dart';
import 'package:mighty_school/feature/academic_configuration/section/controller/section_controller.dart';
import 'package:mighty_school/feature/academic_configuration/section/presentation/widgets/select_section_widget.dart';
import 'package:mighty_school/feature/layout_and_certificate/enum/certificate_type_enum.dart';
import 'package:mighty_school/feature/layout_and_certificate/logic/layout_and_certificate_controller.dart';
import 'package:mighty_school/helper/responsive_helper.dart';
import 'package:mighty_school/util/dimensions.dart';

class GeneralRecommendationLetter extends StatefulWidget {
  final CertificateTypeEnum type;
  const GeneralRecommendationLetter({super.key, required this.type});

  @override
  State<GeneralRecommendationLetter> createState() => _GeneralRecommendationLetterState();
}

class _GeneralRecommendationLetterState extends State<GeneralRecommendationLetter> {

  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LayoutAndCertificateController>(
      builder: (layoutAndCertificateController) {
        String title = _getCertificateTitle(widget.type);
        return Column(children: [
          Padding(padding: const EdgeInsets.only(top: Dimensions.paddingSizeDefault),
            child: CustomTitle(title: title, webTitle: ResponsiveHelper.isDesktop(context),),),

          Padding(padding: const EdgeInsets.symmetric(horizontal : Dimensions.paddingSizeDefault),
            child: CustomContainer(showShadow: false, borderRadius: 5,
                child: Row(spacing: Dimensions.paddingSizeDefault,crossAxisAlignment: CrossAxisAlignment.end, children: [
                  const Expanded(child: SelectClassWidget()),
                    const Expanded(child: SelectSectionWidget()),
                    Expanded(child: Padding(
                      padding: const EdgeInsets.only(bottom: 10.0),
                      child: CustomTextField(controller : searchController, title: "student_roll".tr, hintText: "enter_roll_number".tr,),
                    )),
                    SizedBox(width: 120,child: Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: CustomButton(onTap: (){
                        String roll = searchController.text.trim();
                        int? classId = Get.find<ClassController>().selectedClassItem?.id;
                        int? sectionId = Get.find<SectionController>().selectedSectionItem?.id;
                        if(roll.isEmpty){
                          showCustomSnackBar("roll_number_is_empty".tr);
                        }
                        else if(classId == null){
                          showCustomSnackBar("class_is_empty".tr);
                        }
                        else if(sectionId == null){
                          showCustomSnackBar("section_is_empty".tr);
                        }
                        else{
                          if(widget.type == CertificateTypeEnum.recommendation){
                            layoutAndCertificateController.getLayoutAndCertificate("general-certificate",classId, sectionId, roll);
                          }
                          else if(widget.type == CertificateTypeEnum.testimonial){
                            layoutAndCertificateController.getLayoutAndCertificate("testimonial",classId, sectionId, roll);
                          }
                          else if(widget.type == CertificateTypeEnum.attendanceCertificate){
                            layoutAndCertificateController.getLayoutAndCertificate("attendance-certificate",classId, sectionId, roll);
                          }
                          else if(widget.type == CertificateTypeEnum.hscRecommendationLetter){
                            layoutAndCertificateController.getLayoutAndCertificate("hsc-recommendation-letter",classId, sectionId, roll);
                          }
                          else if(widget.type == CertificateTypeEnum.abroadLetter){
                            layoutAndCertificateController.getLayoutAndCertificate("abroad-letter",classId, sectionId, roll);
                          }
                          else if(widget.type == CertificateTypeEnum.transferCertificate){
                            layoutAndCertificateController.getLayoutAndCertificate("transfer-certificate",classId, sectionId, roll);
                          }
                          else if(widget.type == CertificateTypeEnum.characterCertificate){
                            layoutAndCertificateController.getLayoutAndCertificate("character-certificate",classId, sectionId, roll);
                          }
                          else if(widget.type == CertificateTypeEnum.idCard){
                            layoutAndCertificateController.getLayoutAndCertificate("id-card",classId, sectionId, roll);
                          }
                          else if(widget.type == CertificateTypeEnum.studyCertificate){
                            layoutAndCertificateController.getLayoutAndCertificate("study-certificate",classId, sectionId, roll);
                          }
                          else if(widget.type == CertificateTypeEnum.bonafideCertificate){
                            layoutAndCertificateController.getLayoutAndCertificate("bonafide-certificate",classId, sectionId, roll);
                          }
                          else if(widget.type == CertificateTypeEnum.migrationCertificate){
                            layoutAndCertificateController.getLayoutAndCertificate("migration-certificate",classId, sectionId, roll);
                          }
                         // layoutAndCertificateController.getLayoutAndCertificate("general-certificate",classId, sectionId, roll);
                        }

                      }, text: "search".tr),
                    ),)
            ])),
          ),

          const SizedBox(height: Dimensions.paddingSizeDefault),

        ]);
      }
    );
  }

  String _getCertificateTitle(CertificateTypeEnum type) {
    switch (type) {
      case CertificateTypeEnum.recommendation:
        return "recommendation_letter".tr;
      case CertificateTypeEnum.testimonial:
        return "testimonial".tr;
      case CertificateTypeEnum.attendanceCertificate:
        return "attendance_certificate".tr;
      case CertificateTypeEnum.hscRecommendationLetter:
        return "hsc_recommendation_letter".tr;
      case CertificateTypeEnum.abroadLetter:
        return "abroad_letter".tr;
      case CertificateTypeEnum.transferCertificate:
        return "transfer_certificate".tr;
      case CertificateTypeEnum.characterCertificate:
        return "character_certificate".tr;
      case CertificateTypeEnum.studyCertificate:
        return "study_certificate".tr;
      case CertificateTypeEnum.bonafideCertificate:
        return "bonafide_certificate".tr;
      case CertificateTypeEnum.migrationCertificate:
        return "migration_certificate".tr;
      case CertificateTypeEnum.idCard:
        return "id_card".tr;
    }
  }
}
