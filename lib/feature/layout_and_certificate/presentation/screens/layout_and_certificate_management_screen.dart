import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:mighty_school/common/widget/custom_app_bar.dart';
import 'package:mighty_school/common/widget/sub_menu_item_widget.dart';
import 'package:mighty_school/feature/id_card/presentation/screens/id_card_screen.dart';
import 'package:mighty_school/feature/menu_section/controller/menu_type_controller.dart';
import 'package:mighty_school/feature/layout_and_certificate/enum/certificate_type_enum.dart';
import 'package:mighty_school/feature/layout_and_certificate/presentation/screens/layout_and_certificate_screen.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/images.dart';

class LayoutAndCertificateManagementScreen extends StatefulWidget {
  const LayoutAndCertificateManagementScreen({super.key});

  @override
  State<LayoutAndCertificateManagementScreen> createState() => _LayoutAndCertificateManagementScreenState();
}

class _LayoutAndCertificateManagementScreenState extends State<LayoutAndCertificateManagementScreen> {
  List<MainMenuModel> certificateItems = [
    MainMenuModel(
      icon: Images.certificate,
      title: 'recommendation_letter',
      widget: const LayoutAndCertificateScreen(type: CertificateTypeEnum.recommendation)
    ),
    MainMenuModel(
      icon: Images.certificate, 
      title: 'testimonial', 
      widget: const LayoutAndCertificateScreen(type: CertificateTypeEnum.testimonial)
    ),
    MainMenuModel(
      icon: Images.certificate, 
      title: 'attendance_certificate', 
      widget: const LayoutAndCertificateScreen(type: CertificateTypeEnum.attendanceCertificate)
    ),
    MainMenuModel(
      icon: Images.certificate, 
      title: 'hsc_recommendation_letter', 
      widget: const LayoutAndCertificateScreen(type: CertificateTypeEnum.hscRecommendationLetter)
    ),
    MainMenuModel(
      icon: Images.certificate,
      title: 'abroad_letter',
      widget: const LayoutAndCertificateScreen(type: CertificateTypeEnum.abroadLetter)
    ),
    MainMenuModel(
      icon: Images.certificate,
      title: 'transfer_certificate',
      widget: const LayoutAndCertificateScreen(type: CertificateTypeEnum.transferCertificate)
    ),
    MainMenuModel(
      icon: Images.certificate,
      title: 'character_certificate',
      widget: const LayoutAndCertificateScreen(type: CertificateTypeEnum.characterCertificate)
    ),
    MainMenuModel(
      icon: Images.certificate,
      title: 'study_certificate',
      widget: const LayoutAndCertificateScreen(type: CertificateTypeEnum.studyCertificate)
    ),
    MainMenuModel(
      icon: Images.certificate,
      title: 'bonafide_certificate',
      widget: const LayoutAndCertificateScreen(type: CertificateTypeEnum.bonafideCertificate)
    ),
    MainMenuModel(
      icon: Images.certificate,
      title: 'migration_certificate',
      widget: const LayoutAndCertificateScreen(type: CertificateTypeEnum.migrationCertificate)
    ),
    MainMenuModel(
      icon: Images.certificate,
      title: 'id_card',
      widget: const IdCardScreen()
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppBar(title: "layout_and_certificate".tr,),
        body: CustomWebScrollView(slivers: [
          SliverToBoxAdapter(child:Padding(padding: const EdgeInsets.only(top: Dimensions.paddingSizeDefault),
            child: ListView.builder(
                itemCount: certificateItems.length,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                itemBuilder: (context, index){
                  return InkWell(onTap: ()=> Get.to(certificateItems[index].widget),
                      child: SubMenuItemWidget(icon: certificateItems[index].icon, title: certificateItems[index].title)
                  );
                }),
          ),)
        ],)
    );
  }
}
