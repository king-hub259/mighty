import 'package:get/get.dart';
import 'package:mighty_school/feature/layout_and_certificate/enum/certificate_type_enum.dart';
import 'package:mighty_school/feature/profile/logic/profile_controller.dart';
import 'package:mighty_school/helper/route_helper.dart';

class UserGuideItem {
  final String routeName;
  final String title;
  final String description;

  UserGuideItem({required this.routeName, required this.title, required this.description});
}


final ProfileController profileController = Get.find<ProfileController>();

List<UserGuideItem> userGuideItems = [
  if(profileController.hasPermission("dashboard"))
    UserGuideItem(routeName: RouteHelper.getDashboardRoute(), title: 'dashboard'.tr,
      description: 'Navigate to ${"dashboard".tr} to view an overview of the system.'),



  if(profileController.hasPermission("master_configuration.branches"))
  UserGuideItem(routeName: RouteHelper.getBranchRoute(), title: 'branch'.tr,
      description: 'Navigate to ${"branch".tr} to manage branch information.'),


  if(profileController.hasPermission("student_information.student_index"))
  UserGuideItem(routeName: RouteHelper.getStudentListRoute(), title: 'student_list'.tr,
      description: 'Navigate to ${"student_list".tr} to view the list of all students.'),



  if(profileController.hasPermission("student_information.student_migration"))
  UserGuideItem(routeName: RouteHelper.getStudentMigrationRoute(), title: 'student_migration'.tr,
      description: 'Navigate to ${"student_migration".tr} to manage student migration.'),


  if(profileController.hasPermission("student_information.student_pullback"))
  UserGuideItem(routeName: RouteHelper.getMigrationPushbackRoute(), title: 'student_pullback'.tr,
      description: 'Navigate to ${"student_pullback".tr} to manage student pullbacks.'),


  if(profileController.hasPermission("student_information.migration_list"))
  UserGuideItem(routeName: RouteHelper.getMigrationListRoute(), title: 'migration_list'.tr,
      description: 'Navigate to ${"migration_list".tr} to view the list of student migrations.'),

  if(profileController.hasPermission("student_information.all_student_list"))
  UserGuideItem(routeName: RouteHelper.getAllStudentViewListRoute(), title: 'all_student_list'.tr,
      description: 'Navigate to ${"all_student_list".tr} to view all students across branches.'),


  if(profileController.hasPermission("staff_information.staff_attendance_create"))
  UserGuideItem(routeName: RouteHelper.getStaffAttendanceRoute(), title: 'staff_attendance'.tr,
      description: 'Navigate to ${"staff_attendance".tr} to manage staff attendance.'),


  if(profileController.hasPermission("staff_information.staff_index"))
  UserGuideItem(routeName: RouteHelper.getStaffListRoute(), title: 'staff_list'.tr,
      description: 'Navigate to ${"staff_list".tr} to view the list of all staff members.'),


  if(profileController.hasPermission("staff_information.teachers_index"))
  UserGuideItem(routeName: RouteHelper.getTeacherListRoute(), title: 'teacher_list'.tr,
      description: 'Navigate to ${"teacher_list".tr} to view the list of all teachers.'),

  if(profileController.hasPermission("student_attendance.exam_attendance_index"))
  UserGuideItem(routeName: RouteHelper.getExamAttendanceRoute(), title: 'exam_attendance'.tr,
      description: 'Navigate to ${"exam_attendance".tr} to manage exam attendance.'),


  if(profileController.hasPermission("student_attendance.exam_attendance_schedule"))
  UserGuideItem(routeName: RouteHelper.getExamScheduleRoute(), title: 'exam_attendance_schedule'.tr,
      description: 'Navigate to ${"exam_attendance_schedule".tr} to manage exam attendance schedules.'),


  if(profileController.hasPermission("student_attendance.student_attendance_report"))
  UserGuideItem(routeName: RouteHelper.getAttendanceReportRoute(), title: 'student_attendance_report'.tr,
      description: 'Navigate to ${"student_attendance_report".tr} to view student attendance reports.'),


  if(profileController.hasPermission("student_attendance.student_absent_report"))
  UserGuideItem(routeName: RouteHelper.getAbsentFineRoute(), title: 'student_absent_report'.tr,
      description: 'Navigate to ${"student_absent_report".tr} to view reports of student absences.'),


  if(profileController.hasPermission("academic_configuration.academic_session"))
  UserGuideItem(routeName: RouteHelper.getAcademicSessionRoute(), title: 'academic_session'.tr,
      description: 'Navigate to ${"academic_session".tr} to manage academic sessions.'),


  if(profileController.hasPermission("academic_configuration.shifts"))
  UserGuideItem(routeName: RouteHelper.getShiftRoute(), title: 'shift'.tr,
      description: 'Navigate to ${"shift".tr} to manage shifts for classes and staff.'),


  if(profileController.hasPermission("academic_configuration.classes"))
  UserGuideItem(routeName: RouteHelper.getClassListRoute(), title: 'class'.tr,
      description: 'Navigate to ${"class".tr} to manage classes and their details.'),


  if(profileController.hasPermission("academic_configuration.sections"))
  UserGuideItem(routeName: RouteHelper.getSectionRoute(), title: 'section'.tr,
      description: 'Navigate to ${"section".tr} to manage sections within classes.'),


  if(profileController.hasPermission("academic_configuration.groups"))
  UserGuideItem(routeName: RouteHelper.getGroupRoute(), title: 'group'.tr,
      description: 'Navigate to ${"group".tr} to manage student groups.'),


  if(profileController.hasPermission("academic_configuration.periods"))
  UserGuideItem(routeName: RouteHelper.getPeriodRoute(), title: 'period'.tr,
      description: 'Navigate to ${"period".tr} to manage class periods and schedules.'),


  if(profileController.hasPermission("academic_configuration.subjects"))
  UserGuideItem(routeName: RouteHelper.getSubjectsRoute(), title: 'subject'.tr,
      description: 'Navigate to ${"subject".tr} to manage subjects taught in classes.'),


  if(profileController.hasPermission("academic_configuration.subject_config"))
  UserGuideItem(routeName: RouteHelper.getSubjectConfigRoute(), title: 'subject_config'.tr,
      description: 'Navigate to ${"subject_config".tr} to configure subjects for classes.'),


  if(profileController.hasPermission("academic_configuration.exams"))
  UserGuideItem(routeName: RouteHelper.getExamRoute(), title: 'exam'.tr,
      description: 'Navigate to ${"exam".tr} to manage exams and their schedules.'),



  if(profileController.hasPermission("academic_configuration.student_categories"))
  UserGuideItem(routeName: RouteHelper.getStudentCategoriesRoute(), title: 'student_category'.tr,
      description: 'Navigate to ${"student_category".tr} to manage student categories.'),


  if(profileController.hasPermission("academic_configuration.departments"))
  UserGuideItem(routeName: RouteHelper.getDepartmentRoute(), title: 'department'.tr,
      description: 'Navigate to ${"department".tr} to manage academic departments.'),


  if(profileController.hasPermission("academic_configuration.picklist"))
  UserGuideItem(routeName: RouteHelper.getPicklistRoute(), title: 'pick_list'.tr,
      description: 'Navigate to ${"pick_list".tr} to manage pick lists for various configurations.'),


  if(profileController.hasPermission("academic_configuration.principal_signatures"))
  UserGuideItem(routeName: RouteHelper.getPrincipalSignatureRoute(), title: 'principal_signature'.tr,
      description: 'Navigate to ${"principal_signature".tr} to manage principal signatures for documents.'),


  if(profileController.hasPermission("fees_management.startup"))
  UserGuideItem(routeName: RouteHelper.getFeesManagementRoute(), title: 'fees_management'.tr,
      description: 'Navigate to ${"fees_management".tr} to manage student fees and payments.'),


  if(profileController.hasPermission("fees_management.mapping"))
  UserGuideItem(routeName: RouteHelper.getFeesMappingRoute(), title: 'fees_mapping'.tr,
      description: 'Navigate to ${"fees_mapping".tr} to map fees to different categories and students.'),


  if(profileController.hasPermission("fees_management.amount_config"))
  UserGuideItem(routeName: RouteHelper.getFeesAmountConfigRoute(), title: 'fees_amount_config'.tr,
      description: 'Navigate to ${"fees_amount_config".tr} to configure fee amounts for different categories.'),


  if(profileController.hasPermission("fees_management.date_config"))
  UserGuideItem(routeName: RouteHelper.getFeeDateConfigRoute(), title: 'fees_date_config'.tr,
      description: 'Navigate to ${"fees_date_config".tr} to configure fee payment dates and deadlines.'),


  if(profileController.hasPermission("fees_management.fine_waiver"))
  UserGuideItem(routeName: RouteHelper.getFineWaiverRoute(), title: 'fees_waiver'.tr,
      description: 'Navigate to ${"fees_waiver".tr} to manage fee waivers for students.'),


  if(profileController.hasPermission("fees_management.waiver"))
  UserGuideItem(routeName: RouteHelper.getWaiverRoute(), title: 'fees_waiver'.tr,
      description: 'Navigate to ${"fees_waiver".tr} to manage fee waivers for students.'),


  if(profileController.hasPermission("fees_management.waiver_config"))
  UserGuideItem(routeName: RouteHelper.getWaiverConfigRoute(), title: 'fees_waiver_config'.tr,
      description: 'Navigate to ${"fees_waiver_config".tr} to configure fee waivers for different categories.'),


  if(profileController.hasPermission("fees_management.smart_collection"))
  UserGuideItem(routeName: RouteHelper.getSmartCollectionRoute(), title: 'smart_collection'.tr,
      description: 'Navigate to ${"smart_collection".tr} to manage smart fee collections and payments.'),


  if(profileController.hasPermission("fees_management.paid_info"))
  UserGuideItem(routeName: RouteHelper.getPaidInfoRoute(), title: 'paid_info'.tr,
      description: 'Navigate to ${"paid_info".tr} to view information about paid fees and transactions.'),


  if(profileController.hasPermission("fees_management.unpaid_info"))
  UserGuideItem(routeName: RouteHelper.getUnpaidInfoRoute(), title: 'unpaid_info'.tr,
      description: 'Navigate to ${"unpaid_info".tr} to view information about unpaid fees and dues.'),


  if(profileController.hasPermission("accounting_management.ledgers"))
  UserGuideItem(routeName: RouteHelper.getLedgerRoute(), title: 'ledger'.tr,
      description: 'Navigate to ${"ledger".tr} to manage financial ledgers and transactions.'),


  if(profileController.hasPermission("accounting_management.funds"))
  UserGuideItem(routeName: RouteHelper.getAccountingFundRoute(), title: 'fund'.tr,
      description: 'Navigate to ${"fund".tr} to manage funds and financial resources.'),


  if(profileController.hasPermission("accounting_management.categories"))
  UserGuideItem(routeName: RouteHelper.getAccountingCategoryRoute(), title: 'category'.tr,
      description: 'Navigate to ${"category".tr} to manage financial categories and classifications.'),


  if(profileController.hasPermission("accounting_management.groups"))
  UserGuideItem(routeName: RouteHelper.getAccountingGroupRoute(), title: 'group'.tr,
      description: 'Navigate to ${"group".tr} to manage financial groups and their details.'),



  if(profileController.hasPermission("accounting_management.payment"))
  UserGuideItem(routeName: RouteHelper.getPaymentRoute(), title: 'payment'.tr,
      description: 'Navigate to ${"payment".tr} to manage financial payments and transactions.'),



  if(profileController.hasPermission("accounting_management.receipt"))
  UserGuideItem(routeName: RouteHelper.getReceiptRoute(), title: 'receipt'.tr,
      description: 'Navigate to ${"receipt".tr} to manage financial receipts and records.'),



  if(profileController.hasPermission("accounting_management.contra"))
  UserGuideItem(routeName: RouteHelper.getContraRoute(), title: 'contra'.tr,
      description: 'Navigate to ${"contra".tr} to manage contra entries in financial records.'),



  if(profileController.hasPermission("accounting_management.journal"))
  UserGuideItem(routeName: RouteHelper.getJournalRoute(), title: 'journal'.tr,
      description: 'Navigate to ${"journal".tr} to manage journal entries in financial records.'),


  if(profileController.hasPermission("accounting_management.fund_transfer"))
  UserGuideItem(routeName: RouteHelper.getFundTransferRoute(), title: 'fund_transfer'.tr,
      description: 'Navigate to ${"fund_transfer".tr} to manage fund transfers between accounts.'),

  if(profileController.hasPermission("accounting_management.chart_of_accounts"))
  UserGuideItem(routeName: RouteHelper.getChartOfAccountRoute(), title: 'chart_of_accounts'.tr,
      description: 'Navigate to ${"chart_of_accounts".tr} to manage the chart of accounts for financial records.'),


  if(profileController.hasPermission("routine_management.syllabuses"))
  UserGuideItem(routeName: RouteHelper.getSyllabusRoute(), title: 'syllabus'.tr,
      description: 'Navigate to ${"syllabus".tr} to manage the syllabus for classes and subjects.'),

  if(profileController.hasPermission("routine_management.assignments"))
  UserGuideItem(routeName: RouteHelper.getAssignmentsRoute(), title: 'assignments'.tr,
      description: 'Navigate to ${"assignments".tr} to manage assignments for students and classes.'),

  if(profileController.hasPermission("routine_management.class_routine"))
  UserGuideItem(routeName: RouteHelper.getClassRoutineRoute(), title: 'class_routine'.tr,
      description: 'Navigate to ${"class_routine".tr} to manage class schedules and routines.'),


  if(profileController.hasPermission("routine_management.exam_routine"))
  UserGuideItem(routeName: RouteHelper.getExamRoutineRoute(), title: 'exam_routine'.tr,
      description: 'Navigate to ${"exam_routine".tr} to manage exam schedules and routines.'),


  if(profileController.hasPermission("routine_management.admit_seat_plan"))
  UserGuideItem(routeName: RouteHelper.getAdmitAndSeatPlanRoute(), title: 'admit_seat_plan'.tr,
      description: 'Navigate to ${"admit_seat_plan".tr} to manage seating arrangements for exams.'),


  if(profileController.hasPermission("library_management.book_category"))
  UserGuideItem(routeName: RouteHelper.getBookCategoriesRoute(), title: 'book_categories'.tr,
      description: 'Navigate to ${"book_categories".tr} to manage book categories in the library.'),


  if(profileController.hasPermission("library_management.books"))
  UserGuideItem(routeName: RouteHelper.getBooksRoute(), title: 'book'.tr,
      description: 'Navigate to ${"book".tr} to manage books in the library.'),

  if(profileController.hasPermission("library_management.members"))
  UserGuideItem(routeName: RouteHelper.getLibraryMemberRoute(), title: 'library_member'.tr,
      description: 'Navigate to ${"library_member".tr} to manage library members and their details.'),


  if(profileController.hasPermission("library_management.book_issue_search"))
  UserGuideItem(routeName: RouteHelper.getBookIssueRoute(), title: 'book_issue_search'.tr,
      description: 'Navigate to ${"book_issue_search".tr} to search for book issues and returns.'),


  if(profileController.hasPermission("library_management.book_issue_search"))
  UserGuideItem(routeName: RouteHelper.getBookReturnRoute(), title: 'book_issue_search'.tr,
      description: 'Navigate to ${"book_issue_search".tr} to search for book issues and returns.'),

  if(profileController.hasPermission("library_management.book_issue_report"))
  UserGuideItem(routeName: RouteHelper.getBookIssueReportRoute(), title: 'book_issue_report'.tr,
      description: 'Navigate to ${"book_issue_report".tr} to view reports of book issues and returns.'),


  if(profileController.hasPermission("exam_module.exam_start_up"))
  UserGuideItem(routeName: RouteHelper.getExamResultRoute(), title: 'exam_result'.tr,
      description: 'Navigate to ${"exam_result".tr} to view and manage exam results.'),


  if(profileController.hasPermission("exam_module.mark_config"))
  UserGuideItem(routeName: RouteHelper.getMarkConfigRoute(), title: 'mark_config'.tr,
      description: 'Navigate to ${"mark_config".tr} to configure marking schemes for exams.'),


  if(profileController.hasPermission("exam_module.remarks_config"))
  UserGuideItem(routeName: RouteHelper.getRemarkConfigRoute(), title: 'remarks_config'.tr,
      description: 'Navigate to ${"remarks_config".tr} to configure remarks for exam results.'),


  if(profileController.hasPermission("exam_module.mark_input"))
  UserGuideItem(routeName: RouteHelper.getMarkInputRoute(), title: 'mark_input'.tr,
      description: 'Navigate to ${"mark_input".tr} to input marks for students in exams.'),

  if(profileController.hasPermission("exam_module.exam_result"))
  UserGuideItem(routeName: RouteHelper.getExamResultRoute(), title: 'exam_result'.tr,
      description: 'Navigate to ${"exam_result".tr} to view and manage exam results.'),


  if(profileController.hasPermission("student_information.student_migration"))
  UserGuideItem(routeName: RouteHelper.getCertificateRoute(CertificateTypeEnum.recommendation), title: 'general_recommendation_letter'.tr,
      description: 'Navigate to ${"general_recommendation_letter".tr} to handle recommendation letter.'),

  if(profileController.hasPermission("student_information.student_migration"))
  UserGuideItem(routeName: RouteHelper.getCertificateRoute(CertificateTypeEnum.testimonial), title: 'testimonial'.tr,
      description: 'Navigate to ${"testimonial".tr} to handle testimonial.'),

  if(profileController.hasPermission("student_information.student_migration"))
  UserGuideItem(routeName: RouteHelper.getCertificateRoute(CertificateTypeEnum.attendanceCertificate), title: 'attendance_certificate'.tr,
      description: 'Navigate to ${"attendance_certificate".tr} to handle attendance certificate.'),

  if(profileController.hasPermission("student_information.student_migration"))
  UserGuideItem(routeName: RouteHelper.getCertificateRoute(CertificateTypeEnum.hscRecommendationLetter), title: 'hsc_recommendation_letter'.tr,
      description: 'Navigate to ${"hsc_recommendation_letter".tr} to handle hsc recommendation letter.'),

  if(profileController.hasPermission("student_information.student_migration"))
  UserGuideItem(routeName: RouteHelper.getCertificateRoute(CertificateTypeEnum.abroadLetter), title: 'abroad_letter'.tr,
      description: 'Navigate to ${"abroad_letter".tr} to handle abroad letter.'),


  if(profileController.hasPermission("sms_notifications.templates"))
  UserGuideItem(routeName: RouteHelper.getSmsTemplateRoute(), title: 'sms_template'.tr,
      description: 'Navigate to ${"sms_template".tr} to manage SMS templates for notifications.'),

  if(profileController.hasPermission("sms_notifications.phonebook_category"))
  UserGuideItem(routeName: RouteHelper.getPhoneBookCategoryRoute(), title: 'phonebook_category'.tr,
      description: 'Navigate to ${"phonebook_category".tr} to manage phonebook categories for SMS notifications.'),

  if(profileController.hasPermission("sms_notifications.phonebook"))
  UserGuideItem(routeName: RouteHelper.getPhoneBookRoute(), title: 'phonebook'.tr,
      description: 'Navigate to ${"phonebook".tr} to manage phonebook entries for SMS notifications.'),

  if(profileController.hasPermission("sms_notifications.sms_sent"))
  UserGuideItem(routeName: RouteHelper.getSmsSentRoute(), title: 'sms_sent'.tr,
      description: 'Navigate to ${"sms_sent".tr} to view sent SMS notifications.'),

  if(profileController.hasPermission("sms_notifications.purchase_sms"))
  UserGuideItem(routeName: RouteHelper.getPurchaseSmsRoute(), title: 'purchase_sms'.tr,
      description: 'Navigate to ${"purchase_sms".tr} to manage purchased SMS credits for notifications.'),

  if(profileController.hasPermission("sms_notifications.sms_report"))
  UserGuideItem(routeName: RouteHelper.getSmsReportRoute(), title: 'sms_report'.tr,
      description: 'Navigate to ${"sms_report".tr} to view SMS notification reports.'),


  if(profileController.hasPermission("administrator.notice"))
  UserGuideItem(routeName: RouteHelper.getNoticeRoute(), title: 'notice'.tr,
      description: 'Navigate to ${"notice".tr} to manage and view notices for the institute.'),

  if(profileController.hasPermission("administrator.event"))
  UserGuideItem(routeName: RouteHelper.getEventRoute(), title: 'event'.tr,
      description: 'Navigate to ${"event".tr} to manage and view events for the institute.'),

  if(profileController.hasPermission("administrator.user_activities"))
  UserGuideItem(routeName: RouteHelper.getUserActivitiesRoute(), title: 'user_activities'.tr,
      description: 'Navigate to ${"user_activities".tr} to view user activities and logs.'),

  if(profileController.hasPermission("quiz.topics"))
  UserGuideItem(routeName: RouteHelper.getQuizTopicRoute(), title: 'quiz_topic'.tr,
      description: 'Navigate to ${"quiz_topic".tr} to manage quiz topics and categories.'),

  if(profileController.hasPermission("quiz.questions"))
  UserGuideItem(routeName: RouteHelper.getQuestionTopicRoute(), title: 'quiz_question'.tr,
      description: 'Navigate to ${"quiz_question".tr} to manage quiz questions and options.'),

  if(profileController.hasPermission("quiz.answers"))
  UserGuideItem(routeName: RouteHelper.getAnswerRoute(), title: 'quiz_answer'.tr,
      description: 'Navigate to ${"quiz_answer".tr} to manage quiz answers and results.'),

  if(profileController.hasPermission("quiz.results"))
  UserGuideItem(routeName: RouteHelper.getQuizResultRoute(), title: 'quiz_result'.tr,
      description: 'Navigate to ${"quiz_result".tr} to view and manage quiz results.'),

  if(profileController.hasPermission("master_configuration.branches"))
  UserGuideItem(routeName: RouteHelper.getSystemSettingsRoute(), title: 'system_settings'.tr,
      description: 'Navigate to ${"system_settings".tr} to manage settings.'),


  if(profileController.hasPermission("zoom-index"))
  UserGuideItem(routeName: RouteHelper.getZoomMeetingRoute(), title: 'zoom_meeting'.tr,
      description: 'Navigate to ${"zoom_meeting".tr} to manage Zoom meetings and classes.'),


  if(profileController.hasPermission("master_configuration.branches"))
  UserGuideItem(routeName: RouteHelper.getInstituteRoute(), title: 'about_us'.tr,
      description: 'Navigate to ${"about_us".tr} to manage about the institute.'),

  if(profileController.hasPermission("master_configuration.branches"))
  UserGuideItem(routeName: RouteHelper.getPendingInstituteRoute(), title: 'banner'.tr,
      description: 'Navigate to ${"banner".tr} to manage banner.'),

  if(profileController.hasPermission("master_configuration.branches"))
  UserGuideItem(routeName: RouteHelper.getApplyInstituteRoute(), title: 'faq'.tr,
      description: 'Navigate to ${"faq".tr} to manage faq.'),




  UserGuideItem(routeName: RouteHelper.getProfileRoute(), title: 'profile'.tr,
      description: 'Navigate to ${"profile".tr} to view and edit your profile information.'),

    UserGuideItem(routeName: RouteHelper.getNotificationRoute(), title: 'notification'.tr,
        description: 'Navigate to ${"notification".tr} to view system notifications.'),


  ];

