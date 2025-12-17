import 'package:mighty_school/helper/price_converter.dart';

class DashboardReportModel {
  bool? status;
  String? message;
  Data? data;

  DashboardReportModel({this.status, this.message, this.data});

  DashboardReportModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  FeesAwaitingPayment? feesAwaitingPayment;
  FeesAwaitingPayment? convertedLeads;
  StaffPresentToday? staffPresentToday;
  StaffPresentToday? studentPresentToday;
  FeesOverview? feesOverview;
  EnquiryOverview? enquiryOverview;
  LibraryOverview? libraryOverview;
  StudentTodayPresent? studentTodayPresent;
  StudentInfo? studentInfo;
  double? todayIncome;
  double? todayExpense;
  double? monthlyIncome;
  double? monthlyExpense;
  int? todayStudentPresentCount;
  int? todayStudentAbsentCount;
  int? todayStaffPresentCount;
  int? todayStaffAbsentCount;
  int? admins;
  int? staffs;
  int? teachers;
  int? students;

  Data(
      {this.feesAwaitingPayment,
        this.convertedLeads,
        this.staffPresentToday,
        this.studentPresentToday,
        this.feesOverview,
        this.enquiryOverview,
        this.libraryOverview,
        this.studentTodayPresent,
        this.studentInfo,
        this.todayIncome,
        this.todayExpense,
        this.monthlyIncome,
        this.monthlyExpense,
        this.todayStudentPresentCount,
        this.todayStudentAbsentCount,
        this.todayStaffPresentCount,
        this.todayStaffAbsentCount,
        this.admins,
        this.staffs,
        this.teachers,
        this.students});

  Data.fromJson(Map<String, dynamic> json) {
    feesAwaitingPayment = json['fees_awaiting_payment'] != null
        ? FeesAwaitingPayment.fromJson(json['fees_awaiting_payment'])
        : null;
    convertedLeads = json['converted_leads'] != null
        ? FeesAwaitingPayment.fromJson(json['converted_leads'])
        : null;
    staffPresentToday = json['staff_present_today'] != null
        ? StaffPresentToday.fromJson(json['staff_present_today'])
        : null;
    studentPresentToday = json['student_present_today'] != null
        ? StaffPresentToday.fromJson(json['student_present_today'])
        : null;
    feesOverview = json['fees_overview'] != null
        ? FeesOverview.fromJson(json['fees_overview'])
        : null;
    enquiryOverview = json['enquiry_overview'] != null
        ? EnquiryOverview.fromJson(json['enquiry_overview'])
        : null;
    libraryOverview = json['library_overview'] != null
        ? LibraryOverview.fromJson(json['library_overview'])
        : null;
    studentTodayPresent = json['student_today_present'] != null
        ? StudentTodayPresent.fromJson(json['student_today_present'])
        : null;
    studentInfo = json['student_info'] != null
        ? StudentInfo.fromJson(json['student_info'])
        : null;
    todayIncome = PriceConverter.parseAmount(json['today_income']);
    todayExpense = PriceConverter.parseAmount(json['today_expense']);
    monthlyIncome = PriceConverter.parseAmount(json['monthly_income']);
    monthlyExpense = PriceConverter.parseAmount(json['monthly_expense']);
    todayStudentPresentCount = json['today_student_present_count'];
    todayStudentAbsentCount = json['today_student_absent_count'];
    todayStaffPresentCount = json['today_staff_present_count'];
    todayStaffAbsentCount = json['today_staff_absent_count'];
    admins = json['admins'];
    staffs = json['staffs'];
    teachers = json['teachers'];
    students = json['students'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (feesAwaitingPayment != null) {
      data['fees_awaiting_payment'] = feesAwaitingPayment!.toJson();
    }
    if (convertedLeads != null) {
      data['converted_leads'] = convertedLeads!.toJson();
    }
    if (staffPresentToday != null) {
      data['staff_present_today'] = staffPresentToday!.toJson();
    }
    if (studentPresentToday != null) {
      data['student_present_today'] = studentPresentToday!.toJson();
    }
    if (feesOverview != null) {
      data['fees_overview'] = feesOverview!.toJson();
    }
    if (enquiryOverview != null) {
      data['enquiry_overview'] = enquiryOverview!.toJson();
    }
    if (libraryOverview != null) {
      data['library_overview'] = libraryOverview!.toJson();
    }
    if (studentTodayPresent != null) {
      data['student_today_present'] = studentTodayPresent!.toJson();
    }
    if (studentInfo != null) {
      data['student_info'] = studentInfo!.toJson();
    }
    data['today_income'] = todayIncome;
    data['today_expense'] = todayExpense;
    data['monthly_income'] = monthlyIncome;
    data['monthly_expense'] = monthlyExpense;
    data['today_student_present_count'] = todayStudentPresentCount;
    data['today_student_absent_count'] = todayStudentAbsentCount;
    data['today_staff_present_count'] = todayStaffPresentCount;
    data['today_staff_absent_count'] = todayStaffAbsentCount;
    data['admins'] = admins;
    data['staffs'] = staffs;
    data['teachers'] = teachers;
    data['students'] = students;
    return data;
  }
}

class FeesAwaitingPayment {
  int? total;
  int? waiting;

