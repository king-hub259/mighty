import 'package:get/get.dart';
import 'package:mighty_school/api_handle/api_checker.dart';
import 'package:mighty_school/common/widget/custom_snackbar.dart';
import 'package:mighty_school/feature/academic_configuration/class/controller/class_controller.dart';
import 'package:mighty_school/feature/academic_configuration/section/domain/model/section_body.dart';
import 'package:mighty_school/feature/academic_configuration/section/domain/model/section_model.dart';
import 'package:mighty_school/feature/academic_configuration/section/domain/repository/section_repository.dart';

class SectionController extends GetxController implements GetxService{
  final SectionRepository sectionRepository;
  SectionController({required this.sectionRepository});

  SectionModel? sectionModel;
  SectionModel? sectionModelForMigration;
  Future<void> getSectionList(int page, {bool fromMigration = false}) async {
    Response? response = await sectionRepository.getSectionList(page, Get.find<ClassController>().selectedClassItem!.id! );
    if(response!.statusCode == 200){
      if(fromMigration){
        sectionModelForMigration = SectionModel.fromJson(response.body);
      }else{
      sectionModel = SectionModel.fromJson(response.body);
      }
    }else{
      ApiChecker.checkApi(response);
    }
    update();

  }


  Future<void> deleteSection(int id) async {
    Response? response = await sectionRepository.sectionDelete(id);
    if(response!.statusCode == 200){
      showCustomSnackBar("deleted_successfully".tr);
      getSectionList(1);
    }else{
      ApiChecker.checkApi(response);
    }
    update();

  }
  bool isLoading = false;

  Future<void> addNewSection(SectionBody sectionBody) async {
    isLoading = true;
    update();
    Response? response = await sectionRepository.addNewSection(sectionBody);
    if(response!.statusCode == 200){
      isLoading = false;
      Get.back();
      showCustomSnackBar("added_successfully".tr, isError: false);
      getSectionList(1);
    }else{
      isLoading = false;
      ApiChecker.checkApi(response);
    }
    update();
  }

  Future<void> updateSection(SectionBody sectionBody, int id) async {
    isLoading = true;
    update();
    Response? response = await sectionRepository.sectionEdit(sectionBody, id);
    if(response!.statusCode == 200){
      isLoading = false;
      showCustomSnackBar("updated_successfully".tr);
      getSectionList(1);
    }else{
      isLoading = false;
      ApiChecker.checkApi(response);
    }
    update();
  }

  initSelection({bool isMigration = false}){
    if(isMigration){
      selectedSectionItemForMigration = null;
    }else{
      selectedSectionItem = null;
    }

  }

  SectionItem? selectedSectionItem;
  SectionItem? selectedSectionItemForMigration;

  void setSelectSectionItem(SectionItem? sectionItem, {bool isMigration = false}){
    if(isMigration) {
      selectedSectionItemForMigration = sectionItem;
    }
    else{
      selectedSectionItem = sectionItem;
    }
    update();
  }

}