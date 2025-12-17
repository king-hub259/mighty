import 'package:flutter/services.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:intl/intl.dart';
import 'package:mighty_school/localization/language_model.dart';
import 'package:mighty_school/util/images.dart';
import 'package:url_launcher/url_launcher.dart';

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}
class AppConstants {
  static const bool demo = false;
  static const String appName = 'Mighty School';
  static const String slogan = 'Empowering Schools. Empowering Futures.';
  static const String instituteDomain = 'institute1.com';
  static const String version = '3.1';   /// Flutter SDK 3.35.2
  static const int versionCode = 3;
  static const String currency = "USD";
  static const String chatGptApiKey = 'your ApiKey';
  static const String baseUrl = 'https://dev-api.codenichebd.com';
  static const String imageBaseUrl = '$baseUrl/public/storage';
  static const String loginUri = '/api/login';
  static const String branches = '/api/branches';
  static const String institutes = '/api/institutes';
  static const String changeBranches = '/api/administration-change-branch';
  static const String changeSession = '/api/administration-change-year';
  static const String generalSetting = '/api/administration/general_settings';
  static const String publicSetting = '/api/frontend/settings';
  static const String uploadLogo = '/api/administration-upload-logo';
  static const String classList = '/api/get-classes';
  static const String classApi = '/api/class';
  static const String section = '/api/sections';
  static const String classWiseSection = '/api/get-section';
  static const String group = '/api/groups';
  static const String periods = '/api/periods';
  static const String getSubjectList = '/api/get-subject';
  static const String subjects = '/api/subjects';
  static const String student = '/api/students';
  static const String getStudentForMigration = '/api/students-get_students-migration';
  static const String geMigrationList = '/api/migrated-list';
  static const String studentMigration = '/api/student-migration';


  static const String teacher = '/api/teachers';
  static const String getTeacherList = '/api/get-teachers';
  static const String staff = '/api/staffs';
  static const String typeWiseUserList = '/api/sms-get-users?user_type=';
  static const String studentAttendance = '/api/student-attendance';
  static const String staffAttendance = '/api/staffs-attendance';
  static const String getLibraryMember = '/api/get-library-members';
  static const String books = '/api/books';
  static const String bookCategories = '/api/book-categories';
  static const String bookIssue = '/api/books-issue';
  static const String bookReturn = '/api/books-return';
  static const String bookIssueReport = '/api/books-issue-reports';

  //fine

  static const String quickCollection = '/api/quick-collection';
  static const String attendanceFine = '/api/get-attendance-fine-amount/';
  static const String quizFine = '/api/get-quiz-fine-amount/';
  static const String labFine = '/api/get-lab-fine-amount/';
  static const String tcAmount = '/api/get-tc-amount';
  static const String paidReport = '/api/paid-reports';
  static const String subHeadWiseCalculation = '/api/student-collection-sub-head-wise-calculation';
  static const String unPaidReport = '/api/unpaid-reports';
  static const String feesHead = '/api/fee-head';
  static const String deleteFeesHead = '/api/fee-head-delete/';
  static const String feesSubHead = '/api/fee-sub-head';
  static const String feesSubHeadDelete = '/api/fee-sub-head-delete/';
  static const String waiver = '/api/waivers';
  static const String waiverDelete = '/api/waiver-delete/';
  static const String feesMapping = '/api/fees-mapping';
  static const String fees = '/api/fees';
  static const String absentFine = '/api/absent-fines';
  static const String feesDate = '/api/fee-date-config';
  static const String smartCollection = '/api/quick-collection';


  static const String assignment = '/api/assignments';
  static const String syllabus = '/api/syllabus';
  static const String picklists = '/api/picklists';
  static const String signature = '/api/signatures';
  static const String sessions = '/api/sessions';
  static const String notices = '/api/notices';
  static const String events = '/api/events';
  static const String studentCategories = '/api/student-categories';
  static const String accountingFund = '/api/accounting-funds';
  static const String accountingCategory = '/api/accounting-categories';
  static const String accountingGroups = '/api/accounting-groups';
  static const String accountingLedger = '/api/accounting-ledgers';
  static const String payment = '/api/account-transactions';
  static const String ledgerBalance = '/api/ledger-account-balance?ledger_id=';
  static const String chartOfAccount = '/api/chart-of-accounts';
  static const String dashboardData = '/api/dashboard-data';
  static const String yearWiseCashFlow = '/api/report/cash-flow-statement?year=';
  static const String attendanceSummery = '/api/student-attendance-summery';
  static const String monthlyFeeCollectionSummery = '/api/report/get-monthly-fee-collections';