  FeesAwaitingPayment({this.total, this.waiting});

  FeesAwaitingPayment.fromJson(Map<String, dynamic> json) {
    total = json['total'];
    waiting = json['waiting'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total'] = total;
    data['waiting'] = waiting;
    return data;
  }
}

class StaffPresentToday {
  int? attendanceCount;
  int? presentCount;

  StaffPresentToday({this.attendanceCount, this.presentCount});

  StaffPresentToday.fromJson(Map<String, dynamic> json) {
    attendanceCount = json['attendance_count'];
    presentCount = json['present_count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['attendance_count'] = attendanceCount;
    data['present_count'] = presentCount;
    return data;
  }
}

class FeesOverview {
  double? unpaid;
  double? partial;
  double? paid;

  FeesOverview({this.unpaid, this.partial, this.paid});

  FeesOverview.fromJson(Map<String, dynamic> json) {
    unpaid = PriceConverter.parseAmount(json['unpaid']);
    partial = PriceConverter.parseAmount(json['partial']);
    paid = PriceConverter.parseAmount(json['paid']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['unpaid'] = unpaid;
    data['partial'] = partial;
    data['paid'] = paid;
    return data;
  }
}

class EnquiryOverview {
  int? activeStudent;
  int? ownStudent;
  int? passive;
  int? lost;
  int? dead;

  EnquiryOverview(
      {this.activeStudent,
        this.ownStudent,
        this.passive,
        this.lost,
        this.dead});

  EnquiryOverview.fromJson(Map<String, dynamic> json) {
    activeStudent = json['active_student'];
    ownStudent = json['own_student'];
    passive = json['passive'];
    lost = json['lost'];
    dead = json['dead'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['active_student'] = activeStudent;
    data['own_student'] = ownStudent;
    data['passive'] = passive;
    data['lost'] = lost;
    data['dead'] = dead;
    return data;
  }
}

class LibraryOverview {
  int? dueForReturn;
  int? returned;
  int? issuedOutOf;
  int? availableForOut;
  int? books;

  LibraryOverview(
      {this.dueForReturn,
        this.returned,
        this.issuedOutOf,
        this.availableForOut,
        this.books});

  LibraryOverview.fromJson(Map<String, dynamic> json) {
    dueForReturn = json['due_for_return'];
    returned = json['returned'];
    issuedOutOf = json['issued_out_of'];
    availableForOut = json['available_for_out'];
    books = json['books'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['due_for_return'] = dueForReturn;
    data['returned'] = returned;
    data['issued_out_of'] = issuedOutOf;
    data['available_for_out'] = availableForOut;
    data['books'] = books;
    return data;
  }
}

class StudentTodayPresent {
  double? present;
  double? presentPercentage;
  double? absent;
  double? absentPercentage;

  StudentTodayPresent(
      {this.present,
        this.presentPercentage,
        this.absent,
        this.absentPercentage});

  StudentTodayPresent.fromJson(Map<String, dynamic> json) {
    present = PriceConverter.parseAmount(json['present']);
    presentPercentage = PriceConverter.parseAmount(json['present_percentage']);
    absent = PriceConverter.parseAmount(json['absent']);
    absentPercentage = PriceConverter.parseAmount(json['absent_percentage']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['present'] = present;
    data['present_percentage'] = presentPercentage;
    data['absent'] = absent;
    data['absent_percentage'] = absentPercentage;
    return data;
  }
}

class StudentInfo {
  int? totalStudents;
  int? totalMaleStudents;
  double? malePercentage;
  int? totalFemaleStudents;
  double? femalePercentage;

  StudentInfo(
      {this.totalStudents,
        this.totalMaleStudents,
        this.malePercentage,
        this.totalFemaleStudents,
        this.femalePercentage});

  StudentInfo.fromJson(Map<String, dynamic> json) {
    totalStudents = json['total_students'];
    totalMaleStudents = json['total_male_students'];
    malePercentage = PriceConverter.parseAmount(json['male_percentage']);
    totalFemaleStudents = json['total_female_students'];
    femalePercentage = PriceConverter.parseAmount(json['female_percentage']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total_students'] = totalStudents;
    data['total_male_students'] = totalMaleStudents;
    data['male_percentage'] = malePercentage;
    data['total_female_students'] = totalFemaleStudents;
    data['female_percentage'] = femalePercentage;
    return data;
  }
}
