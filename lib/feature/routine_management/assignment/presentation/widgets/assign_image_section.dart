import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/feature/routine_management/assignment/controller/assignment_controller.dart';
import 'package:mighty_school/util/dimensions.dart';
import 'package:mighty_school/util/images.dart';

class FileSelectionSection extends StatefulWidget {
  final bool isSyllabus;
  const FileSelectionSection({super.key, this.isSyllabus = false});

  @override
  State<FileSelectionSection> createState() => _FileSelectionSectionState();
}

class _FileSelectionSectionState extends State<FileSelectionSection> {
  PlatformFile? fileNamed;
  File? file;
  int? fileSize;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AssignmentController>(
      builder: (assignmentController) {
        return Column(children: [
          if((assignmentController.listOfDocuments.length < 4 && !widget.isSyllabus) || (assignmentController.listOfDocuments.isEmpty && widget.isSyllabus))
          Padding(padding: const EdgeInsets.fromLTRB(0, Dimensions.paddingSizeDefault, 0, 0),
            child: DottedBorder(
              dashPattern: const [4,5],
              borderType: BorderType.RRect,
              color: Theme.of(context).hintColor,
              radius: const Radius.circular(10),
              child: Container(
                padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: BorderRadius.circular(Dimensions.paddingSizeExtraSmall)
                ),
                child: InkWell(onTap: ()async{
                   await assignmentController.pickOtherFile(false);
                },
                  child: Builder(
                      builder: (context) {
                        return Column(mainAxisAlignment: MainAxisAlignment.center,crossAxisAlignment: CrossAxisAlignment.center, children: [
                          SizedBox(width: 50,child: Image.asset(Images.upload)),
                          Text('upload_documents'.tr),
                        ],);
                      }
                  ),
                ),
              ),
            ),
          ),

          if(assignmentController.listOfDocuments.isNotEmpty)
            ListView.builder(
                itemCount: assignmentController.listOfDocuments.length,
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                physics: const NeverScrollableScrollPhysics(),
                itemBuilder: (context, index){
                  return InkWell(onTap: ()=> assignmentController.removeFile(index),
                    child: Padding(padding: const EdgeInsets.fromLTRB(0, Dimensions.paddingSizeDefault, 0, 0),
                      child: Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(Dimensions.paddingSizeExtraSmall),
                          color: Theme.of(context).cardColor,
                          boxShadow: [BoxShadow(color: Theme.of(context).hintColor.withValues(alpha: .25),spreadRadius: 1, blurRadius: 1, offset: const Offset(0,1))]),
                          child: Padding(padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
                              child: Row(children: [
                                SizedBox(width: Dimensions.iconSizeMedium,child: Image.asset(Images.clip)),
                                const SizedBox(width: Dimensions.paddingSizeSmall),
                                Expanded(child: Text(assignmentController.listOfDocuments[index].files.first.name, maxLines: 1,overflow: TextOverflow.ellipsis)),
                                const Icon(Icons.clear, color: Colors.red,size: 20,)
                              ]))),
                    ),
                  );
                }),
        ],);
      }
    );
  }
}