  static const String smsTemplate = '/api/sms-template';
  static const String phoneBookCategory = '/api/phone-book-category';
  static const String phoneBook = '/api/phone-book';
  static const String smsPurchase = '/api/sms-purchase';
  static const String topics = '/api/topics';
  static const String questions = '/api/questions';
  static const String answers = '/api/answers';
  static const String quizResult = '/api/all-reports';
  static const String examShortCode = '/api/short-code';
  static const String examGrades = '/api/grades';
  static const String exam = '/api/exams';
  static const String meritProcessType = '/api/merit-process-type';
  static const String examCodeStore = '/api/exam-code-store';
  static const String examGradeStore = '/api/exam-grade-store';
  static const String examAssignStore = '/api/exam-assign-store';
  //mark config
  static const String getGeneralExamList = '/api/semester-exam-settings-mark-config';
  static const String storeGeneralExam = '/api/general-exam-store';
  static const String getMarkInput = '/api/mark-input-section-wise-class/';
  static const String sectionWiseMarkInput = '/api/mark-store-section-wise';
  static const String storeGrandFinalExam = '/api/grand-final-exam-store';
  static const String markConfigView = '/api/semester-exam-settings-mark-config';
  static const String examResult = '/api/exam-results';
  static const String examRoutine = '/api/exam-routines';
  static const String examEssentials = '/api/exam-essentials';
  static const String classRoutine = '/api/class-routines';
  static const String examRoutineStore = '/api/exam-routines-store';
  static const String remarkConfig = '/api/remarks-config';


  static const String profile = '/api/profile';
  static const String config = '/api/initial-data';
  static const String department = '/api/departments';
  static const String shift = '/api/shifts';
  static const String employee = '/api/users';
  static const String allStudent = '/api/at-a-glance';
  static const String attendance = '/api/student-attendance';
  static const String role = '/api/roles';
  static const String permissionList = '/api/permissions';
  static const String updateProfile = '/api/profile-update';
  static const String changePassword = '/api/change-password';
  static const String payroll = '/api/payrolls';
  static const String leaveType = '/api/leave-types';
  static const String leaveRequest = '/api/leave-requests';
  static const String zooms = '/api/zooms';
  static const String userLogs = '/api/user-logs';
  static const String applyInstitute = '/api/frontend/onboarding';
  static const String onboardingsList = '/api/onboardings-list';
  static const String onboardingsApprove = '/api/onboardings-approve';
  static const String plans = '/api/plans';
  static const String subscriptionPlanUpdate = '/api/subscription/payment-upgrade';
  static const String saasDashboardReport = '/api/saas-dashboard-data';




  //cms Controll
  static const String banner = '/api/banners';
  static const String readyToJoin = '/api/ready-to-join-us';
  static const String whyChooseUs = '/api/why-choose-us';
  static const String aboutUs = '/api/about-us';
  static const String mobileAppSection = '/api/mobile-app-sections';
  static const String faqs = '/api/faqs';
  static const String feedback = '/api/testimonials';
  static const String academicImages = '/api/academic-images';
  static const String policies = '/api/policies';



  //saas cms controll
  static const String saasFaqs = '/api/saas-faqs';

  //saas payment
  static const String saasPayment = '/api/saas-digital-payment';
  static const String makePayment = '/api/digital-payment';


  //saas public
  static const String publicSaasFaqs = '/api/get-saas-faqs';
  static const String subscriptionPackageList = '/api/get-packages';


