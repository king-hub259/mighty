
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/api_handle/api_checker.dart';
import 'package:mighty_school/common/widget/confirmation_dialog.dart';
import 'package:mighty_school/common/widget/custom_snackbar.dart';
import 'package:mighty_school/common/widget/menu_image.dart';
import 'package:mighty_school/feature/home/domain/model/config_model.dart';
import 'package:mighty_school/feature/home/domain/repository/home_repository.dart';
import 'package:mighty_school/feature/home/widget/data_sync.dart';
import 'package:mighty_school/feature/layout_and_certificate/enum/certificate_type_enum.dart';
import 'package:mighty_school/feature/profile/logic/profile_controller.dart';
import 'package:mighty_school/helper/route_helper.dart';
import 'package:mighty_school/util/images.dart';
import 'package:mighty_school/common/widget/side_menu/easy_sidemenu.dart';

class SideMenuBarController extends GetxController implements GetxService{
  final HomeRepository homeRepository;
  final ProfileController profileController = Get.find<ProfileController>();
  SideMenuBarController({required this.homeRepository});


  bool isExpanded = true;
  void toggleSideMenu(bool exp) {
    isExpanded = exp;
    update();
  }

  bool isLoading = false;
  ConfigModel? configModel;
  Future<void> getConfigInfo() async {
    isLoading = true;
    Response? response = await homeRepository.configApi();
    if (response?.statusCode == 200) {
        configModel = ConfigModel.fromJson(response?.body);
      isLoading = false;
    }else{
      isLoading = false;
      ApiChecker.checkApi(response!);
    }
    update();
  }

  bool _onOff = false;
  bool get onOff => _onOff;
  void changeAnnouncementOnOff(){
    _onOff = !_onOff;
    update();
  }
  @override
  void onInit() {
    sideMenuItems = _buildInitSideMenuItems();
    super.onInit();
  }

  void updateSideMenuItems() {
    sideMenuItems = _buildSideMenuItems();
    update();
  }


  void updateParentSideMenuItems() {
    sideMenuItems = _buildParentSideMenuItems();
    update();
  }
  void updateStudentSideMenuItems() {
    sideMenuItems = _buildStudentSideMenuItems();
    update();
  }

  void updateSaasSideMenuItems() {
    sideMenuItems = _buildSaasSideMenuItems();
    update();
  }

  SideMenuController sideMenu = SideMenuController();



