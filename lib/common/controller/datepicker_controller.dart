import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DatePickerController extends GetxController implements GetxService{

  String? isoTime;
  DateTime selectedDate = DateTime.now();
  DateTime selectedEndDate = DateTime.now();
  String formatedDate = "${DateTime.now().year.toString()}-${DateTime.now().month.toString().padLeft(2,'0')}-${DateTime.now().day.toString().padLeft(2,'0')}";
  String formatedEndDate = "${DateTime.now().year.toString()}-${DateTime.now().month.toString().padLeft(2,'0')}-${DateTime.now().day.toString().padLeft(2,'0')}";
  Future<void> setSelectDate(BuildContext context, {bool end = false}) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      // ISO-format it in UTC
      isoTime = '${selectedDate.toUtc().toIso8601String().split('.').first}Z';
      log("ISO Time: $isoTime");

      if(end){
        selectedEndDate = picked;
        formatedEndDate = "${selectedEndDate.year.toString()}-${selectedEndDate.month.toString().padLeft(2, '0')}-${selectedEndDate.day.toString().padLeft(2, '0')}";
      }else {
        selectedDate = picked;
        formatedDate = "${selectedDate.year.toString()}-${selectedDate.month.toString().padLeft(2, '0')}-${selectedDate.day.toString().padLeft(2, '0')}";
      }
      log("message=== $selectedDate");

    }
    update();
  }

  void resetDate() {
    selectedDate = DateTime.now();
    selectedEndDate = DateTime.now();
    formatedDate = "${DateTime.now().year.toString()}-${DateTime.now().month.toString().padLeft(2,'0')}-${DateTime.now().day.toString().padLeft(2,'0')}";
    formatedEndDate = "";
    update();
  }

  void setDateFromString(String dateString) {
    try {
      selectedDate = DateTime.parse(dateString);
      formatedDate = "${selectedDate.year.toString()}-${selectedDate.month.toString().padLeft(2,'0')}-${selectedDate.day.toString().padLeft(2,'0')}";
      update();
    } catch (e) {
      log("Error parsing date: $e");
    }
  }

  void setEndDateFromString(String dateString) {
    try {
      selectedEndDate = DateTime.parse(dateString);
      formatedEndDate = "${selectedEndDate.year.toString()}-${selectedEndDate.month.toString().padLeft(2,'0')}-${selectedEndDate.day.toString().padLeft(2,'0')}";
      update();
    } catch (e) {
      log("Error parsing end date: $e");
    }
  }

}