  // layout & certificate
  static const String layoutAndCertificate = '/api/layout-certificates';
  static const String bulkStudentImportSampleFileDownload = '/api/students-bulk-imports-download-file';
  static const String bulkStudentImport = '/api/students-bulk-imports';
  static const String idCard = '/student-list-for-card-print';
  static const String teacherIdCard = '/teacher-list-for-card-print';
  static const String staffIdCard = '/staff-list-for-card-print';
  static const String resultCard = '/student-vital';


  
  //Reports
  //------------------------Fees--------------------------
  static const String monthlyReport = '/api/monthly-paid-info';
  static const String paymentFeesInfo = '/api/payment-fee-info';
  static const String headWisePayment = '/api/head-wise-payment';
  static const String headWiseDue = '/api/head-wise-due';
  static const String classWisePaymentSummary = '/api/class-wise-payment-summary';
  static const String unpaidInfo = '/api/unpaid-info';
  static const String paymentRatioInfo = '/api/payment-ratio-info';
  static const String unpaidSummery = '/api/unpaid-summery';
  static const String paidInvoice = '/api/paid-invoice';
  
  //------------------------Accounting--------------------------
  static const String balanceSheet = '/api/report/balance-sheet';
  static const String trialBalance = '/api/report/trial-balance';
  static const String incomeStatement = '/api/report/income-statement';
  static const String cashFlowStatement = '/api/report/cash-flow-statement';
  static const String cashFlowDetails = '/api/report/cash-flow-details';
  static const String voucherWise = '/api/report/voucher-wise';
  static const String journalWise = '/api/report/journal-wise';
  static const String userWise = '/api/report/user-wise';
  static const String ledgerWise = '/api/report/ledger-wise';
  static const String fundWise = '/api/report/fund-wise';
  static const String fundSummary = '/api/report/fund-summary';
  static const String fundSummaryMonthly = '/api/report/fund-summary-monthly';

 
  //------------------------Payroll--------------------------
  static const String salaryHead = '/api/salary-heads';
  static const String payrollMapping = '/api/payroll-mapping';
  static const String payrollAssign = '/api/payroll-assign';
  static const String salarySlip = '/api/salary-create';
  static const String salaryCreate = '/api/salary-create-store';
  static const String salaryProcess = '/api/salary-payment-process';
  static const String dueSalaryPayment = '/api/due-salary-payment';
  static const String advanceSalaryPayment = '/api/advance-salary-payment';
  static const String returnSalaryPayment = '/api/return-salary-payment';
  static const String salaryStatement = '/api/salary-statement';
  static const String paymentInfo = '/api/payment-info';


  //------------------------Language--------------------------
  static const String languageList = '/api/languages';






  //Parents Module
  static const String parentProfile = '/api/parent/my-profile';
  static const String parentDashboardData = '/api/parent/my-children/dashboard-data';
  static const String parentClassRoutine = '/api/parent/my-children/class-routine';
  static const String children = '/api/parent/my-children/list';
  static const String parentGetSubjectList = '/api/student/my-subjects';
  static const String parentSyllabus = '/api/student/my-syllabus';
  static const String quiz = '/api/student/quiz';
  static const String setDefaultChildren = '/api/parent/my-children/default-child-assign';
  static const String myChildrenProfile = '/api/parent/my-children/profile';
  static const String childrenAttendance = '/api/parent/my-children/attendance';
  static const String childrenSubjects = '/api/parent/my-children/subjects';
  static const String childrenExamRoutine = '/api/parent/my-children/exam-routine';
  static const String libraryHistory = '/api/parent/my-children/library-history';
  static const String childrenAssignment = '/api/parent/my-children/assignment';
  static const String submittedAssignmentList = '/api/parent/my-children/assignment-submit';
  static const String childrenAttendanceFine = '/api/parent/my-children/attendance-fine-report';
  static const String childrenPaidReport = '/api/parent/my-children/payment-fee-info';
  static const String childrenUnpaidReport = '/api/parent/my-children/unpaid-info';
  static const String childrenStudentNotices = '/api/parent/my-children/notices';
  static const String childrenStudentEvents = '/api/parent/my-children/events';
  static const String childrenBehaviors = '/api/parent/my-children/behaviors';
  static const String childrenGamifications = '/api/parent/my-children/gamifications';
  static const String childrenPrayer = '/api/parent/my-children/prayers';
  static const String childrenExamResults = '/api/parent/my-children/exam-results';
  static const String parentExam = '/api/parent/my-children/exam-list';




//Hostel Module