   List<dynamic> sideMenuItems = [];
  List<dynamic> _buildSideMenuItems() {
    return  [
    if(profileController.hasPermission("dashboard"))
    SideMenuItem(title: 'dashboard'.tr, iconWidget: const  MenuImage(icon : Images.homeActive),
        onTap: (index, _) {
          sideMenu.changePage(index);
          Get.toNamed(RouteHelper.getDashboardRoute());
        }),



   if(profileController.hasPermission("master_configuration.branches"))
    SideMenuItem(title: 'branch'.tr, iconWidget: const  MenuImage(icon : Images.branch),
        onTap: (index, _) {
          sideMenu.changePage(index);
          Get.toNamed(RouteHelper.getBranchRoute());
        }),



    if(profileController.hasPermission("student_information.student_index") || profileController.hasPermission("student_information.student_migration") || profileController.hasPermission("student_information.student_pullback") || profileController.hasPermission("student_information.migration_list") || profileController.hasPermission("student_information.all_student_list"))
    SideMenuExpansionItem(title: "student_information".tr, iconWidget: const MenuImage(icon : Images.studentInfo), children: [

      if(profileController.hasPermission("student_information.student_index"))
        SideMenuItem(title: 'student_list'.tr,iconWidget: const SubMenuImage(),
          onTap: (index, _)  {
            sideMenu.changePage(index);
          Get.toNamed(RouteHelper.getStudentListRoute());
          },),

      if(profileController.hasPermission("student_information.student_migration"))
        SideMenuItem(title: 'student_migration'.tr,iconWidget: const SubMenuImage(),
          onTap: (index, _) {
            sideMenu.changePage(index);
            Get.toNamed(RouteHelper.getStudentMigrationRoute());
          }),

      if(profileController.hasPermission("student_information.student_pullback"))
      SideMenuItem(title: 'migration_pushback'.tr,iconWidget: const SubMenuImage(),
          onTap: (index, _) {
            sideMenu.changePage(index);
          Get.toNamed(RouteHelper.getMigrationPushbackRoute());
          }),

      if(profileController.hasPermission("student_information.migration_list"))
      SideMenuItem(title: 'migration_list'.tr,iconWidget: const SubMenuImage(),
          onTap: (index, _) {
            sideMenu.changePage(index);
          Get.toNamed(RouteHelper.getMigrationListRoute());
          }),

      if(profileController.hasPermission("student_information.all_student_list"))
      SideMenuItem(title: 'all_student_view_list'.tr,iconWidget: const SubMenuImage(),
          onTap: (index, _) {
            sideMenu.changePage(index);
          Get.toNamed(RouteHelper.getAllStudentViewListRoute());
          }),

      ]),


    if(profileController.hasPermission("staff_information.staff_index") || profileController.hasPermission("staff_information.staff_attendance_create") || profileController.hasPermission("staff_information.teachers_index") || profileController.hasPermission("staff_information.staffs_index"))
    SideMenuExpansionItem(title: "staff_information".tr, iconWidget: const MenuImage(icon : Images.staffInformation), children: [


      if(profileController.hasPermission("staff_information.staff_attendance_create"))
        SideMenuItem(title: 'staff_attendance'.tr,iconWidget: const SubMenuImage(),
          onTap: (index, _) {
            sideMenu.changePage(index);
          Get.toNamed(RouteHelper.getStaffAttendanceRoute());
          },),

      if(profileController.hasPermission("staff_information.teachers_index"))
        SideMenuItem(title: 'teacher_list'.tr,iconWidget: const SubMenuImage(),
          onTap: (index, _) {
            sideMenu.changePage(index);
          Get.toNamed(RouteHelper.getTeacherListRoute());
          }),

      if(profileController.hasPermission("staff_information.staffs_index"))
      SideMenuItem(title: 'staff_list'.tr,iconWidget: const SubMenuImage(),
          onTap: (index, _) {
            sideMenu.changePage(index);
          Get.toNamed(RouteHelper.getStaffListRoute());
          }),
      ]),




    if(profileController.hasPermission("student_attendance.student_attendance_index") || profileController.hasPermission("student_attendance.exam_attendance_schedule") || profileController.hasPermission("student_attendance.exam_attendance_index") || profileController.hasPermission("student_attendance.student_attendance_report") || profileController.hasPermission("student_attendance.student_absent_report"))
    SideMenuExpansionItem(title: "student_attendance".tr, iconWidget: const MenuImage(icon : Images.studentInfo), children: [


      if(profileController.hasPermission("student_attendance.student_attendance_create"))
        SideMenuItem(title: 'student_attendance'.tr,iconWidget: const SubMenuImage(),
          onTap: (index, _) {
            sideMenu.changePage(index);
          Get.toNamed(RouteHelper.getStudentAttendanceRoute());
          },),


      if(profileController.hasPermission("student_attendance.exam_attendance_index"))
        SideMenuItem(title: 'exam_attendance'.tr,iconWidget: const SubMenuImage(),
          onTap: (index, _) {
            sideMenu.changePage(index);
          Get.toNamed(RouteHelper.getExamAttendanceRoute());
          }),

      if(profileController.hasPermission("student_attendance.exam_attendance_schedule"))
      SideMenuItem(title: 'exam_schedule'.tr,iconWidget: const SubMenuImage(),
          onTap: (index, _) {
            sideMenu.changePage(index);
         Get.toNamed(RouteHelper.getExamScheduleRoute());
          }),

      if(profileController.hasPermission("student_attendance.student_attendance_report"))
      SideMenuItem(title: 'attendance_report'.tr,iconWidget: const SubMenuImage(),
          onTap: (index, _) {
            sideMenu.changePage(index);
         Get.toNamed(RouteHelper.getAttendanceReportRoute());
          }),

      if(profileController.hasPermission("student_attendance.student_absent_report"))
      SideMenuItem(title: 'absent_fine'.tr,iconWidget: const SubMenuImage(),
          onTap: (index, _) {
            sideMenu.changePage(index);
            Get.toNamed(RouteHelper.getAbsentFineRoute());
          }),

      ]),



    if(profileController.hasPermission("academic_configuration.academic_session") || profileController.hasPermission("academic_configuration.shifts") || profileController.hasPermission("academic_configuration.classes") || profileController.hasPermission("academic_configuration.sections") || profileController.hasPermission("academic_configuration.groups") || profileController.hasPermission("academic_configuration.periods") || profileController.hasPermission("academic_configuration.subjects") || profileController.hasPermission("academic_configuration.subject_config") || profileController.hasPermission("academic_configuration.exams") || profileController.hasPermission("academic_configuration.student_categories") || profileController.hasPermission("academic_configuration.departments") || profileController.hasPermission("academic_configuration.picklist") || profileController.hasPermission("academic_configuration.principal_signatures"))
    SideMenuExpansionItem(title: "academic_configuration".tr, iconWidget: const MenuImage(icon : Images.academicConfiguration), children: [

    if(profileController.hasPermission("academic_configuration.academic_session"))
        SideMenuItem(title: 'academic_session'.tr,iconWidget: const SubMenuImage(icon : Images.studentInfo),
          onTap: (index, _) {
            sideMenu.changePage(index);
            Get.toNamed(RouteHelper.getAcademicSessionRoute());
          },),

      if(profileController.hasPermission("academic_configuration.shifts"))
        SideMenuItem(title: 'shift'.tr,iconWidget: const SubMenuImage(),
          onTap: (index, _) {
            sideMenu.changePage(index);
          Get.toNamed(RouteHelper.getShiftRoute());
          }),

      if(profileController.hasPermission("academic_configuration.classes"))
      SideMenuItem(title: 'class'.tr,iconWidget: const SubMenuImage(),
          onTap: (index, _) {
            sideMenu.changePage(index);
            Get.toNamed(RouteHelper.getClassListRoute());
          }),

      if(profileController.hasPermission("academic_configuration.sections"))
        SideMenuItem(title: 'section'.tr,iconWidget: const SubMenuImage(),
          onTap: (index, _) {
            sideMenu.changePage(index);
            Get.toNamed(RouteHelper.getSectionRoute());
          }),

      if(profileController.hasPermission("academic_configuration.groups"))
      SideMenuItem(title: 'group'.tr, iconWidget: const SubMenuImage(),
          onTap: (index, _) {
            sideMenu.changePage(index);
          Get.toNamed(RouteHelper.getGroupRoute());
          }),

      if(profileController.hasPermission("academic_configuration.periods"))
      SideMenuItem(title: 'period'.tr, iconWidget: const SubMenuImage(),
          onTap: (index, _) {
            sideMenu.changePage(index);
          Get.toNamed(RouteHelper.getPeriodRoute());
          }),

      if(profileController.hasPermission("academic_configuration.subjects"))
      SideMenuItem(title: 'subjects'.tr, iconWidget: const SubMenuImage(),
          onTap: (index, _) {
            sideMenu.changePage(index);
         Get.toNamed(RouteHelper.getSubjectsRoute());
          }),

      if(profileController.hasPermission("academic_configuration.subject_config"))
      SideMenuItem(title: 'subject_config'.tr,iconWidget: const SubMenuImage(),
          onTap: (index, _) {
            sideMenu.changePage(index);
         Get.toNamed(RouteHelper.getSubjectConfigRoute());
          }),

      if(profileController.hasPermission("academic_configuration.exams"))
      SideMenuItem(title: 'exam'.tr,iconWidget: const SubMenuImage(),
          onTap: (index, _) {
            sideMenu.changePage(index);
         Get.toNamed(RouteHelper.getExamRoute());
          }),

      if(profileController.hasPermission("academic_configuration.student_categories"))
      SideMenuItem(title: 'student_categories'.tr,iconWidget: const SubMenuImage(),
          onTap: (index, _) {
            sideMenu.changePage(index);
         Get.toNamed(RouteHelper.getStudentCategoriesRoute());
          }),

      if(profileController.hasPermission("academic_configuration.departments"))
      SideMenuItem(title: 'department'.tr,iconWidget: const SubMenuImage(),
          onTap: (index, _) {
            sideMenu.changePage(index);
         Get.toNamed(RouteHelper.getDepartmentRoute());
          }),

      if(profileController.hasPermission("academic_configuration.picklist"))
      SideMenuItem(title: 'picklist'.tr,iconWidget: const SubMenuImage(),
          onTap: (index, _) {
            sideMenu.changePage(index);
         Get.toNamed(RouteHelper.getPicklistRoute());
          }),

      if(profileController.hasPermission("academic_configuration.principal_signatures"))
      SideMenuItem(title: 'principal_signature'.tr,iconWidget: const SubMenuImage(),
          onTap: (index, _) {
            sideMenu.changePage(index);
          Get.toNamed(RouteHelper.getPrincipalSignatureRoute());
          }),

      ]),


    if(profileController.hasPermission("fees_management.startup") || profileController.hasPermission("fees_management.mapping") ||
        profileController.hasPermission("fees_management.amount_config")|| profileController.hasPermission("fees_management.date_config")||
        profileController.hasPermission("fees_management.fine_waiver")|| profileController.hasPermission("fees_management.waiver") ||
        profileController.hasPermission("fees_management.waiver_config")|| profileController.hasPermission("fees_management.smart_collection") ||
        profileController.hasPermission("fees_management.paid_info") || profileController.hasPermission("fees_management.unpaid_info"))
    SideMenuExpansionItem(title: "fees_management".tr, iconWidget: const MenuImage(icon : Images.studentInfo), children: [

      if(profileController.hasPermission("fees_management.startup"))
        SideMenuItem(title: 'fees_start_up'.tr,iconWidget: const SubMenuImage(),
          onTap: (index, _) {
            sideMenu.changePage(index);
          Get.toNamed(RouteHelper.getFeesStartUpRoute());
          },),

        if(profileController.hasPermission("fees_management.mapping"))
        SideMenuItem(title: 'fees_mapping'.tr,iconWidget: const SubMenuImage(),
          onTap: (index, _) {
            sideMenu.changePage(index);
          Get.toNamed(RouteHelper.getFeesMappingRoute());
          }),

      if(profileController.hasPermission("fees_management.amount_config"))
      SideMenuItem(title: 'amount_config'.tr,iconWidget: const SubMenuImage(),
          onTap: (index, _) {
            sideMenu.changePage(index);
         Get.toNamed(RouteHelper.getFeesAmountConfigRoute());
          }),

      if(profileController.hasPermission("fees_management.date_config"))
      SideMenuItem(title: 'date_config'.tr,iconWidget: const SubMenuImage(),
          onTap: (index, _) {
            sideMenu.changePage(index);
            Get.toNamed(RouteHelper.getFeeDateConfigRoute());
          }),

      if(profileController.hasPermission("fees_management.fine_waiver"))
      SideMenuItem(title: 'fine_waiver'.tr,iconWidget: const SubMenuImage(),
          onTap: (index, _) {
            sideMenu.changePage(index);
         Get.toNamed(RouteHelper.getFineWaiverRoute());
          }),

      if(profileController.hasPermission("fees_management.waiver"))
      SideMenuItem(title: 'waiver'.tr,iconWidget: const SubMenuImage(),
          onTap: (index, _) {
            sideMenu.changePage(index);
            Get.toNamed(RouteHelper.getWaiverRoute());
          }),

      if(profileController.hasPermission("fees_management.waiver_config"))
      SideMenuItem(title: 'waiver_config'.tr,iconWidget: const SubMenuImage(),
          onTap: (index, _) {
            sideMenu.changePage(index);
         Get.toNamed(RouteHelper.getWaiverConfigRoute());
          }),

      if(profileController.hasPermission("fees_management.smart_collection"))
      SideMenuItem(title: 'smart_collection'.tr,iconWidget: const SubMenuImage(),
          onTap: (index, _) {
            sideMenu.changePage(index);
         Get.toNamed(RouteHelper.getSmartCollectionRoute());
          }),

      if(profileController.hasPermission("fees_management.paid_info"))
      SideMenuItem(title: 'paid_info'.tr,iconWidget: const SubMenuImage(),
          onTap: (index, _) {
            sideMenu.changePage(index);
            Get.toNamed(RouteHelper.getPaidReportRoute());
          }),

      if(profileController.hasPermission("fees_management.unpaid_info"))
      SideMenuItem(title: 'unpaid_info'.tr,iconWidget: const SubMenuImage(),
          onTap: (index, _) {
            sideMenu.changePage(index);
            Get.toNamed(RouteHelper.getUnpaidInfoRoute());
          }),
      ]),



    if(profileController.hasPermission("accounting_management.ledgers") || profileController.hasPermission("accounting_management.funds") ||
        profileController.hasPermission("accounting_management.categories") || profileController.hasPermission("accounting_management.groups") ||
        profileController.hasPermission("accounting_management.payment") || profileController.hasPermission("accounting_management.receipt") ||
        profileController.hasPermission("accounting_management.contra") || profileController.hasPermission("accounting_management.journal") ||
        profileController.hasPermission("accounting_management.fund_transfer") || profileController.hasPermission("accounting_management.chart_of_accounts"))
    SideMenuExpansionItem(title: "account_management".tr, iconWidget: const MenuImage(icon : Images.studentInfo), children: [

      if(profileController.hasPermission("accounting_management.ledgers"))
        SideMenuItem(title: 'ledger'.tr, iconWidget: const SubMenuImage(),
          onTap: (index, _) {
            sideMenu.changePage(index);
          Get.toNamed(RouteHelper.getLedgerRoute());
          },),

      if(profileController.hasPermission("accounting_management.funds"))
        SideMenuItem(title: 'fund'.tr, iconWidget: const SubMenuImage(),
          onTap: (index, _) {
            sideMenu.changePage(index);
          Get.toNamed(RouteHelper.getAccountingFundRoute());
          }),

      if(profileController.hasPermission("accounting_management.categories"))
      SideMenuItem(title: 'category'.tr,iconWidget: const SubMenuImage(),
          onTap: (index, _) {
            sideMenu.changePage(index);
         Get.toNamed(RouteHelper.getAccountingCategoryRoute());
          }),

      if(profileController.hasPermission("accounting_management.groups"))
      SideMenuItem(title: 'group'.tr,iconWidget: const SubMenuImage(),
          onTap: (index, _) {
            sideMenu.changePage(index);
         Get.toNamed(RouteHelper.getAccountingGroupRoute());
          }),

      if(profileController.hasPermission("accounting_management.payment"))
      SideMenuItem(title: 'payment'.tr,iconWidget: const SubMenuImage(),
          onTap: (index, _) {
            sideMenu.changePage(index);
            Get.toNamed(RouteHelper.getPaymentRoute());
          }),

      if(profileController.hasPermission("accounting_management.receipt"))
      SideMenuItem(title: 'receipt'.tr,iconWidget: const SubMenuImage(),
          onTap: (index, _) {
            sideMenu.changePage(index);
         Get.toNamed(RouteHelper.getReceiptRoute());
          }),


      if(profileController.hasPermission("accounting_management.contra"))
      SideMenuItem(title: 'contra'.tr,iconWidget: const SubMenuImage(),
          onTap: (index, _) {
            sideMenu.changePage(index);
         Get.toNamed(RouteHelper.getContraRoute());
          }),

      if(profileController.hasPermission("accounting_management.journal"))
      SideMenuItem(title: 'journal'.tr,iconWidget: const SubMenuImage(),
          onTap: (index, _) {
            sideMenu.changePage(index);
         Get.toNamed(RouteHelper.getJournalRoute());
          }),

      if(profileController.hasPermission("accounting_management.fund_transfer"))
      SideMenuItem(title: 'fund_transfer'.tr,iconWidget: const SubMenuImage(),
          onTap: (index, _) {
            sideMenu.changePage(index);
         Get.toNamed(RouteHelper.getFundTransferRoute());
          }),

      if(profileController.hasPermission("accounting_management.chart_of_accounts"))
      SideMenuItem(title: 'chart_of_account'.tr,iconWidget: const SubMenuImage(),
          onTap: (index, _) {
            sideMenu.changePage(index);
         Get.toNamed(RouteHelper.getChartOfAccountRoute());
          }),
      ]),



    if(profileController.hasPermission("routine_management.admit_seat_plan") || profileController.hasPermission("routine_management.exam_routine") ||
        profileController.hasPermission("routine_management.class_routine") || profileController.hasPermission("routine_management.assignments") || profileController.hasPermission("routine_management.syllabuses"))
    SideMenuExpansionItem(title: "routine_management".tr, iconWidget: const MenuImage(icon : Images.routine), children: [
      if(profileController.hasPermission("routine_management.syllabuses"))
        SideMenuItem(title: 'syllabus'.tr,iconWidget: const SubMenuImage(),
          onTap: (index, _) {
            sideMenu.changePage(index);
            Get.toNamed(RouteHelper.getSyllabusRoute());
          },),

      if(profileController.hasPermission("routine_management.assignments"))
        SideMenuItem(title: 'assignments'.tr,iconWidget: const SubMenuImage(),
          onTap: (index, _) {
            sideMenu.changePage(index);
            Get.toNamed(RouteHelper.getAssignmentsRoute());
          }),

      if(profileController.hasPermission("routine_management.class_routine"))
      SideMenuItem(title: 'class_routine'.tr,iconWidget: const SubMenuImage(),
          onTap: (index, _) {
            sideMenu.changePage(index);
         Get.toNamed(RouteHelper.getClassRoutineRoute());
          }),

      if(profileController.hasPermission("routine_management.exam_routine"))
      SideMenuItem(title: 'exam_routine'.tr,iconWidget: const SubMenuImage(),
          onTap: (index, _) {
            sideMenu.changePage(index);
         Get.toNamed(RouteHelper.getExamRoutineRoute());
          }),

      if(profileController.hasPermission("routine_management.admit_seat_plan"))
      SideMenuItem(title: 'admit_and_seat_plan'.tr,iconWidget: const SubMenuImage(),
          onTap: (index, _) {
            sideMenu.changePage(index);
            Get.toNamed(RouteHelper.getAdmitAndSeatPlanRoute());
          }),

      ]),


    if(profileController.hasPermission("library_management.book_category") || profileController.hasPermission("library_management.books") ||
        profileController.hasPermission("library_management.members") || profileController.hasPermission("library_management.book_issue_search") ||
        profileController.hasPermission("library_management.book_issue_report"))
    SideMenuExpansionItem(title: "library_management".tr, iconWidget: const MenuImage(icon : Images.library), children: [

      if(profileController.hasPermission("library_management.book_category"))
        SideMenuItem(title: 'book_categories'.tr,iconWidget: const SubMenuImage(),
          onTap: (index, _) {
            sideMenu.changePage(index);
            Get.toNamed(RouteHelper.getBookCategoriesRoute());
          },),

      if(profileController.hasPermission("library_management.books"))
        SideMenuItem(title: 'books'.tr, iconWidget: const SubMenuImage(),
          onTap: (index, _) {
            sideMenu.changePage(index);
            Get.toNamed(RouteHelper.getBooksRoute());
          }),

      if(profileController.hasPermission("library_management.members"))
      SideMenuItem(title: 'members'.tr,iconWidget: const SubMenuImage(),
          onTap: (index, _) {
            sideMenu.changePage(index);
            Get.toNamed(RouteHelper.getLibraryMemberRoute());
          }),

      if(profileController.hasPermission("library_management.book_issue_search"))
      SideMenuItem(title: 'books_issue'.tr,iconWidget: const SubMenuImage(),
          onTap: (index, _) {
            sideMenu.changePage(index);
         Get.toNamed(RouteHelper.getBookIssueRoute());
          }),

      if(profileController.hasPermission("library_management.book_issue_search"))
      SideMenuItem(title: 'books_issue_search'.tr,iconWidget: const SubMenuImage(),
          onTap: (index, _) {
            sideMenu.changePage(index);
         Get.toNamed(RouteHelper.getBookReturnRoute());
          }),

      if(profileController.hasPermission("library_management.book_issue_report"))
      SideMenuItem(title: 'books_issue_report'.tr,iconWidget: const SubMenuImage(),
          onTap: (index, _) {
            sideMenu.changePage(index);
         Get.toNamed(RouteHelper.getBookIssueReportRoute());
          }),

      ]),

    if(profileController.hasPermission("exam_module.exam_start_up") || profileController.hasPermission("exam_module.mark_config") ||
        profileController.hasPermission("exam_module.remarks_config") || profileController.hasPermission("exam_module.mark_input") ||
        profileController.hasPermission("exam_module.exam_result"))
    SideMenuExpansionItem(title: "exm_management".tr, iconWidget: const MenuImage(icon : Images.exam), children: [

      if(profileController.hasPermission("exam_module.exam_start_up"))
        SideMenuItem(title: 'exam_start_up'.tr,iconWidget: const SubMenuImage(),
          onTap: (index, _) {
            sideMenu.changePage(index);
          Get.toNamed(RouteHelper.getExamStartUpRoute());
          },),

      if(profileController.hasPermission("exam_module.mark_config"))
        SideMenuItem(title: 'mark_config'.tr,iconWidget: const SubMenuImage(),
          onTap: (index, _) {
            sideMenu.changePage(index);
          Get.toNamed(RouteHelper.getMarkConfigRoute());
          }),

      if(profileController.hasPermission("exam_module.remarks_config"))
      SideMenuItem(title: 'remark_config'.tr,iconWidget: const SubMenuImage(),
          onTap: (index, _) {
            sideMenu.changePage(index);
         Get.toNamed(RouteHelper.getRemarkConfigRoute());
          }),

      if(profileController.hasPermission("exam_module.mark_input"))
      SideMenuItem(title: 'mark_input'.tr,iconWidget: const SubMenuImage(),
          onTap: (index, _) {
            sideMenu.changePage(index);
         Get.toNamed(RouteHelper.getMarkInputRoute());
          }),

      if(profileController.hasPermission("exam_module.exam_result"))
      SideMenuItem(title: 'exam_result'.tr,iconWidget: const SubMenuImage(),
          onTap: (index, _) {
            sideMenu.changePage(index);
         Get.toNamed(RouteHelper.getExamResultRoute());
          }),
      ]),

    if(profileController.hasPermission("student_information.student_migration"))
    SideMenuExpansionItem(title: "layout_and_certificate".tr, iconWidget: const MenuImage(icon : Images.certificate), children: [
        SideMenuItem(title: 'general_recommendation_letter'.tr, iconWidget: const SubMenuImage(),
          onTap: (index, _) {
            sideMenu.changePage(index);
          Get.toNamed(RouteHelper.getCertificateRoute(CertificateTypeEnum.recommendation));

          },),

        SideMenuItem(title: 'testimonial'.tr, iconWidget: const SubMenuImage(),
          onTap: (index, _) {
            sideMenu.changePage(index);
            Get.toNamed(RouteHelper.getCertificateRoute(CertificateTypeEnum.testimonial));

          }),
      SideMenuItem(title: 'attendance_certificate'.tr,iconWidget: const SubMenuImage(),
          onTap: (index, _) {
            sideMenu.changePage(index);
            Get.toNamed(RouteHelper.getCertificateRoute(CertificateTypeEnum.attendanceCertificate));
          }),
      SideMenuItem(title: 'hsc_recommendation_letter'.tr,iconWidget: const SubMenuImage(),
          onTap: (index, _) {
            sideMenu.changePage(index);
            Get.toNamed(RouteHelper.getCertificateRoute(CertificateTypeEnum.hscRecommendationLetter));

          }),
      SideMenuItem(title: 'abroad_letter'.tr,iconWidget: const SubMenuImage(),
          onTap: (index, _) {
            sideMenu.changePage(index);
            Get.toNamed(RouteHelper.getCertificateRoute(CertificateTypeEnum.abroadLetter));
          }),
      SideMenuItem(title: 'transfer_certificate'.tr,iconWidget: const SubMenuImage(),
          onTap: (index, _) {
            sideMenu.changePage(index);
            Get.toNamed(RouteHelper.getCertificateRoute(CertificateTypeEnum.transferCertificate));
          }),
      SideMenuItem(title: 'character_certificate'.tr,iconWidget: const SubMenuImage(),
          onTap: (index, _) {
            sideMenu.changePage(index);
            Get.toNamed(RouteHelper.getCertificateRoute(CertificateTypeEnum.characterCertificate));
          }),
      SideMenuItem(title: 'study_certificate'.tr,iconWidget: const SubMenuImage(),
          onTap: (index, _) {
            sideMenu.changePage(index);
            Get.toNamed(RouteHelper.getCertificateRoute(CertificateTypeEnum.studyCertificate));
          }),
      SideMenuItem(title: 'bonafide_certificate'.tr,iconWidget: const SubMenuImage(),
          onTap: (index, _) {
            sideMenu.changePage(index);
            Get.toNamed(RouteHelper.getCertificateRoute(CertificateTypeEnum.bonafideCertificate));
          }),
      SideMenuItem(title: 'migration_certificate'.tr,iconWidget: const SubMenuImage(),
          onTap: (index, _) {
            sideMenu.changePage(index);
            Get.toNamed(RouteHelper.getCertificateRoute(CertificateTypeEnum.migrationCertificate));
          }),
      SideMenuItem(title: 'id_card'.tr,iconWidget: const SubMenuImage(),
          onTap: (index, _) {
            sideMenu.changePage(index);
            Get.toNamed(RouteHelper.getIdCardRoute());
          }),
      ]),


    if(profileController.hasPermission("sms_notifications.templates") || profileController.hasPermission("sms_notifications.phonebook_category") ||
        profileController.hasPermission("sms_notifications.phonebook") || profileController.hasPermission("sms_notifications.sms_sent") ||
        profileController.hasPermission("sms_notifications.purchase_sms") || profileController.hasPermission("sms_notifications.sms_report"))
    SideMenuExpansionItem(title: "sms_management".tr, iconWidget: const MenuImage(icon : Images.sms), children: [

      if(profileController.hasPermission("sms_notifications.templates"))
        SideMenuItem(title: 'sms_template'.tr,iconWidget: const SubMenuImage(),
          onTap: (index, _) {
            sideMenu.changePage(index);
          Get.toNamed(RouteHelper.getSmsTemplateRoute());
          },),

      if(profileController.hasPermission("sms_notifications.phonebook_category"))
        SideMenuItem(title: 'phone_book_category'.tr,iconWidget: const  SubMenuImage(),
          onTap: (index, _) {
            sideMenu.changePage(index);
            Get.toNamed(RouteHelper.getPhoneBookCategoryRoute());
          }),

      if(profileController.hasPermission("sms_notifications.phonebook"))
      SideMenuItem(title: 'phone_book'.tr,iconWidget: const  SubMenuImage(),
          onTap: (index, _) {
            sideMenu.changePage(index);
         Get.toNamed(RouteHelper.getPhoneBookRoute());
          }),

      if(profileController.hasPermission("sms_notifications.sms_sent"))
      SideMenuItem(title: 'sms_sent'.tr,iconWidget: const SubMenuImage(),
          onTap: (index, _) {
            sideMenu.changePage(index);
          Get.toNamed(RouteHelper.getSmsSentRoute());
          }),

      if(profileController.hasPermission("sms_notifications.purchase_sms"))
      SideMenuItem(title: 'purchase_sms'.tr,iconWidget: const SubMenuImage(),
          onTap: (index, _) {
            sideMenu.changePage(index);
          Get.toNamed(RouteHelper.getPurchaseSmsRoute());
          }),

      if(profileController.hasPermission("sms_notifications.sms_report"))
      SideMenuItem(title: 'sms_report'.tr,iconWidget: const SubMenuImage(),
          onTap: (index, _) {
            sideMenu.changePage(index);
          }),
      ]),


    if(profileController.hasPermission("administrator.assign_shift") || profileController.hasPermission("administrator.assign_subject") ||
        profileController.hasPermission("administrator.assign_class") || profileController.hasPermission("administrator.notice") ||
        profileController.hasPermission("administrator.event") || profileController.hasPermission("administrator.contact_message") ||
        profileController.hasPermission("administrator.user_activities"))
    SideMenuExpansionItem(title: "administrator".tr, iconWidget: const MenuImage(icon : Images.administrator), children: [


      if(profileController.hasPermission("administrator.notice"))
      SideMenuItem(title: 'notice'.tr,iconWidget: const SubMenuImage(),
          onTap: (index, _) {
            sideMenu.changePage(index);
            Get.toNamed(RouteHelper.getNoticeRoute());
          }),

      if(profileController.hasPermission("administrator.event"))
      SideMenuItem(title: 'event'.tr,iconWidget: const SubMenuImage(),
          onTap: (index, _) {
            sideMenu.changePage(index);
            Get.toNamed(RouteHelper.getEventRoute());
          }),

      if(profileController.hasPermission("administrator.user_activities"))
      SideMenuItem(title: 'user_activities'.tr,iconWidget: const SubMenuImage(),
          onTap: (index, _) {
            sideMenu.changePage(index);
            Get.toNamed(RouteHelper.getUserActivitiesRoute());
          }),
      ]),


    if(profileController.hasPermission("quiz.topics") || profileController.hasPermission("quiz.questions") || profileController.hasPermission("quiz.answers") || profileController.hasPermission("quiz.results"))
    SideMenuExpansionItem(title: "quiz".tr, iconWidget: const MenuImage(icon : Images.quiz), children: [
      if(profileController.hasPermission("quiz.topics"))
        SideMenuItem(title: 'topics'.tr,iconWidget: const SubMenuImage(),
          onTap: (index, _) {
            sideMenu.changePage(index);
          Get.toNamed(RouteHelper.getQuizTopicRoute());
          },),

      if(profileController.hasPermission("quiz.questions"))
        SideMenuItem(title: 'questions'.tr,iconWidget: const SubMenuImage(),
          onTap: (index, _) {
            sideMenu.changePage(index);
          Get.toNamed(RouteHelper.getQuestionTopicRoute());
          }),

      if(profileController.hasPermission("quiz.answers"))
      SideMenuItem(title: 'answers'.tr,iconWidget: const SubMenuImage(),
          onTap: (index, _) {
            sideMenu.changePage(index);
          Get.toNamed(RouteHelper.getAnswerRoute());
          }),

      if(profileController.hasPermission("quiz.results"))
      SideMenuItem(title: 'quiz_results'.tr,iconWidget: const SubMenuImage(),
          onTap: (index, _) {
            sideMenu.changePage(index);
            Get.toNamed(RouteHelper.getQuizResultRoute());
          }),

      ]),





      //payroll_management
      if(profileController.hasPermission("payroll.payroll_start_up") || profileController.hasPermission("payroll.payroll_mapping") ||
          profileController.hasPermission("payroll.payroll_assign") || profileController.hasPermission("payroll.salary_slip") ||
          profileController.hasPermission("payroll.salary") || profileController.hasPermission("payroll.due") ||
          profileController.hasPermission("payroll.advance") || profileController.hasPermission("payroll.return_advance_payment") ||
          profileController.hasPermission("payroll.salary_statement") || profileController.hasPermission("payroll.payment_info"))

        SideMenuExpansionItem(title: "payroll_management".tr, iconWidget: const MenuImage(icon : Images.pay), children: [

          if(profileController.hasPermission("payroll.payroll_start_up"))
            SideMenuItem(title: 'payroll_start_up'.tr,iconWidget: const SubMenuImage(),
              onTap: (index, _) {
                sideMenu.changePage(index);
                Get.toNamed(RouteHelper.getPayrollStartUpRoute());
              },),

          if(profileController.hasPermission("payroll.payroll_mapping"))
            SideMenuItem(title: 'payroll_mapping'.tr,iconWidget: const SubMenuImage(),
                onTap: (index, _) {
                  sideMenu.changePage(index);
                  Get.toNamed(RouteHelper.getPayrollMappingRoute());
                }),

          if(profileController.hasPermission("payroll.payroll_assign"))
            SideMenuItem(title: 'payroll_assign'.tr,iconWidget: const SubMenuImage(),
                onTap: (index, _) {
                  sideMenu.changePage(index);
                  Get.toNamed(RouteHelper.getPayrollAssignRoute());
                }),

          if(profileController.hasPermission("payroll.salary_slip"))
            SideMenuItem(title: 'salary_slip'.tr,iconWidget: const SubMenuImage(),
                onTap: (index, _) {
                  sideMenu.changePage(index);
                  Get.toNamed(RouteHelper.getSalarySlipRoute());
                }),

          if(profileController.hasPermission("payroll.salary"))
            SideMenuItem(title: 'salary'.tr,iconWidget: const SubMenuImage(),
                onTap: (index, _) {
                  sideMenu.changePage(index);
                  Get.toNamed(RouteHelper.getSalaryRoute());
                }),

          if(profileController.hasPermission("payroll.due"))
            SideMenuItem(title: 'due'.tr,iconWidget: const SubMenuImage(),
                onTap: (index, _) {
                  sideMenu.changePage(index);
                  Get.toNamed(RouteHelper.getDueRoute());
                }),

          if(profileController.hasPermission("payroll.advance"))
            SideMenuItem(title: 'advance'.tr,iconWidget: const SubMenuImage(),
                onTap: (index, _) {
                  sideMenu.changePage(index);
                  Get.toNamed(RouteHelper.getAdvancedRoute());
                }),

          if(profileController.hasPermission("payroll.return_advance_payment"))
            SideMenuItem(title: 'return_advance_payment'.tr,iconWidget: const SubMenuImage(),
                onTap: (index, _) {
                  sideMenu.changePage(index);
                  Get.toNamed(RouteHelper.getReturnedAdvancedRoute());
                }),

          if(profileController.hasPermission("payroll.salary_statement"))
            SideMenuItem(title: 'salary_statement'.tr,iconWidget: const SubMenuImage(),
                onTap: (index, _) {
                  sideMenu.changePage(index);
                  Get.toNamed(RouteHelper.getSalaryStatementRoute());
                }),

          if(profileController.hasPermission("payroll.payment_info"))
            SideMenuItem(title: 'payment_info'.tr,iconWidget: const SubMenuImage(),
                onTap: (index, _) {
                  sideMenu.changePage(index);
                  Get.toNamed(RouteHelper.getPaymentInfoRoute());
                }),

        ]),

      // Reports Management Section


    if(profileController.hasPermission("accounting_report.balance_sheet"))
    SideMenuExpansionItem(title: "accounting_reports_management".tr, iconWidget: const MenuImage(icon : Images.exam), children: [
      SideMenuItem(title: 'balance_sheet'.tr, iconWidget: const SubMenuImage(),
        onTap: (index, _) {
        sideMenu.changePage(index);
        Get.toNamed(RouteHelper.getBalanceSheetRoute());
        },),

      SideMenuItem(title: 'trail_balance'.tr, iconWidget: const SubMenuImage(),
          onTap: (index, _) {
        sideMenu.changePage(index);
        Get.toNamed(RouteHelper.getTrailBalanceRoute());
      }),

      SideMenuItem(title: 'cash_flow'.tr, iconWidget: const SubMenuImage(),
          onTap: (index, _) {
            sideMenu.changePage(index);
            Get.toNamed(RouteHelper.getCashFlowRoute());
          }),

      SideMenuItem(title: 'income_statement'.tr, iconWidget: const SubMenuImage(),
          onTap: (index, _) {
            sideMenu.changePage(index);
            Get.toNamed(RouteHelper.getIncomeStatementRoute());
          }),

      SideMenuItem(title: 'fund_wise_report'.tr, iconWidget: const SubMenuImage(),
          onTap: (index, _) {
            sideMenu.changePage(index);
            Get.toNamed(RouteHelper.getFundWiseReportRoute());
          }),

      SideMenuItem(title: 'ledger_wise_report'.tr, iconWidget: const SubMenuImage(),
          onTap: (index, _) {
            sideMenu.changePage(index);
            Get.toNamed(RouteHelper.getLedgerWiseReportRoute());
          }),

      SideMenuItem(title: 'user_wise_report'.tr, iconWidget: const SubMenuImage(),
          onTap: (index, _) {
            sideMenu.changePage(index);
            Get.toNamed(RouteHelper.getUserWiseReportRoute());
          }),

      SideMenuItem(title: 'voucher_wise_report'.tr, iconWidget: const SubMenuImage(),
          onTap: (index, _) {
            sideMenu.changePage(index);
            Get.toNamed(RouteHelper.getVoucherWiseReportRoute());
          }),


    ]),

      if(profileController.hasPermission("fees_management.startup"))
      SideMenuExpansionItem(title: "fees_reports_management".tr, iconWidget: const MenuImage(icon : Images.exam), children: [
        SideMenuItem(title: 'fee_monthly_report'.tr, iconWidget: const SubMenuImage(),
          onTap: (index, _) {
            sideMenu.changePage(index);
            Get.toNamed(RouteHelper.getFeesMonthlyPaymentInfoRoute());
          },),

        SideMenuItem(title: 'payment_info'.tr, iconWidget: const SubMenuImage(),
            onTap: (index, _) {
              sideMenu.changePage(index);
              Get.toNamed(RouteHelper.getFeesReportPaymentInfoRoute());
            }),

        SideMenuItem(title: 'head_wise_info'.tr, iconWidget: const SubMenuImage(),
            onTap: (index, _) {
              sideMenu.changePage(index);
              Get.toNamed(RouteHelper.getHeadWiseFeesInfoReportRoute());
            }),

        SideMenuItem(title: 'unpaid_info'.tr, iconWidget: const SubMenuImage(),
            onTap: (index, _) {
              sideMenu.changePage(index);
              Get.toNamed(RouteHelper.getUnpaidFeesInfoReportRoute());
            }),

        SideMenuItem(title: 'payment_ratio_info'.tr, iconWidget: const SubMenuImage(),
            onTap: (index, _) {
              sideMenu.changePage(index);
              Get.toNamed(RouteHelper.getFeesPaymentRatioInfoReportRoute());
            }),

      ]),






      if(profileController.hasPermission("master_configuration.branches"))
        SideMenuExpansionItem(title: "master_configuration".tr, iconWidget: const MenuImage(icon : Images.masterConfig), children: [



        if(profileController.hasPermission("master_configuration.branches"))
        SideMenuItem(title: 'system_settings'.tr,iconWidget: const SubMenuImage(),
          onTap: (index, _) {
            sideMenu.changePage(index);
          Get.toNamed(RouteHelper.getSystemSettingsRoute());
          },),



      if(profileController.hasPermission("database_backup"))
      SideMenuItem(title: 'database_backup'.tr,iconWidget: const SubMenuImage(),
          onTap: (index, _) {
            sideMenu.changePage(index);
            Get.dialog(ConfirmationDialog(
              backup: true,
              title: "backup",
              content: "backup",
              onTap: (){
                Get.back();
                Get.dialog(barrierDismissible: false, const DataSyncWidget());
                Future.delayed(const Duration(seconds: 10), () {
                  if (Navigator.canPop(Get.context!)) {
                    Navigator.of(Get.context!).pop();
                    showCustomSnackBar("data_backup_successfully".tr, isError: false);
                  }
                });
              },));
          }),

      ]),

    if(profileController.hasPermission("zoom-index"))
      SideMenuExpansionItem(title: "zoom_meeting".tr, iconWidget: const MenuImage(icon : Images.zoom), children: [

        SideMenuItem(title: 'zoom_config'.tr, iconWidget: const  SubMenuImage(icon : Images.zoom),
            onTap: (index, _) {
              sideMenu.changePage(index);
              Get.toNamed(RouteHelper.getZoomConfigRoute());
            }),

        SideMenuItem(title: 'zoom_meeting'.tr, iconWidget: const  SubMenuImage(icon : Images.zoom),
            onTap: (index, _) {
              sideMenu.changePage(index);
              Get.toNamed(RouteHelper.getZoomMeetingRoute());
            }),
      ]),




      if(profileController.hasPermission("master_configuration.branches"))
    SideMenuExpansionItem(title: "cms_management".tr, iconWidget: const MenuImage(icon : Images.cms), children: [
      SideMenuItem(title: 'about_us'.tr, iconWidget: const  SubMenuImage(icon : Images.homeActive,),
          onTap: (index, _) {
            sideMenu.changePage(index);
            Get.toNamed(RouteHelper.getAboutUsRoute());
          }),

      SideMenuItem(title: 'banner'.tr, iconWidget: const  SubMenuImage(icon : Images.homeActive),
          onTap: (index, _) {
            sideMenu.changePage(index);
            Get.toNamed(RouteHelper.getBannerRoute());
          }),

      SideMenuItem(title: 'why_choose_us'.tr, iconWidget: const  SubMenuImage(icon : Images.homeActive),
          onTap: (index, _) {
            sideMenu.changePage(index);
            Get.toNamed(RouteHelper.getWhyChooseUsRoute());
          }),

      SideMenuItem(title: 'mobile_app_section'.tr, iconWidget: const  SubMenuImage(icon : Images.homeActive),
          onTap: (index, _) {
            sideMenu.changePage(index);
            Get.toNamed(RouteHelper.getMobileAppSectionRoute());
          }),

      SideMenuItem(title: 'ready_to_join'.tr, iconWidget: const  SubMenuImage(icon : Images.homeActive),
          onTap: (index, _) {
            sideMenu.changePage(index);
            Get.toNamed(RouteHelper.getReadyToJoinRoute());
          }),


      SideMenuItem(title: 'faq'.tr, iconWidget: const  SubMenuImage(icon : Images.homeActive),
          onTap: (index, _) {
            sideMenu.changePage(index);
            Get.toNamed(RouteHelper.getFaqRoute());
          }),

      SideMenuItem(title: 'feedback'.tr, iconWidget: const  SubMenuImage(icon : Images.homeActive),
          onTap: (index, _) {
            sideMenu.changePage(index);
            Get.toNamed(RouteHelper.getFeedbackRoute());
          }),

    ]),


      // Hostel Management Section
      if(profileController.hasPermission("hostel_panel"))
      SideMenuExpansionItem(title: "hostel_management".tr, iconWidget: const MenuImage(icon : Images.student), children: [


          SideMenuItem(title: 'hostels'.tr, iconWidget: const SubMenuImage(),
            onTap: (index, _) {
              sideMenu.changePage(index);
              Get.toNamed(RouteHelper.getHostelsRoute());
            }),


          SideMenuItem(title: 'hostel_categories'.tr, iconWidget: const SubMenuImage(),
            onTap: (index, _) {
              sideMenu.changePage(index);
              Get.toNamed(RouteHelper.getHostelCategoriesRoute());
            }),


          SideMenuItem(title: 'hostel_rooms'.tr, iconWidget: const SubMenuImage(),
            onTap: (index, _) {
              sideMenu.changePage(index);
              Get.toNamed(RouteHelper.getHostelRoomsRoute());
            }),


          SideMenuItem(title: 'hostel_members'.tr, iconWidget: const SubMenuImage(),
            onTap: (index, _) {
              sideMenu.changePage(index);
              Get.toNamed(RouteHelper.getHostelMembersRoute());
            }),

          //
          // SideMenuItem(title: 'hostel_room_members'.tr, iconWidget: const SubMenuImage(),
          //   onTap: (index, _) {
          //     sideMenu.changePage(index);
          //     Get.toNamed(RouteHelper.getHostelRoomMembersRoute());
          //   }),


          SideMenuItem(title: 'hostel_meals'.tr, iconWidget: const SubMenuImage(),
            onTap: (index, _) {
              sideMenu.changePage(index);
              Get.toNamed(RouteHelper.getHostelMealsRoute());
            }),


          SideMenuItem(title: 'hostel_meal_plan'.tr, iconWidget: const SubMenuImage(),
            onTap: (index, _) {
              sideMenu.changePage(index);
              Get.toNamed(RouteHelper.getHostelMealPlanRoute());
            }),


          SideMenuItem(title: 'hostel_meal_entries'.tr, iconWidget: const SubMenuImage(),
            onTap: (index, _) {
              sideMenu.changePage(index);
              Get.toNamed(RouteHelper.getHostelMealEntriesRoute());
            }),


          SideMenuItem(title: 'hostel_bills'.tr, iconWidget: const SubMenuImage(),
            onTap: (index, _) {
              sideMenu.changePage(index);
              Get.toNamed(RouteHelper.getHostelBillsRoute());
            }),

      ]),

      // Transportation Management Section
      if(profileController.hasPermission("transport_panel_off") )
      SideMenuExpansionItem(title: "transportation_management".tr, iconWidget: const MenuImage(icon : Images.warehouse), children: [


          SideMenuItem(title: 'transport_buses'.tr, iconWidget: const SubMenuImage(),
            onTap: (index, _) {
              sideMenu.changePage(index);
              Get.toNamed(RouteHelper.getTransportBusesRoute());
            }),


          SideMenuItem(title: 'transport_drivers'.tr, iconWidget: const SubMenuImage(),
            onTap: (index, _) {
              sideMenu.changePage(index);
              Get.toNamed(RouteHelper.getTransportDriversRoute());
            }),


          SideMenuItem(title: 'bus_routes'.tr, iconWidget: const SubMenuImage(),
            onTap: (index, _) {
              sideMenu.changePage(index);
              Get.toNamed(RouteHelper.getBusRoutesRoute());
            }),


          SideMenuItem(title: 'bus_stops'.tr, iconWidget: const SubMenuImage(),
            onTap: (index, _) {
              sideMenu.changePage(index);
              Get.toNamed(RouteHelper.getBusStopsRoute());
            }),


          SideMenuItem(title: 'transport_members'.tr, iconWidget: const SubMenuImage(),
            onTap: (index, _) {
              sideMenu.changePage(index);
              Get.toNamed(RouteHelper.getTransportMembersRoute());
            }),

      ]),

      if(profileController.hasPermission("master_configuration.branches"))
    SideMenuExpansionItem(title: "AI".tr, iconWidget: const MenuImage(icon : Images.ai),children:   [
      SideMenuItem(title: 'chatgpt'.tr, iconWidget: const  SubMenuImage(icon : Images.ai),
          onTap: (index, _) {
            sideMenu.changePage(index);
            Get.toNamed(RouteHelper.getChatGptRoute());
          }),
    ])


  ];}

