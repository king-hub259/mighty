import 'package:get/get.dart';
import 'package:mighty_school/api_handle/api_checker.dart';
import 'package:mighty_school/feature/layout_and_certificate/domain/models/layout_and_certificate_model.dart';
import 'package:mighty_school/feature/layout_and_certificate/domain/repository/layout_and_certificate_repository.dart';
import 'package:mighty_school/feature/layout_and_certificate/presentation/widgets/recommandation_letter_pdf_widget.dart';
import 'package:mighty_school/feature/layout_and_certificate/presentation/widgets/testimonial_pdf_widget.dart';
import 'package:mighty_school/feature/layout_and_certificate/presentation/widgets/attendance_certificate_pdf_widget.dart';
import 'package:mighty_school/feature/layout_and_certificate/presentation/widgets/hsc_recommendation_letter_pdf_widget.dart';
import 'package:mighty_school/feature/layout_and_certificate/presentation/widgets/abroad_letter_pdf_widget.dart';
import 'package:mighty_school/feature/layout_and_certificate/presentation/widgets/transfer_certificate_pdf_widget.dart';
import 'package:mighty_school/feature/layout_and_certificate/presentation/widgets/character_certificate_pdf_widget.dart';
import 'package:mighty_school/feature/layout_and_certificate/presentation/widgets/study_certificate_pdf_widget.dart';
import 'package:mighty_school/feature/layout_and_certificate/presentation/widgets/bonafide_certificate_pdf_widget.dart';
import 'package:mighty_school/feature/layout_and_certificate/presentation/widgets/migration_certificate_pdf_widget.dart';

class LayoutAndCertificateController extends GetxController implements GetxService{
  final LayoutAndCertificateRepository layoutAndCertificateRepository;
  LayoutAndCertificateController({required this.layoutAndCertificateRepository});

  bool isLoading = false;
  LayoutAndCertificateModel? layoutAndCertificateModel;
  Future<void> getLayoutAndCertificate(String type, int classId, int sectionId, String roll) async {
    Response? response = await layoutAndCertificateRepository.getLayoutAndCertificate("general-certificate", classId, sectionId, roll);
    if (response.statusCode == 200) {
      // Get.find<SystemSettingsController>().getGeneralSetting();
      layoutAndCertificateModel = LayoutAndCertificateModel.fromJson(response.body);
      if (layoutAndCertificateModel != null) {
        if(type == "testimonial"){
          Get.to(()=> const TestimonialPdfPreviewPage());
        }
        else if(type == "general-certificate"){
          Get.to(()=> const RecommendationLetterPdfPreviewPage());
        }
        else if(type == "attendance-certificate"){
          Get.to(()=> const AttendanceCertificatePdfPreviewPage());
        }
        else if(type == "hsc-recommendation-letter"){
          Get.to(()=> const HscRecommendationLetterPdfPreviewPage());
        }
        else if(type == "abroad-letter"){
          Get.to(()=> const AbroadLetterPdfPreviewPage());
        }
        else if(type == "transfer-certificate"){
          Get.to(()=> const TransferCertificatePdfPreviewPage());
        }
        else if(type == "character-certificate"){
          Get.to(()=> const CharacterCertificatePdfPreviewPage());
        }
        else if(type == "study-certificate"){
          Get.to(()=> const StudyCertificatePdfPreviewPage());
        }
        else if(type == "bonafide-certificate"){
          Get.to(()=> const BonafideCertificatePdfPreviewPage());
        }
        else if(type == "migration-certificate"){
          Get.to(()=> const MigrationCertificatePdfPreviewPage());
        }
        else if(type == "bonafide-certificate"){
          Get.to(()=> const BonafideCertificatePdfPreviewPage());
        }
      }
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }
}