 static const String hostels = '/api/hostels';
 static const String hostelCategory = '/api/hostel-categories';
 static const String hostelMembers = '/api/hostel-members';
 static const String hostelRooms = '/api/rooms';
 static const String hostelRoomMembers = '/api/room-members';
 static const String hostelMeals = '/api/meals';
 static const String hostelMealPlan = '/api/meal-plans';
 static const String hostelMealEntries = '/api/meal-entries';
 static const String hostelBills = '/api/hostel-bills';


 //Transportation Module
 static const String transportBuses = '/api/buses';
 static const String transportDriver = '/api/drivers';
 static const String transportBusRoutes = '/api/bus-routes';
 static const String transportBusStops = '/api/bus-stops';
 static const String transportMembers = '/api/transport-members';



 // Student Module
  static const String studentProfile = '/api/student/my-profile';
  static const String studentClassRoutine = '/api/student/class-routine';
  static const String studentSubjectList = '/api/student/my-subjects';
  static const String studentLibrary = '/api/student/library-history';
  static const String studentAssignment = '/api/student/my-assignment';
  static const String studentAssignmentDetails = '/api/student/view-assignment/';
  static const String studentBooks = '/api/books';
  static const String studentSyllabus = '/api/student/my-syllabus';
  static const String studentNotices = '/api/notices';
  static const String studentQuiz = '/api/student/quiz';
  static const String studentAttendanceFine = '/api/student/attendance-fine-report';
  static const String studentPaidReport = '/api/student/payment-fee-info';
  static const String studentUnPaidReport = '/api/student/unpaid-info';
  static const String studentEvent = '/api/student/events';
  static const String studentQuizFineReport = '/api/student/quiz-fine-report';
  static const String studentLabFineReport = '/api/student/lab-fine-report';
  static const String studentBehaviour = '/api/student/behaviors';




  // Shared Key
  static const String theme = 'theme';
  static const String token = 'token';
  static const String deviceToken = 'deviceToken';
  static const String countryCode = 'country_code';
  static const String languageCode = 'language_code';
  static const String cartList = 'cart_list';
  static const String userPassword = 'user_password';
  static const String userAddress = 'user_address';
  static const String userNumber = 'user_number';
  static const String searchAddress = 'search_address';
  static const String localization = 'X-Localization';
  static const String topic = 'notify';
  static const String userType = 'parent';
  static const String parent = 'Parent';
  static const String studentType = 'Student';
  static const String superAdmin = 'Super Admin';
  static const String sassAdmin = 'SAAS Admin';
  static const String studentPanel = 'student_panel';
  static const String skipOnboard = 'skip-onboard';
  static const String demoModeMessage = 'This Feature is restricted in demo mode.';

  static List<LanguageModel> languages = [
    LanguageModel(imageUrl: Images.unitedKingdom, languageName: 'English', countryCode: 'US', languageCode: 'en'),
    LanguageModel(imageUrl: Images.bangladesh, languageName: 'Bengali', countryCode: 'BD', languageCode: 'bn'),
    LanguageModel(imageUrl: Images.india, languageName: 'Hindi', countryCode: 'IN', languageCode: 'hi'),
    LanguageModel(imageUrl: Images.france, languageName: 'France', countryCode: 'FR', languageCode: 'fr'),
    LanguageModel(imageUrl: Images.spain, languageName: 'Spanish', countryCode: 'SP', languageCode: 'sp'),
    LanguageModel(imageUrl: Images.italy, languageName: 'Italian', countryCode: 'IT', languageCode: 'it'),
    LanguageModel(imageUrl: Images.saudi, languageName: 'Arabic', countryCode: 'SA', languageCode: 'ar'),
  ];

  static const int limitOfPickedIdentityImageNumber = 2;
  static const double limitOfPickedImageSizeInMB = 2;
  static const double completionArea = 500;
  static const String whatsAppNumber = "+8801723112233";

  static final phoneNumberFormat = FilteringTextInputFormatter.digitsOnly;
  static final numberFormat = FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*$'));

  static Future<void> onOpen(LinkableElement link) async {
    if (!await launchUrl(Uri.parse(link.url))) {
      throw 'Could not launch ${link.url}';
    }
  }

  static Future<void> openUrl(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw 'Could not launch $url';
    }
  }

  static final currentDate = DateFormat('dd/MM/yyyy').format(DateTime.now());


}