  List<dynamic> _buildSaasSideMenuItems() {
    return  [
      SideMenuItem(title: 'dashboard'.tr, iconWidget: const  MenuImage(icon : Images.homeActive),
          onTap: (index, _) {
            sideMenu.changePage(index);
            Get.toNamed(RouteHelper.getDashboardRoute());
          }),


    SideMenuItem(title: 'institute'.tr, iconWidget: const  MenuImage(icon : Images.institute),
            onTap: (index, _) {
              sideMenu.changePage(index);
              Get.toNamed(RouteHelper.getInstituteRoute());
            }),

       SideMenuItem(title: 'subscription_plan'.tr, iconWidget: const  MenuImage(icon : Images.subscription),
            onTap: (index, _) {
              sideMenu.changePage(index);
              Get.toNamed(RouteHelper.getPackagePlanRoute());
            }),

      SideMenuItem(title: 'payment_method'.tr, iconWidget: const  MenuImage(icon : Images.paymentGateway),
            onTap: (index, _) {
              sideMenu.changePage(index);
              Get.toNamed(RouteHelper.getSaasPaymentGatewayRoute());
            }),


        // SideMenuItem(title: 'pending_institute'.tr, iconWidget: const  MenuImage(icon : Images.institute),
        //     onTap: (index, _) {
        //       sideMenu.changePage(index);
        //       Get.toNamed(RouteHelper.getPendingInstituteRoute());
        //     }),


    ];}

