import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:mighty_school/feature/branch/controller/branch_controller.dart';
import 'package:mighty_school/feature/branch/domain/repository/branch_repository.dart';
import 'package:mighty_school/feature/account_management/chart_of_account/domain/repository/chart_of_account_repository.dart';
import 'package:mighty_school/feature/account_management/chart_of_account/logic/chart_of_account_controller.dart';
import 'package:mighty_school/feature/administrator/system_settings/controller/system_settngs_controller.dart';
import 'package:mighty_school/feature/administrator/system_settings/domain/repository/system_settings_repository.dart';
import 'package:mighty_school/feature/chatgpt/logic/chat_gpt_controller.dart';
import 'package:mighty_school/feature/cms_management/about_us/domain/repository/about_us_repository.dart';
import 'package:mighty_school/feature/cms_management/about_us/logic/about_us_controller.dart';
import 'package:mighty_school/feature/cms_management/academic_image/domain/repository/academic_image_repository.dart';
import 'package:mighty_school/feature/cms_management/academic_image/logic/academic_image_controller.dart';
import 'package:mighty_school/feature/cms_management/banner/domain/repository/banner_repository.dart';
import 'package:mighty_school/feature/cms_management/banner/logic/banner_controller.dart';
import 'package:mighty_school/feature/cms_management/faq/domain/repository/faq_repository.dart';
import 'package:mighty_school/feature/cms_management/faq/logic/faq_controller.dart';
import 'package:mighty_school/feature/cms_management/feedback/domain/repository/feedback_repository.dart';
import 'package:mighty_school/feature/cms_management/feedback/logic/feedback_controller.dart';
import 'package:mighty_school/feature/cms_management/mobile_app_section/domain/repository/mobile_app_repository.dart';
import 'package:mighty_school/feature/cms_management/mobile_app_section/logic/mobile_app_controller.dart';
import 'package:mighty_school/feature/cms_management/policy_pages/domain/repository/policy_pages_repository.dart';
import 'package:mighty_school/feature/cms_management/policy_pages/logic/pages_controller.dart';
import 'package:mighty_school/feature/cms_management/ready_to_join_us/domain/repository/ready_to_join_repository.dart';
import 'package:mighty_school/feature/cms_management/ready_to_join_us/logic/ready_to_join_controller.dart';
import 'package:mighty_school/feature/cms_management/why_choose_us/domain/repository/why_choose_us_repository.dart';
import 'package:mighty_school/feature/cms_management/why_choose_us/logic/why_choose_us_controller.dart';
import 'package:mighty_school/feature/digital_payment/domain/repository/digital_payment_repository.dart';
import 'package:mighty_school/feature/digital_payment/logic/digital_payment_controller.dart';
import 'package:mighty_school/feature/exam_management/exam/controller/exam_controller.dart';
import 'package:mighty_school/feature/exam_management/exam/domain/repository/exam_repository.dart';
import 'package:mighty_school/feature/exam_management/exam_result/controller/exam_result_controller.dart';
import 'package:mighty_school/feature/exam_management/exam_result/domain/repository/exam_result_repository.dart';
import 'package:mighty_school/feature/exam_management/mark_config/controller/mark_config_controller.dart';
import 'package:mighty_school/feature/exam_management/mark_config/domain/repository/mark_config_repository.dart';
import 'package:mighty_school/feature/exam_management/mark_input/controller/mark_input_controller.dart';
import 'package:mighty_school/feature/exam_management/mark_input/domain/repository/mark_input_repository.dart';
import 'package:mighty_school/feature/exam_management/remark_config/controller/re_mark_config_controller.dart';
import 'package:mighty_school/feature/exam_management/remark_config/domain/repository/remark_config_repository.dart';
import 'package:mighty_school/feature/hostel_management/hostel/domain/repository/hostel_repository.dart';
import 'package:mighty_school/feature/hostel_management/hostel/logic/hostel_controller.dart';
import 'package:mighty_school/feature/hostel_management/hostel_bill/domain/repository/hostel_bill_repository.dart';
import 'package:mighty_school/feature/hostel_management/hostel_bill/logic/hostel_bill_controller.dart';
import 'package:mighty_school/feature/hostel_management/hostel_categories/domain/repository/hostel_categories_repository.dart';
import 'package:mighty_school/feature/hostel_management/hostel_categories/logic/hostel_categories_controller.dart';
import 'package:mighty_school/feature/hostel_management/hostel_meal_entries/domain/repository/hostel_meal_entries_repository.dart';
import 'package:mighty_school/feature/hostel_management/hostel_meal_entries/logic/hostel_meal_entries_controller.dart';
import 'package:mighty_school/feature/hostel_management/hostel_meal_plan/domain/repository/hostel_meal_plan_repository.dart';
import 'package:mighty_school/feature/hostel_management/hostel_meal_plan/logic/hostel_meal_plan_controller.dart';
import 'package:mighty_school/feature/hostel_management/hostel_meals/domain/repository/hostel_meals_repository.dart';
import 'package:mighty_school/feature/hostel_management/hostel_meals/logic/hostel_meals_controller.dart';
import 'package:mighty_school/feature/hostel_management/hostel_members/domain/repository/hostel_members_repository.dart';
import 'package:mighty_school/feature/hostel_management/hostel_members/logic/hostel_members_controller.dart';
import 'package:mighty_school/feature/hostel_management/hostel_room_member/domain/repository/hostel_room_member_repository.dart';
import 'package:mighty_school/feature/hostel_management/hostel_room_member/logic/hostel_room_member_controller.dart';
import 'package:mighty_school/feature/hostel_management/hostel_rooms/domain/repository/hostel_rooms_repository.dart';
import 'package:mighty_school/feature/hostel_management/hostel_rooms/logic/hostel_rooms_controller.dart';
import 'package:mighty_school/feature/id_card/logic/id_card_controller.dart';
import 'package:mighty_school/feature/institute/controller/institute_controller.dart';
import 'package:mighty_school/feature/institute/domain/repository/institute_repository.dart';
import 'package:mighty_school/feature/landing_page/domain/repositories/landing_page_repository.dart';
import 'package:mighty_school/feature/landing_page/logic/landing_page_controller.dart';
import 'package:mighty_school/feature/layout_and_certificate/domain/repository/layout_and_certificate_repository.dart';
import 'package:mighty_school/feature/layout_and_certificate/logic/layout_and_certificate_controller.dart';
import 'package:mighty_school/feature/library_management/library_member/controller/library_member_controller.dart';
import 'package:mighty_school/feature/library_management/library_member/domain/repository/library_member_repository.dart';
import 'package:mighty_school/feature/fees_management/paid_info/controller/paid_info_controller.dart';
import 'package:mighty_school/feature/fees_management/paid_info/domain/repository/paid_info_repository.dart';
import 'package:mighty_school/feature/package_plan/controller/package_controller.dart';
import 'package:mighty_school/feature/package_plan/domain/repository/package_repository.dart';
import 'package:mighty_school/feature/parent_module/children/controller/children_controller.dart';
import 'package:mighty_school/feature/parent_module/children/domain/repository/children_repository.dart';
import 'package:mighty_school/feature/parent_module/parent_assignment/controller/parent_assignment_controller.dart';
import 'package:mighty_school/feature/parent_module/parent_assignment/domain/repository/parent_assignment_repository.dart';
import 'package:mighty_school/feature/parent_module/parent_attendance/controller/parent_attendance_controller.dart';
import 'package:mighty_school/feature/parent_module/parent_attendance/domain/repository/parent_attendance_repository.dart';
import 'package:mighty_school/feature/parent_module/parent_class_routine/domain/repository/parent_class_routine_repository.dart';
import 'package:mighty_school/feature/parent_module/parent_class_routine/logic/parent_class_routine_controller.dart';
import 'package:mighty_school/feature/parent_module/parent_event/controller/parent_event_controller.dart';
import 'package:mighty_school/feature/parent_module/parent_event/domain/repository/parent_event_repository.dart';
import 'package:mighty_school/feature/parent_module/parent_exam/controller/parent_exam_controller.dart';
import 'package:mighty_school/feature/parent_module/parent_exam/domain/repository/parent_exam_repository.dart';
import 'package:mighty_school/feature/parent_module/parent_library/controller/parent_library_controller.dart';
import 'package:mighty_school/feature/parent_module/parent_library/domain/repository/parent_library_repository.dart';
import 'package:mighty_school/feature/parent_module/parent_notice/controller/parent_notice_controller.dart';
import 'package:mighty_school/feature/parent_module/parent_notice/domain/repository/parent_notice_repository.dart';
import 'package:mighty_school/feature/parent_module/parent_paid_info/controller/parent_paid_info_controller.dart';
import 'package:mighty_school/feature/parent_module/parent_paid_info/domain/repository/parent_paid_info_repository.dart';
import 'package:mighty_school/feature/parent_module/parent_profile/domain/repository/parent_profile_repository.dart';
import 'package:mighty_school/feature/parent_module/parent_profile/logic/parent_profile_controller.dart';
import 'package:mighty_school/feature/parent_module/parent_subject/controller/parent_subject_controller.dart';
import 'package:mighty_school/feature/parent_module/parent_subject/domain/repository/parent_subject_repository.dart';
import 'package:mighty_school/feature/parent_module/parent_syllabus/controller/parent_syllabus_controller.dart';
import 'package:mighty_school/feature/parent_module/parent_syllabus/domain/repository/parent_syllabus_repository.dart';
import 'package:mighty_school/feature/parent_module/parents/logic/menu_controller.dart';
import 'package:mighty_school/feature/payroll_management/advance/domain/repository/advance_repository.dart';
import 'package:mighty_school/feature/payroll_management/advance/logic/advance_controller.dart';
import 'package:mighty_school/feature/payroll_management/due/domain/repository/due_repository.dart';
import 'package:mighty_school/feature/payroll_management/due/logic/due_controller.dart';
import 'package:mighty_school/feature/payroll_management/payroll_assign/domain/repository/payroll_assign_repository.dart';
import 'package:mighty_school/feature/payroll_management/payroll_assign/logic/payroll_assign_controller.dart';
import 'package:mighty_school/feature/payroll_management/payroll_mapping/domain/repository/payroll_mapping_repository.dart';
import 'package:mighty_school/feature/payroll_management/payroll_mapping/logic/payroll_mapping_controller.dart';
import 'package:mighty_school/feature/payroll_management/payroll_start_up/domain/repository/payroll_start_up_repository.dart';
import 'package:mighty_school/feature/payroll_management/payroll_start_up/logic/payroll_start_up_controller.dart';
import 'package:mighty_school/feature/payroll_management/return_advance/domain/repository/return_advance_repository.dart';
import 'package:mighty_school/feature/payroll_management/return_advance/logic/return_advance_controller.dart';
import 'package:mighty_school/feature/payroll_management/salary/domain/repository/salary_repository.dart';
import 'package:mighty_school/feature/payroll_management/salary/logic/salary_controller.dart';
import 'package:mighty_school/feature/payroll_management/salary_slip/domain/repository/salary_slip_repository.dart';
import 'package:mighty_school/feature/payroll_management/salary_slip/logic/salary_slip_controller.dart';
import 'package:mighty_school/feature/quiz/quiz_result/controller/quiz_result_controller.dart';
import 'package:mighty_school/feature/quiz/answer/domain/repository/answer_repository.dart';
import 'package:mighty_school/feature/quiz/answer/controller/answer_controller.dart';
import 'package:mighty_school/feature/quiz/quiz_result/domain/repository/quiz_result_repository.dart';
import 'package:mighty_school/feature/reports_management/accounting_reports/domain/repository/accounting_reports_repository.dart';
import 'package:mighty_school/feature/reports_management/accounting_reports/logic/accounting_reports_controller.dart';
import 'package:mighty_school/feature/reports_management/fees_reports/domain/repository/fees_reports_repository.dart';
import 'package:mighty_school/feature/reports_management/fees_reports/logic/fees_reports_controller.dart';
import 'package:mighty_school/feature/routine_management/admit_and_seat_plan/controller/admit_and_seat_plan_controller.dart';
import 'package:mighty_school/feature/routine_management/admit_and_seat_plan/domain/repository/admit_and_seat_plan_repository.dart';
import 'package:mighty_school/feature/routine_management/class_routine/domain/repository/class_routine_repository.dart';
import 'package:mighty_school/feature/routine_management/class_routine/logic/class_routine_controller.dart';
import 'package:mighty_school/feature/routine_management/exam_routine/controller/exam_routine_controller.dart';
import 'package:mighty_school/feature/routine_management/exam_routine/domain/repository/exam_routine_repository.dart';
import 'package:mighty_school/feature/fees_management/waiver_config/controller/waiver_config_controller.dart';
import 'package:mighty_school/feature/fees_management/waiver_config/domain/repository/waiver_config_repository.dart';
import 'package:mighty_school/feature/saas_panel/saas_admin_dashboard/domain/repository/saas_admin_dashboard_repository.dart';
import 'package:mighty_school/feature/saas_panel/saas_admin_dashboard/logic/saas_admin_dashboard_controller.dart';
import 'package:mighty_school/feature/saas_panel/saas_payment_gateway/domain/repository/saas_payment_gateway_repository.dart';
import 'package:mighty_school/feature/saas_panel/saas_payment_gateway/logic/saas_payment_gateway_controller.dart';
import 'package:mighty_school/feature/student_module/student_assignment/controller/student_assignment_controller.dart';
import 'package:mighty_school/feature/student_module/student_assignment/domain/repository/student_assignment_repository.dart';
import 'package:mighty_school/feature/student_module/student_class_routine/domain/repository/student_class_routine_repository.dart';
import 'package:mighty_school/feature/student_module/student_class_routine/logic/student_class_routine_controller.dart';
import 'package:mighty_school/feature/student_module/student_library/controller/student_library_controller.dart';
import 'package:mighty_school/feature/student_module/student_library/domain/repository/student_library_repository.dart';
import 'package:mighty_school/feature/student_module/student_notice/controller/student_notice_controller.dart';
import 'package:mighty_school/feature/student_module/student_notice/domain/repository/student_notice_repository.dart';
import 'package:mighty_school/feature/student_module/student_profile/domain/repository/student_profile_repository.dart';
import 'package:mighty_school/feature/student_module/student_profile/logic/student_profile_controller.dart';
import 'package:mighty_school/feature/student_module/student_quiz/controller/student_quiz_controller.dart';
import 'package:mighty_school/feature/student_module/student_quiz/domain/repository/student_quiz_repository.dart';
import 'package:mighty_school/feature/student_module/student_subject/controller/student_subject_controller.dart';
import 'package:mighty_school/feature/student_module/student_subject/domain/repository/student_subject_repository.dart';
import 'package:mighty_school/feature/student_module/student_syllabus/controller/student_syllabus_controller.dart';
import 'package:mighty_school/feature/student_module/student_syllabus/domain/repository/student_syllabus_repository.dart';
import 'package:mighty_school/feature/third_party/logic/third_party_controller.dart';
import 'package:mighty_school/feature/transportation_management/transport_bus/domain/repository/transport_bus_repository.dart';
import 'package:mighty_school/feature/transportation_management/transport_bus/logic/transport_bus_controller.dart';
import 'package:mighty_school/feature/transportation_management/transport_bus_route/domain/repository/transport_bus_route_repository.dart';
import 'package:mighty_school/feature/transportation_management/transport_bus_route/logic/transport_bus_route_controller.dart';
import 'package:mighty_school/feature/transportation_management/transport_bus_stop/domain/repository/transport_bus_stop_repository.dart';
import 'package:mighty_school/feature/transportation_management/transport_bus_stop/logic/transport_bus_stop_controller.dart';
import 'package:mighty_school/feature/transportation_management/transport_driver/domain/repository/transport_driver_repository.dart';
import 'package:mighty_school/feature/transportation_management/transport_driver/logic/transport_driver_controller.dart';
import 'package:mighty_school/feature/transportation_management/transport_member/domain/repository/transport_member_repository.dart';
import 'package:mighty_school/feature/transportation_management/transport_member/logic/transport_member_controller.dart';
import 'package:mighty_school/feature/zoom_class/domain/repository/zoom_class_repository.dart';
import 'package:mighty_school/feature/zoom_class/logic/zoom_class_controller.dart';
import 'package:mighty_school/localization/domain/repositories/localization_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:get/get.dart';
import 'package:mighty_school/api_handle/api_client.dart';
import 'package:mighty_school/common/controller/datepicker_controller.dart';
import 'package:mighty_school/common/controller/pick_image_controller.dart';
import 'package:mighty_school/common/controller/splash_controller.dart';
import 'package:mighty_school/common/controller/theme_controller.dart';
import 'package:mighty_school/common/repository/splash_repository.dart';
import 'package:mighty_school/feature/account_management/accounting_category/controller/accounting_category_controller.dart';
import 'package:mighty_school/feature/account_management/accounting_category/domain/repository/accounting_category_repository.dart';
import 'package:mighty_school/feature/account_management/accounting_funds/domain/repository/account_funds_repository.dart';
import 'package:mighty_school/feature/account_management/accounting_funds/logic/account_fund_controller.dart';
import 'package:mighty_school/feature/account_management/accounting_group/domain/repository/account_group_repository.dart';
import 'package:mighty_school/feature/account_management/accounting_group/logic/account_group_controller.dart';
import 'package:mighty_school/feature/account_management/accounting_ledger/domain/repository/account_ledger_repository.dart';
import 'package:mighty_school/feature/account_management/accounting_ledger/logic/account_ledger_controller.dart';
import 'package:mighty_school/feature/account_management/payment/domain/repository/payment_repository.dart';
import 'package:mighty_school/feature/account_management/payment/logic/payment_controller.dart';
import 'package:mighty_school/feature/routine_management/assignment/controller/assignment_controller.dart';
import 'package:mighty_school/feature/routine_management/assignment/domain/repository/assignment_repository.dart';
import 'package:mighty_school/feature/authentication/domain/authentication_repository.dart';
import 'package:mighty_school/feature/authentication/logic/authentication_controller.dart';
import 'package:mighty_school/feature/library_management/book/controller/book_controller.dart';
import 'package:mighty_school/feature/library_management/book/domain/repository/book_repository.dart';
import 'package:mighty_school/feature/library_management/book_category/controller/book_category_controller.dart';
import 'package:mighty_school/feature/library_management/book_category/domain/repository/book_category_repository.dart';
import 'package:mighty_school/feature/academic_configuration/class/controller/class_controller.dart';
import 'package:mighty_school/feature/academic_configuration/class/domain/repository/class_repository.dart';
import 'package:mighty_school/feature/dashboard/controller/dashboard_controller.dart';
import 'package:mighty_school/feature/academic_configuration/department/controller/department_controller.dart';
import 'package:mighty_school/feature/academic_configuration/department/domain/repository/department_repository.dart';
import 'package:mighty_school/feature/administrator/event/controller/event_controller.dart';
import 'package:mighty_school/feature/administrator/event/domain/repository/event_repository.dart';
import 'package:mighty_school/feature/exam_management/exam_startup/controller/exam_startup_controller.dart';
import 'package:mighty_school/feature/exam_management/exam_startup/domain/repository/exam_startup_repository.dart';
import 'package:mighty_school/feature/fees_management/fees_amount_config/controller/fees_controller.dart';
import 'package:mighty_school/feature/fees_management/fees_amount_config/domain/repository/fees_repository.dart';
import 'package:mighty_school/feature/fees_management/fees_date/controller/fees_date_controller.dart';
import 'package:mighty_school/feature/fees_management/fees_date/domain/repository/fees_date_repository.dart';
import 'package:mighty_school/feature/fees_management/fees_head/controller/fees_head_controller.dart';
import 'package:mighty_school/feature/fees_management/fees_head/domain/repository/fees_head_repository.dart';
import 'package:mighty_school/feature/fees_management/fees_start_up/controller/fees_management_controller.dart';
import 'package:mighty_school/feature/fees_management/fees_start_up/domain/repository/fees_management_repository.dart';
import 'package:mighty_school/feature/fees_management/fees_mapping/controller/fees_mapping_controller.dart';
import 'package:mighty_school/feature/fees_management/fees_mapping/domain/repository/fees_mapping_repository.dart';
import 'package:mighty_school/feature/fees_management/fees_sub_head/controller/fees_sub_head_controller.dart';
import 'package:mighty_school/feature/fees_management/fees_sub_head/domain/repository/fees_sub_head_repository.dart';
import 'package:mighty_school/feature/academic_configuration/group/controller/group_controller.dart';
import 'package:mighty_school/feature/academic_configuration/group/domain/repository/group_repository.dart';
import 'package:mighty_school/feature/sidebar/controller/side_menu_bar_controller.dart';
import 'package:mighty_school/feature/home/domain/repository/home_repository.dart';
import 'package:mighty_school/feature/master_configuration/employee/controller/employee_controller.dart';
import 'package:mighty_school/feature/master_configuration/employee/domain/repository/employee_repository.dart';
import 'package:mighty_school/feature/hrm/leave_request/controller/leave_request_controller.dart';
import 'package:mighty_school/feature/hrm/leave_request/domain/repository/leave_request_repository.dart';
import 'package:mighty_school/feature/hrm/leave_type/controller/leave_type_controller.dart';
import 'package:mighty_school/feature/hrm/leave_type/domain/repository/leave_type_repository.dart';
import 'package:mighty_school/feature/hrm/logic/hrm_controller.dart';
import 'package:mighty_school/feature/hrm/payroll/controller/payroll_controller.dart';
import 'package:mighty_school/feature/hrm/payroll/domain/repository/payroll_repository.dart';
import 'package:mighty_school/feature/menu_section/controller/menu_type_controller.dart';
import 'package:mighty_school/feature/administrator/notice/controller/notice_controller.dart';
import 'package:mighty_school/feature/administrator/notice/domain/repository/notice_repository.dart';
import 'package:mighty_school/feature/academic_configuration/period/controller/period_controller.dart';
import 'package:mighty_school/feature/academic_configuration/period/domain/repository/period_repository.dart';
import 'package:mighty_school/feature/academic_configuration/picklist/controller/picklist_controller.dart';
import 'package:mighty_school/feature/academic_configuration/picklist/domain/repository/picklist_repository.dart';
import 'package:mighty_school/feature/profile/domain/repository/profile_repository.dart';
import 'package:mighty_school/feature/profile/logic/profile_controller.dart';
import 'package:mighty_school/feature/quiz/question/controller/question_controller.dart';
import 'package:mighty_school/feature/quiz/question/domain/repository/question_repository.dart';
import 'package:mighty_school/feature/quiz/quiz_topic/controller/quiz_topic_controller.dart';
import 'package:mighty_school/feature/quiz/quiz_topic/domain/repository/quiz_topic_repository.dart';
import 'package:mighty_school/feature/report/domain/repository/dashboard_report_repository.dart';
import 'package:mighty_school/feature/report/logic/dashboard_report_controller.dart';
import 'package:mighty_school/feature/master_configuration/role/controller/role_controller.dart';
import 'package:mighty_school/feature/master_configuration/role/domain/repository/role_repository.dart';
import 'package:mighty_school/feature/academic_configuration/section/controller/section_controller.dart';
import 'package:mighty_school/feature/academic_configuration/section/domain/repository/section_repository.dart';
import 'package:mighty_school/feature/academic_configuration/session/controller/session_controller.dart';
import 'package:mighty_school/feature/academic_configuration/session/domain/repository/session_repository.dart';
import 'package:mighty_school/feature/academic_configuration/shift/controller/shift_controller.dart';
import 'package:mighty_school/feature/academic_configuration/shift/domain/repository/shift_repository.dart';
import 'package:mighty_school/feature/academic_configuration/signature/controller/signature_controller.dart';
import 'package:mighty_school/feature/academic_configuration/signature/domain/repository/signature_repository.dart';
import 'package:mighty_school/feature/fees_management/smart_collection/controller/smart_collection_controller.dart';
import 'package:mighty_school/feature/fees_management/smart_collection/domain/repository/smart_collection_repository.dart';
import 'package:mighty_school/feature/sms/phone_book/controller/phone_book_controller.dart';
import 'package:mighty_school/feature/sms/phone_book/domain/repository/phone_book_repository.dart';
import 'package:mighty_school/feature/sms/phone_book_category/controller/phone_book_category_controller.dart';
import 'package:mighty_school/feature/sms/phone_book_category/domain/repository/phone_book_category_repository.dart';
import 'package:mighty_school/feature/sms/purchase_sms/controller/purchase_sms_controller.dart';
import 'package:mighty_school/feature/sms/purchase_sms/domain/repository/purchase_sms_repository.dart';
import 'package:mighty_school/feature/sms/sms_template/controller/sms_template_controller.dart';
import 'package:mighty_school/feature/sms/sms_template/domain/repository/sms_template_repository.dart';
import 'package:mighty_school/feature/staff_information/staff/controller/staff_controller.dart';
import 'package:mighty_school/feature/staff_information/staff/domain/repository/staff_repository.dart';
import 'package:mighty_school/feature/staff_information/staff_attendance/controller/staff_attendance_controller.dart';
import 'package:mighty_school/feature/staff_information/staff_attendance/domain/repository/staff_attendance_repository.dart';
import 'package:mighty_school/feature/students_information/student/controller/student_controller.dart';
import 'package:mighty_school/feature/students_information/student/domain/repository/student_repository.dart';
import 'package:mighty_school/feature/student_attendance_information/student_attendance/controller/student_attendance_controller.dart';
import 'package:mighty_school/feature/student_attendance_information/student_attendance/domain/repository/student_attendance_repository.dart';
import 'package:mighty_school/feature/academic_configuration/student_categories/controller/student_categories_controller.dart';
import 'package:mighty_school/feature/academic_configuration/student_categories/domain/repository/studnt_categories_repository.dart';
import 'package:mighty_school/feature/students_information/student_migration/controller/student_migration_controller.dart';
import 'package:mighty_school/feature/students_information/student_migration/domain/repository/student_migration_repository.dart';
import 'package:mighty_school/feature/academic_configuration/subject/controller/subject_controller.dart';
import 'package:mighty_school/feature/academic_configuration/subject/domain/repository/subject_repository.dart';
import 'package:mighty_school/feature/routine_management/syllabus/controller/syllabus_controller.dart';
import 'package:mighty_school/feature/routine_management/syllabus/domain/repository/syllabus_repository.dart';
import 'package:mighty_school/feature/staff_information/teacher/controller/teacher_controller.dart';
import 'package:mighty_school/feature/staff_information/teacher/domain/repository/teacher_repository.dart';
import 'package:mighty_school/feature/fees_management/waiver/controller/waiver_controller.dart';
import 'package:mighty_school/feature/fees_management/waiver/domain/repository/waiver_repository.dart';
import 'package:mighty_school/localization/language_model.dart';
import 'package:mighty_school/localization/localization_controller.dart';
import 'package:mighty_school/util/app_constants.dart';

