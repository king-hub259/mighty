import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/custom_contaner.dart';
import 'package:mighty_school/common/widget/custom_image.dart';
import 'package:mighty_school/feature/students_information/student/controller/student_controller.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/images.dart';
import 'package:mighty_school/util/styles.dart';

class SelectBulkStudentImportDocWidget extends StatelessWidget {
  const SelectBulkStudentImportDocWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return  GetBuilder<StudentController>(
        builder: (studentController) {
          return InkWell(onTap: ()=> studentController.pickDocument(),
            child: Stack(children: [
              ClipRRect(borderRadius: BorderRadius.circular(5),
                  child: studentController.selectedDocument != null ? SizedBox(width: 200, child: Text(studentController.selectedDocument??'', style: textRegular,)):
                  CustomContainer(color: Theme.of(context).secondaryHeaderColor.withValues(alpha: .075),
                      horizontalPadding: 15, verticalPadding: 10, showShadow: false, borderRadius: 2,
                      child: const CustomImage(image: '', height: Dimensions.listHeaderHeight, width: Dimensions.listHeaderHeight, placeholder: Images.csv))),

            ]),
          );
        }
    );
  }
}