  List<dynamic> _buildParentSideMenuItems() {
    return  [
        SideMenuItem(title: 'dashboard'.tr, iconWidget: const  MenuImage(icon : Images.homeActive),
            onTap: (index, _) {
              sideMenu.changePage(index);
              Get.toNamed(RouteHelper.getDashboardRoute());
            }),

      SideMenuItem(title: 'routine'.tr, iconWidget: const  MenuImage(icon : Images.routine),
          onTap: (index, _) {
            sideMenu.changePage(index);
            Get.toNamed(RouteHelper.getParentClassRoutineRoute());
          }),

      SideMenuItem(title: 'fees'.tr, iconWidget: const  MenuImage(icon : Images.routine),
          onTap: (index, _) {
            sideMenu.changePage(index);
            Get.toNamed(RouteHelper.getParentFeesRoute());
          }),

      SideMenuItem(title: 'library'.tr, iconWidget: const  MenuImage(icon : Images.library),
          onTap: (index, _) {
            sideMenu.changePage(index);
            Get.toNamed(RouteHelper.getParentLibraryRoute());
          }),

      SideMenuItem(title: 'assignment'.tr, iconWidget: const  MenuImage(icon : Images.library),
          onTap: (index, _) {
            sideMenu.changePage(index);
            Get.toNamed(RouteHelper.getParentAssignmentRoute());
          }),

      SideMenuItem(title: 'behavior'.tr, iconWidget: const  MenuImage(icon : Images.library),
          onTap: (index, _) {
            sideMenu.changePage(index);
            Get.toNamed(RouteHelper.getParentBehaviourRoute());
          }),

      SideMenuItem(title: 'notice'.tr, iconWidget: const  MenuImage(icon : Images.notice),
          onTap: (index, _) {
            sideMenu.changePage(index);
            Get.toNamed(RouteHelper.getParentNoticeRoute());
          }),

      SideMenuItem(title: 'event'.tr, iconWidget: const  MenuImage(icon : Images.event),
          onTap: (index, _) {
            sideMenu.changePage(index);
            Get.toNamed(RouteHelper.getParentEventRoute());
          }),
      SideMenuItem(title: 'exams'.tr, iconWidget: const  MenuImage(icon : Images.exam),
          onTap: (index, _) {
            sideMenu.changePage(index);
            Get.toNamed(RouteHelper.getParentExamRoute());
          }),

    ];}

