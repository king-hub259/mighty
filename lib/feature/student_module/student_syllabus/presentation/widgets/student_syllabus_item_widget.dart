import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/custom_contaner.dart';
import 'package:mighty_school/feature/routine_management/syllabus/domain/models/syllabus_model.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/styles.dart';

class StudentSyllabusItemWidget extends StatelessWidget {
  final SyllabusItem? syllabusItem;
  final int index;
  const StudentSyllabusItemWidget({super.key, this.syllabusItem, required this.index});

  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeDefault, vertical: 5),
      child: CustomContainer(child: Row(children: [
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text("${syllabusItem?.title}", style: textMedium.copyWith(fontSize: Dimensions.fontSizeDefault),),
             if(syllabusItem?.description != null)
              Text("${"details".tr} : ${syllabusItem?.description??''}", style: textRegular.copyWith(),),

            Padding(padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Row(children: [
                  const Icon(CupertinoIcons.doc),
                  Text(syllabusItem?.file??''),
                ]))
            ]),
          ),
        ],
      )),
    );
  }
}