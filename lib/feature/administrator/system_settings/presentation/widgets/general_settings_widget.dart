import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/custom_button.dart';
import 'package:mighty_school/common/widget/custom_text_field.dart';
import 'package:mighty_school/common/widget/custom_title.dart';
import 'package:mighty_school/feature/administrator/system_settings/controller/system_settngs_controller.dart';
import 'package:mighty_school/feature/administrator/system_settings/domain/model/general_settings_model.dart';
import 'package:mighty_school/util/dimensions.dart';

class GeneralSettingsWidget extends StatefulWidget {
  const GeneralSettingsWidget({super.key});

  @override
  State<GeneralSettingsWidget> createState() => _GeneralSettingsWidgetState();
}

class _GeneralSettingsWidgetState extends State<GeneralSettingsWidget> {
  TextEditingController nameController = TextEditingController();
  TextEditingController siteTitleController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController currencySymbolController = TextEditingController();
  TextEditingController examResultController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController eiinController = TextEditingController();
  TextEditingController instituteController = TextEditingController();
  TextEditingController transferCertificateController = TextEditingController();
  TextEditingController liveNoticeController = TextEditingController();
  TextEditingController onlineAdmissionDisplayStatusController = TextEditingController();
  TextEditingController examResultDisplayController = TextEditingController();
  TextEditingController appUrlController = TextEditingController();
  TextEditingController appVersionController = TextEditingController();

  @override
  void initState() {
    nameController.text = Get.find<SystemSettingsController>().generalSettingModel?.data?.schoolName??'';
    siteTitleController.text = Get.find<SystemSettingsController>().generalSettingModel?.data?.siteTitle??'';
    phoneController.text = Get.find<SystemSettingsController>().generalSettingModel?.data?.phone??'';
    emailController.text = Get.find<SystemSettingsController>().generalSettingModel?.data?.email??'';
    currencySymbolController.text = Get.find<SystemSettingsController>().generalSettingModel?.data?.currencySymbol??'';
    examResultController.text = Get.find<SystemSettingsController>().generalSettingModel?.data?.examResultPhone??'';
    addressController.text = Get.find<SystemSettingsController>().generalSettingModel?.data?.address??'';
    eiinController.text = Get.find<SystemSettingsController>().generalSettingModel?.data?.eiinCode??'';
    instituteController.text = Get.find<SystemSettingsController>().generalSettingModel?.data?.instituteCode??'';
    transferCertificateController.text = Get.find<SystemSettingsController>().generalSettingModel?.data?.tcAmount??'';
    liveNoticeController.text = Get.find<SystemSettingsController>().generalSettingModel?.data?.headerNotice??'';
    onlineAdmissionDisplayStatusController.text = Get.find<SystemSettingsController>().generalSettingModel?.data?.admissionDisplayStatus??'';
    examResultDisplayController.text = Get.find<SystemSettingsController>().generalSettingModel?.data?.examResultStatus??'';
    appUrlController.text = Get.find<SystemSettingsController>().generalSettingModel?.data?.appUrl??'';
    appVersionController.text = Get.find<SystemSettingsController>().generalSettingModel?.data?.appVersion??'';
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return GetBuilder<SystemSettingsController>(
      builder: (settingsController) {
        return Column(spacing: Dimensions.paddingSizeSmall, children: [
          CustomTitle(title: "general".tr, webTitle: true, leftPadding: 0),
          Row(spacing: Dimensions.paddingSizeSmall, children: [
              Expanded(
                child: CustomTextField(title: "institute_name".tr,
                  hintText: "institute_name".tr, controller: nameController),
              ),
              Expanded(
                child: CustomTextField(title: "site_title".tr,
                    hintText: "site_title".tr, controller: siteTitleController))]),


          Row(spacing: Dimensions.paddingSizeSmall, children: [
            Expanded(
              child: CustomTextField(title: "phone".tr,
                  hintText: "phone".tr, controller: phoneController),
            ),
            Expanded(
                child: CustomTextField(title: "currency_symbol".tr,
                    hintText: "currency_symbol".tr, controller: currencySymbolController))]),



          Row(spacing: Dimensions.paddingSizeSmall, children: [
            Expanded(
              child: CustomTextField(title: "exam_result".tr,
                  hintText: "exam_result".tr, controller: examResultController),
            ),
            Expanded(
                child: CustomTextField(title: "email".tr,
                    hintText: "email".tr, controller: emailController))]),



          Row(spacing: Dimensions.paddingSizeSmall, children: [
            Expanded(
              child: CustomTextField(title: "address".tr,
                  hintText: "address".tr, controller: addressController),
            ),
            Expanded(
                child: CustomTextField(title: "eiin".tr,
                    hintText: "eiin".tr, controller: eiinController))]),


          Row(spacing: Dimensions.paddingSizeSmall, children: [
            Expanded(
              child: CustomTextField(title: "institute_id".tr,
                  hintText: "institute_id".tr, controller: instituteController),
            ),
            Expanded(
                child: CustomTextField(title: "transfer_certificate_fee".tr,
                    hintText: "transfer_certificate_fee".tr, controller: transferCertificateController))]),


          CustomTextField(title: "live_notice_on_head".tr,
              minLines: 3, maxLines: 5, maxLength: 500,
              inputType: TextInputType.multiline, inputAction: TextInputAction.newline,
              hintText: "live_notice_on_head".tr, controller: liveNoticeController),

          Row(spacing: Dimensions.paddingSizeSmall, children: [

            Expanded(
                child: CustomTextField(title: "online_admission_display_status".tr,
                    hintText: "online_admission_display_status".tr, controller: onlineAdmissionDisplayStatusController)),
            Expanded(
                child: CustomTextField(title: "exam_result_display_status".tr,
                    hintText: "exam_result_display_status".tr, controller: examResultDisplayController))
          ]),

          Row(spacing: Dimensions.paddingSizeSmall, children: [
            Expanded(
              child: CustomTextField(title: "app_version".tr,
                  hintText: "app_version".tr, controller: appVersionController),
            ),
            Expanded(
                child: CustomTextField(title: "app_url".tr,
                    hintText: "app_url".tr, controller: appUrlController))]),

          Align(alignment: Alignment.centerRight,
              child: SizedBox(width: 130, child: settingsController.loading?
                  Center(child: CircularProgressIndicator(color: Theme.of(context).primaryColor)):
              CustomButton(onTap: (){
                SettingItem body = SettingItem(
                  schoolName: nameController.text,
                  siteTitle: siteTitleController.text,
                  phone: phoneController.text,
                  email: emailController.text,
                  currencySymbol: currencySymbolController.text,
                  examResultPhone: examResultController.text,
                  address: addressController.text,
                  eiinCode: eiinController.text,
                  instituteCode: instituteController.text,
                  tcAmount: transferCertificateController.text,
                  headerNotice: liveNoticeController.text,
                  admissionDisplayStatus: onlineAdmissionDisplayStatusController.text,
                  examResultStatus: examResultDisplayController.text,
                  appVersion: appVersionController.text,
                  appUrl: appUrlController.text,
                );
                settingsController.updateGeneralSetting(body);
              }, text: "save_settings".tr))),

        ],);
      }
    );
  }
}