  List<dynamic> _buildStudentSideMenuItems() {
    return  [
      SideMenuItem(title: 'dashboard'.tr, iconWidget: const  MenuImage(icon : Images.homeActive),
          onTap: (index, _) {
            sideMenu.changePage(index);
            Get.toNamed(RouteHelper.getDashboardRoute());
          }),

      SideMenuItem(title: 'routine'.tr, iconWidget: const  MenuImage(icon : Images.routine),
          onTap: (index, _) {
            sideMenu.changePage(index);
            Get.toNamed(RouteHelper.getStudentClassRoutineRoute());
          }),

      SideMenuItem(title: 'fees'.tr, iconWidget: const  MenuImage(icon : Images.routine),
          onTap: (index, _) {
            sideMenu.changePage(index);
            //:TODO
            Get.toNamed(RouteHelper.getParentFeesRoute());
          }),

      SideMenuItem(title: 'library'.tr, iconWidget: const  MenuImage(icon : Images.library),
          onTap: (index, _) {
            sideMenu.changePage(index);
            Get.toNamed(RouteHelper.getStudentLibraryRoute());
          }),

      SideMenuItem(title: 'assignment'.tr, iconWidget: const  MenuImage(icon : Images.library),
          onTap: (index, _) {
            sideMenu.changePage(index);
            Get.toNamed(RouteHelper.getStudentAssignmentRoute());
          }),

      SideMenuItem(title: 'behavior'.tr, iconWidget: const  MenuImage(icon : Images.library),
          onTap: (index, _) {
            sideMenu.changePage(index);
            Get.toNamed(RouteHelper.getParentBehaviourRoute());
          }),

      SideMenuItem(title: 'notice'.tr, iconWidget: const  MenuImage(icon : Images.notice),
          onTap: (index, _) {
            sideMenu.changePage(index);
            Get.toNamed(RouteHelper.getStudentNoticeRoute());
          }),

      SideMenuItem(title: 'event'.tr, iconWidget: const  MenuImage(icon : Images.event),
          onTap: (index, _) {
            sideMenu.changePage(index);
            Get.toNamed(RouteHelper.getParentEventRoute());
          }),
      // SideMenuItem(title: 'exams'.tr, iconWidget: const  MenuImage(icon : Images.exam),
      //     onTap: (index, _) {
      //       sideMenu.changePage(index);
      //       Get.toNamed(RouteHelper.getParentExamRoute());
      //     }),

    ];}

  List<dynamic> _buildInitSideMenuItems() {
    return  [


    ];}

}