Future<Map<String, Map<String, String>>> init() async {



  // Core
  final sharedPreferences = await SharedPreferences.getInstance();
  Get.lazyPut(() => sharedPreferences);
  Get.lazyPut(() => ApiClient(appBaseUrl: AppConstants.baseUrl, sharedPreferences: Get.find()));

  // Repository
  Get.lazyPut(() => SplashRepository(apiClient : Get.find(), sharedPreferences: Get.find()));
  Get.lazyPut(() => HomeRepository(apiClient : Get.find()));
  Get.lazyPut(() => ProfileRepository(apiClient : Get.find()));
  Get.lazyPut(() => AuthenticationRepository(apiClient : Get.find(), sharedPreferences: Get.find()));
  Get.lazyPut(() => AccountFundRepository(apiClient : Get.find()));
  Get.lazyPut(() => DepartmentRepository(apiClient : Get.find()));
  Get.lazyPut(() => EmployeeRepository(apiClient : Get.find()));
  Get.lazyPut(() => RoleRepository(apiClient : Get.find()));
  Get.lazyPut(() => PayrollRepository(apiClient : Get.find()));
  Get.lazyPut(() => LeaveTypeRepository(apiClient : Get.find()));
  Get.lazyPut(() => LeaveRequestRepository(apiClient : Get.find()));
  //
  Get.lazyPut(() => ClassRepository(apiClient : Get.find()));
  Get.lazyPut(() => GroupRepository(apiClient : Get.find()));
  Get.lazyPut(() => SectionRepository(apiClient : Get.find()));
  Get.lazyPut(() => StudentRepository(apiClient : Get.find()));
  Get.lazyPut(() => TeacherRepository(apiClient : Get.find()));
  Get.lazyPut(() => StaffRepository(apiClient : Get.find()));
  Get.lazyPut(() => PeriodRepository(apiClient : Get.find()));
  Get.lazyPut(() => SubjectRepository(apiClient : Get.find()));
  Get.lazyPut(() => StudentAttendanceRepository(apiClient : Get.find()));
  Get.lazyPut(() => AssignmentRepository(apiClient : Get.find()));
  Get.lazyPut(() => SyllabusRepository(apiClient : Get.find()));
  Get.lazyPut(() => PickListRepository(apiClient : Get.find()));
  Get.lazyPut(() => SessionRepository(apiClient : Get.find()));
  Get.lazyPut(() => NoticeRepository(apiClient : Get.find()));
  Get.lazyPut(() => EventRepository(apiClient : Get.find()));
  Get.lazyPut(() => StudentCategoriesRepository(apiClient : Get.find()));
  Get.lazyPut(() => BookCategoryRepository(apiClient : Get.find()));
  Get.lazyPut(() => BookRepository(apiClient : Get.find()));
  Get.lazyPut(() => AccountingCategoryRepository(apiClient : Get.find()));
  Get.lazyPut(() => AccountGroupRepository(apiClient : Get.find()));
  Get.lazyPut(() => AccountLedgerRepository(apiClient : Get.find()));
  Get.lazyPut(() => PaymentRepository(apiClient : Get.find()));
  Get.lazyPut(() => FeesManagementRepository(apiClient : Get.find()));
  Get.lazyPut(() => DashboardReportRepository(apiClient : Get.find()));
  Get.lazyPut(() => FeesHeadRepository(apiClient : Get.find()));
  Get.lazyPut(() => FeesSubHeadRepository(apiClient : Get.find()));
  Get.lazyPut(() => WaiverRepository(apiClient : Get.find()));
  Get.lazyPut(() => FeesMappingRepository(apiClient : Get.find()));
  Get.lazyPut(() => FeesMappingRepository(apiClient : Get.find()));
  Get.lazyPut(() => FeesRepository(apiClient : Get.find()));
  Get.lazyPut(() => FeesDateRepository(apiClient : Get.find()));
  Get.lazyPut(() => StaffAttendanceRepository(apiClient : Get.find()));
  Get.lazyPut(() => SignatureRepository(apiClient : Get.find()));
  Get.lazyPut(() => ShiftRepository(apiClient : Get.find()));
  Get.lazyPut(() => SmartCollectionRepository(apiClient : Get.find()));
  Get.lazyPut(() => SmsTemplateRepository(apiClient : Get.find()));
  Get.lazyPut(() => PhoneBookCategoryRepository(apiClient : Get.find()));
  Get.lazyPut(() => PhoneBookRepository(apiClient : Get.find()));
  Get.lazyPut(() => PurchaseSmsRepository(apiClient : Get.find()));
  Get.lazyPut(() => QuizTopicRepository(apiClient : Get.find()));
  Get.lazyPut(() => QuestionRepository(apiClient : Get.find()));
  Get.lazyPut(() => StudentMigrationRepository(apiClient : Get.find()));
  Get.lazyPut(() => ExamStartupRepository(apiClient : Get.find()));
  Get.lazyPut(() => ExamRepository(apiClient : Get.find()));
  Get.lazyPut(() => PaidInfoRepository(apiClient : Get.find()));
  Get.lazyPut(() => WaiverConfigRepository(apiClient : Get.find()));
  Get.lazyPut(() => ExamRoutineRepository(apiClient : Get.find()));
  Get.lazyPut(() => LibraryMemberRepository(apiClient : Get.find()));
  Get.lazyPut(() => MarkConfigRepository(apiClient : Get.find()));
  Get.lazyPut(() => ReMarkConfigRepository(apiClient : Get.find()));
  Get.lazyPut(() => MarkInputRepository(apiClient : Get.find()));
  Get.lazyPut(() => ChartOfAccountRepository(apiClient : Get.find()));
  Get.lazyPut(() => ClassRoutineRepository(apiClient : Get.find()));
  Get.lazyPut(() => AdmitAndSeatPlanRepository(apiClient : Get.find()));
  Get.lazyPut(() => ExamResultRepository(apiClient : Get.find()));
  Get.lazyPut(() => AnswerRepository(apiClient : Get.find()));
  Get.lazyPut(() => QuizResultRepository(apiClient : Get.find()));
  Get.lazyPut(() => SystemSettingsRepository(apiClient : Get.find()));
  Get.lazyPut(() => BranchRepository(apiClient : Get.find()));
  Get.lazyPut(() => InstituteRepository(apiClient : Get.find()));
  Get.lazyPut(() => ZoomClassRepository(apiClient : Get.find()));
  Get.lazyPut(() => PackageRepository(apiClient : Get.find()));
  Get.lazyPut(() => SaasAdminDashboardRepository(apiClient : Get.find()));
  Get.lazyPut(() => SaasPaymentGatewayRepository(apiClient: Get.find()));
  Get.lazyPut(() => DigitalPaymentRepository(apiClient: Get.find()));

  Get.lazyPut(() => AccountingReportsRepository(apiClient: Get.find()));
  Get.lazyPut(() => FeesReportsRepository(apiClient: Get.find()));
//..........................Payroll................................
  Get.lazyPut(() => ReturnAdvanceRepository(apiClient: Get.find()));
  Get.lazyPut(() => AdvanceRepository(apiClient: Get.find()));
  Get.lazyPut(() => DueRepository(apiClient: Get.find()));
  Get.lazyPut(() => SalaryRepository(apiClient: Get.find()));
  Get.lazyPut(() => SalarySlipRepository(apiClient: Get.find()));
  Get.lazyPut(() => PayrollAssignRepository(apiClient: Get.find()));
  Get.lazyPut(() => PayrollMappingRepository(apiClient: Get.find()));
  Get.lazyPut(() => PayrollStartUpRepository(apiClient: Get.find()));
  Get.lazyPut(() => LocalizationRepository(apiClient: Get.find(), sharedPreferences: Get.find()));






  //cms

  Get.lazyPut(() => AboutUsRepository(apiClient: Get.find()));
  Get.lazyPut(() => BannerRepository(apiClient: Get.find()));
  Get.lazyPut(() => WhyChooseUsRepository(apiClient: Get.find()));
  Get.lazyPut(() => MobileAppRepository(apiClient: Get.find()));
  Get.lazyPut(() => ReadyToJoinRepository(apiClient: Get.find()));
  Get.lazyPut(() => FaqRepository(apiClient: Get.find()));
  Get.lazyPut(() => FeedbackRepository(apiClient: Get.find()));
  Get.lazyPut(() => AcademicImageRepository(apiClient: Get.find()));
  Get.lazyPut(() => PagesRepository(apiClient: Get.find()));
  Get.lazyPut(() => LandingPageRepository(apiClient: Get.find()));
  Get.lazyPut(() => LayoutAndCertificateRepository(apiClient: Get.find()));



  // Parent Module
  Get.lazyPut(() => ParentProfileRepository(apiClient: Get.find()));
  Get.lazyPut(() => ParentSyllabusRepository(apiClient: Get.find()));
  Get.lazyPut(() => ParentAssignmentRepository(apiClient: Get.find()));
  Get.lazyPut(() => ParentNoticeRepository(apiClient: Get.find()));
  Get.lazyPut(() => ParentPaidInfoRepository(apiClient: Get.find()));
  Get.lazyPut(() => ParentLibraryRepository(apiClient: Get.find()));
  Get.lazyPut(() => ParentExamRepository(apiClient: Get.find()));
  Get.lazyPut(() => ParentEventRepository(apiClient: Get.find()));
  Get.lazyPut(() => ParentAttendanceRepository(apiClient: Get.find()));
  Get.lazyPut(() => ChildrenRepository(apiClient: Get.find()));
  Get.lazyPut(() => ParentClassRoutineRepository(apiClient: Get.find()));
  Get.lazyPut(() => ParentSubjectRepository(apiClient: Get.find()));







  // Controller
  Get.lazyPut(() => SplashController(splashRepo: Get.find()));

  Get.lazyPut(() => SideMenuBarController(homeRepository: Get.find()));
  Get.lazyPut(() => ProfileController(profileRepository: Get.find()));
  Get.lazyPut(() => ThemeController(sharedPreferences: Get.find()));
  Get.lazyPut(() => LocalizationController(sharedPreferences: Get.find(), localizationRepository: Get.find()));
  Get.lazyPut(() => AuthenticationController(authenticationRepository: Get.find()));
  Get.lazyPut(() => DashboardController());
  Get.lazyPut(() => AccountingFundController(accountFundRepository: Get.find()));
  Get.lazyPut(() => MenuTypeController());
  Get.lazyPut(() => HrmController());
  Get.lazyPut(() => DepartmentController(departmentRepository: Get.find()));
  Get.lazyPut(() => EmployeeController(employeeRepository: Get.find()));
  Get.lazyPut(() => RoleController(roleRepository: Get.find()));
  Get.lazyPut(() => PayrollController(payrollRepository: Get.find()));
  Get.lazyPut(() => LeaveTypeController(leaveTypeRepository: Get.find()));
  Get.lazyPut(() => LeaveRequestController(leaveRequestRepository: Get.find()));
  //
  Get.lazyPut(() => ClassController(classRepository: Get.find()));
  Get.lazyPut(() => GroupController(groupRepository: Get.find()));
  Get.lazyPut(() => SectionController(sectionRepository: Get.find()));
  Get.lazyPut(() => StudentController(studentRepository: Get.find()));
  Get.lazyPut(() => TeacherController(teacherRepository: Get.find()));
  Get.lazyPut(() => StaffController(staffRepository: Get.find()));
  Get.lazyPut(() => PeriodController(periodRepository: Get.find()));
  Get.lazyPut(() => SubjectController(subjectRepository: Get.find()));
  Get.lazyPut(() => StudentAttendanceController(studentAttendanceRepository: Get.find()));
  Get.lazyPut(() => DatePickerController());
  Get.lazyPut(() => AssignmentController(attachmentRepository: Get.find()));
  Get.lazyPut(() => SyllabusController(syllabusRepository: Get.find()));
  Get.lazyPut(() => PickListController(pickListRepository: Get.find()));
  Get.lazyPut(() => SessionController(sessionRepository: Get.find()));
  Get.lazyPut(() => NoticeController(noticeRepository: Get.find()));
  Get.lazyPut(() => EventController(eventRepository: Get.find()));
  Get.lazyPut(() => StudentCategoriesController(studentCategoriesRepository: Get.find()));
  Get.lazyPut(() => BookCategoryController(bookCategoryRepository: Get.find()));
  Get.lazyPut(() => BookController(bookRepository: Get.find()));
  Get.lazyPut(() => AccountingCategoryController(accountingCategoryRepository: Get.find()));
  Get.lazyPut(() => AccountingGroupController(accountGroupRepository: Get.find()));
  Get.lazyPut(() => AccountLedgerController(accountLedgerRepository: Get.find()));
  Get.lazyPut(() => PaymentController(paymentRepository: Get.find()));
  Get.lazyPut(() => DashboardReportController(dashboardReportRepository: Get.find()));
  Get.lazyPut(() => FeesManagementController(feesManagementRepository: Get.find()));
  Get.lazyPut(() => FeesHeadController(feesHeadRepository: Get.find()));
  Get.lazyPut(() => FeesSubHeadController(feesSubHeadRepository: Get.find()));
  Get.lazyPut(() => WaiverController(waiverRepository: Get.find()));
  Get.lazyPut(() => FeesMappingController(feesMappingRepository: Get.find()));
  Get.lazyPut(() => FeesController(feesRepository: Get.find()));
  Get.lazyPut(() => FeesDateController(feesDateRepository: Get.find()));
  Get.lazyPut(() => StaffAttendanceController(staffAttendanceRepository: Get.find()));
  Get.lazyPut(() => SignatureController(signatureRepository: Get.find()));
  Get.lazyPut(() => ShiftController(shiftRepository: Get.find()));
  Get.lazyPut(() => SmartCollectionController(smartCollectionRepository: Get.find()));
  Get.lazyPut(() => SmsTemplateController(smsTemplateRepository: Get.find()));
  Get.lazyPut(() => PhoneBookCategoryController(phoneBookCategoryRepository: Get.find()));
  Get.lazyPut(() => PhoneBookController(phoneBookRepository: Get.find()));
  Get.lazyPut(() => PurchaseSmsController(purchaseSmsRepository: Get.find()));
  Get.lazyPut(() => QuizTopicController(quizTopicRepository: Get.find()));
  Get.lazyPut(() => QuestionController(questionRepository: Get.find()));
  Get.lazyPut(() => PickImageController());
  Get.lazyPut(() => StudentMigrationController(studentMigrationRepository: Get.find()));
  Get.lazyPut(() => ExamStartupController(examStartupRepository: Get.find()));
  Get.lazyPut(() => ExamController(examRepository: Get.find()));
  Get.lazyPut(() => PaidInfoController(paidInfoRepository: Get.find()));
  Get.lazyPut(() => WaiverConfigController(waiverConfigRepository: Get.find()));
  Get.lazyPut(() => ExamRoutineController(examRoutineRepository: Get.find()));
  Get.lazyPut(() => LibraryMemberController(libraryMemberRepository: Get.find()));
  Get.lazyPut(() => MarkConfigController(markConfigRepository: Get.find()));
  Get.lazyPut(() => ReMarkConfigController(reMarkConfigRepository: Get.find()));
  Get.lazyPut(() => MarkInputController(markInputRepository: Get.find()));
  Get.lazyPut(() => ChartOfAccountController(chartOfAccountRepository: Get.find()));
  Get.lazyPut(() => ClassRoutineController(classRoutineRepository: Get.find()));
  Get.lazyPut(() => AdmitAndSeatPlanController(admitAndSeatPlanRepository: Get.find()));
  Get.lazyPut(() => ExamResultController(examResultRepository: Get.find()));
  Get.lazyPut(() => AnswerController(answerRepository: Get.find()));
  Get.lazyPut(() => QuizResultController(quizResultRepository: Get.find()));
  Get.lazyPut(() => SystemSettingsController(systemSettingsRepository: Get.find()));
  Get.lazyPut(() => BranchController(branchRepository: Get.find()));
  Get.lazyPut(() => InstituteController(instituteRepository: Get.find()));
  Get.lazyPut(() => ZoomClassController(zoomClassRepository: Get.find()));
  Get.lazyPut(() => ThirdPartyController());
  Get.lazyPut(() => PackageController(packageRepository: Get.find()));
  Get.lazyPut(() => SaasAdminDashboardController(saasAdminDashboardRepository: Get.find()));
  Get.lazyPut(() => DigitalPaymentController(digitalPaymentRepository: Get.find()));
  Get.lazyPut(() => ChatGptController());
  Get.lazyPut(() => AccountingReportsController(accountingReportsRepository: Get.find()));
  Get.lazyPut(() => FeesReportsController(feesReportsRepository: Get.find()));

  //--------------------------payroll-------------------------------------
  Get.lazyPut(() => ReturnAdvanceController(returnAdvanceRepository: Get.find()));
  Get.lazyPut(() => AdvanceController(advanceRepository: Get.find()));
  Get.lazyPut(() => DueController(dueRepository: Get.find()));
  Get.lazyPut(() => SalaryController(salaryRepository: Get.find()));
  Get.lazyPut(() => SalarySlipController(salarySlipRepository: Get.find()));
  Get.lazyPut(() => PayrollAssignController(payrollAssignRepository: Get.find()));
  Get.lazyPut(() => PayrollMappingController(payrollMappingRepository: Get.find()));
  Get.lazyPut(() => PayrollStartUpController(payrollStartUpRepository: Get.find()));


  //cms

  Get.lazyPut(() => AboutUsController(aboutUsRepository: Get.find()));
  Get.lazyPut(() => BannerController(bannerRepository: Get.find()));
  Get.lazyPut(() => WhyChooseUsController(whyChooseUsRepository: Get.find()));
  Get.lazyPut(() => MobileAppController(mobileAppRepository: Get.find()));
  Get.lazyPut(() => ReadyToJoinController(readyToJoinRepository: Get.find()));
  Get.lazyPut(() => FaqController(faqRepository: Get.find()));
  Get.lazyPut(() => FeedbackController(feedbackRepository: Get.find()));
  Get.lazyPut(() => AcademicImageController(academicImageRepository: Get.find()));
  Get.lazyPut(() => PagesController(pagesRepository: Get.find()));
  Get.lazyPut(() => LandingPageController(landingPageRepository: Get.find()));
  Get.lazyPut(() => LayoutAndCertificateController(layoutAndCertificateRepository: Get.find()));
  Get.lazyPut(() => IdCardController());
  Get.lazyPut(() => SaasPaymentGatewayController(saasPaymentGatewayRepository: Get.find()));




  //Parent Module
  Get.lazyPut(() => ParentProfileController(profileRepository: Get.find()));
  Get.lazyPut(() => ParentAssignmentController(attachmentRepository: Get.find()));
  Get.lazyPut(() => ParentSyllabusController(syllabusRepository: Get.find()));
  Get.lazyPut(() => ParentNoticeController(noticeRepository: Get.find()));
  Get.lazyPut(() => ParentPaidInfoController(paidInfoRepository: Get.find()));
  Get.lazyPut(() => ParentLibraryController(libraryRepository: Get.find()));
  Get.lazyPut(() => ParentExamController(examRepository: Get.find()));
  Get.lazyPut(() => ParentEventController(eventRepository: Get.find()));
  Get.lazyPut(() => ParentAttendanceController(attendanceRepository: Get.find()));
  Get.lazyPut(() => ChildrenController(childrenRepository: Get.find()));
  Get.lazyPut(() => ParentClassRoutineController(classRoutineRepository: Get.find()));
  Get.lazyPut(() => ParentSubjectController(subjectRepository: Get.find()));
  Get.lazyPut(() => ParentMenuController());



  //Transportation
  Get.lazyPut(() => TransportMemberRepository(apiClient: Get.find()));
  Get.lazyPut(() => TransportMemberController(transportMemberRepository: Get.find()));

  Get.lazyPut(() => TransportBusStopRepository(apiClient: Get.find()));
  Get.lazyPut(() => TransportBusStopController(transportBusStopRepository: Get.find()));

  Get.lazyPut(() => TransportBusRouteRepository(apiClient: Get.find()));
  Get.lazyPut(() => TransportBusRouteController(transportBusRouteRepository: Get.find()));

  Get.lazyPut(() => TransportDriverRepository(apiClient: Get.find()));
  Get.lazyPut(() => TransportDriverController(transportDriverRepository: Get.find()));

  Get.lazyPut(() => TransportBusRepository(apiClient: Get.find()));
  Get.lazyPut(() => TransportBusController(transportBusRepository: Get.find()));


  //Hostel
  Get.lazyPut(() => HostelBillRepository(apiClient: Get.find()));
  Get.lazyPut(() => HostelBillController(hostelBillRepository: Get.find()));

  Get.lazyPut(() => HostelMealEntriesRepository(apiClient: Get.find()));
  Get.lazyPut(() => HostelMealEntriesController(hostelMealEntriesRepository: Get.find()));

  Get.lazyPut(() => HostelMealPlanRepository(apiClient: Get.find()));
  Get.lazyPut(() => HostelMealPlanController(hostelMealPlanRepository: Get.find()));

  Get.lazyPut(() => HostelMealsRepository(apiClient: Get.find()));
  Get.lazyPut(() => HostelMealsController(hostelMealsRepository: Get.find()));

  Get.lazyPut(() => HostelRoomMemberRepository(apiClient: Get.find()));
  Get.lazyPut(() => HostelRoomMemberController(hostelRoomMemberRepository: Get.find()));

  Get.lazyPut(() => HostelRoomsRepository(apiClient: Get.find()));
  Get.lazyPut(() => HostelRoomsController(hostelRoomsRepository: Get.find()));

  Get.lazyPut(() => HostelMembersRepository(apiClient: Get.find()));
  Get.lazyPut(() => HostelMembersController(hostelMembersRepository: Get.find()));

  Get.lazyPut(() => HostelCategoriesRepository(apiClient: Get.find()));
  Get.lazyPut(() => HostelCategoriesController(hostelCategoriesRepository: Get.find()));

  Get.lazyPut(() => HostelRepository(apiClient: Get.find()));
  Get.lazyPut(() => HostelController(hostelRepository: Get.find()));


  //student module
  Get.lazyPut(() => StudentProfileRepository(apiClient: Get.find()));
  Get.lazyPut(() => StudentProfileController(studentProfileRepository: Get.find()));

  Get.lazyPut(() => StudentAssignmentRepository(apiClient: Get.find()));
  Get.lazyPut(() => StudentAssignmentController(studentAssignmentRepository: Get.find()));

  Get.lazyPut(() => StudentClassRoutineRepository(apiClient: Get.find()));
  Get.lazyPut(() => StudentClassRoutineController(classRoutineRepository: Get.find()));


  Get.lazyPut(() => StudentLibraryRepository(apiClient: Get.find()));
  Get.lazyPut(() => StudentLibraryController(libraryRepository: Get.find()));

  Get.lazyPut(() => StudentNoticeRepository(apiClient: Get.find()));
  Get.lazyPut(() => StudentNoticeController(noticeRepository: Get.find()));

  Get.lazyPut(() => StudentSubjectRepository(apiClient: Get.find()));
  Get.lazyPut(() => StudentSubjectController(subjectRepository: Get.find()));

  Get.lazyPut(() => StudentSyllabusRepository(apiClient: Get.find()));
  Get.lazyPut(() => StudentSyllabusController(syllabusRepository: Get.find()));

  Get.lazyPut(() => StudentQuizRepository(apiClient: Get.find()));
  Get.lazyPut(() => StudentQuizController(quizRepository: Get.find()));








  // Retrieving localized data
  Map<String, Map<String, String>> languages = {};
  for(LanguageModel languageModel in AppConstants.languages) {
    String jsonStringValues =  await rootBundle.loadString('assets/language/${languageModel.languageCode}.json');
    Map<String, dynamic> mappedJson = json.decode(jsonStringValues);
    Map<String, String> languageJson = {};
    mappedJson.forEach((key, value) {
      languageJson[key] = value.toString();
    });
    languages['${languageModel.languageCode}_${languageModel.countryCode}'] = languageJson;
  }
  return languages;
}
