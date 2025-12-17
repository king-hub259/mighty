import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/feature/landing_page/domain/models/panel_model.dart';
import 'package:mighty_school/feature/landing_page/domain/models/saas_faq_model.dart';
import 'package:mighty_school/feature/landing_page/domain/repositories/landing_page_repository.dart';
import 'package:mighty_school/feature/package_plan/domain/models/package_model.dart';

class LandingPageController extends GetxController implements GetxService {
  final LandingPageRepository landingPageRepository;
  LandingPageController({required this.landingPageRepository});
  List<String> menuList = ["home", "modules", "services", "pricing", "features", "faq", "contact_us"];


  List<String> panelTypes = ["panels", "mobile_apps"];
  int selectedPanelTypeIndex = 0;
  void setSelectedPanelTypeIndex(int index) {
    selectedPanelTypeIndex = index;
    update();
  }

  List<PanelModel> cardData = [
    PanelModel(
      title: "Super Admin Panel",
      subtitle: "Manage the entire school system, control user roles, and monitor school activities.",
      cardColor: Theme.of(Get.context!).highlightColor,
    ),
    PanelModel(
      title: "Admin Panel",
      subtitle: "Oversee daily operations, manage staff, students, classes, and finances.",
      cardColor: Theme.of(Get.context!).highlightColor,
    ),
    PanelModel(
      title: "Teacher Panel",
      subtitle: "View class schedules, mark attendance, assign grades, and communicate with students.",
      cardColor: Theme.of(Get.context!).highlightColor,
    ),
    PanelModel(
      title: "Staff Panel",
      subtitle: "Manage administrative tasks, student records, and operational workflows.",
      cardColor: Theme.of(Get.context!).highlightColor,
    ),
  ];

  PackageModel? packageModel;
  Future<void> getSubscriptionPlanList() async {
    Response response = await landingPageRepository.getSubscriptionPackageList();
    if (response.statusCode == 200) {
      packageModel = PackageModel.fromJson(response.body);
    }
    update();
  }

  PackageItem? selectedPackageItem;
  int selectedPackageIndex = 1;
  void setSelectedPackageItem(PackageItem item, int index) {
    selectedPackageItem = item;
    selectedPackageIndex = index;
    update();
  }

  SaasFaqModel? saasFaqModel;
  Future<void> getSaasFaqData() async {
    Response response = await landingPageRepository.getSaasFaqData();
    if (response.statusCode == 200) {
      saasFaqModel = SaasFaqModel.fromJson(response.body);
    }
    update();
  }




}
