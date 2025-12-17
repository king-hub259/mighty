import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';
import 'package:mighty_school/api_handle/api_checker.dart';
import 'package:mighty_school/api_handle/api_client.dart';
import 'package:mighty_school/api_handle/global_api_response_model.dart';
import 'package:mighty_school/common/widget/custom_snackbar.dart';
import 'package:mighty_school/feature/student_module/student_assignment/domain/models/student_assignment_body.dart';
import 'package:mighty_school/feature/student_module/student_assignment/domain/models/student_assignment_model.dart';
import 'package:mighty_school/feature/student_module/student_assignment/domain/repository/student_assignment_repository.dart';


class StudentAssignmentController extends GetxController implements GetxService{
  final StudentAssignmentRepository studentAssignmentRepository;
  StudentAssignmentController({required this.studentAssignmentRepository});

  bool isLoading = false;
  ApiResponse<StudentAssignmentItem>? assignmentModel;
  Future<void> getMyAssignmentList(int offset) async {
    Response? response = await studentAssignmentRepository.getMyAssignmentList(offset);
    if (response?.statusCode == 200) {
      final apiResponse = ApiResponse<StudentAssignmentItem>.fromJson(
        response?.body,
        (data) => StudentAssignmentItem.fromJson(data),
      );
      if(offset == 1){
        assignmentModel = apiResponse;
      }else{
        assignmentModel?.data?.data?.addAll(apiResponse.data!.data!);
        assignmentModel?.data?.currentPage = apiResponse.data?.currentPage;
        assignmentModel?.data?.total = apiResponse.data?.total;
      }
      isLoading = false;
    }else{
      isLoading = false;
      ApiChecker.checkApi(response!);
    }
    update();
  }




  List<MultipartDocument> documents = [];
  FilePickerResult? _otherFile;
  FilePickerResult? get otherFile => _otherFile;
  List<FilePickerResult> listOfDocuments = [];
  File? _file;
  PlatformFile? objFile;
  File? get file=> _file;

  Future<bool> pickOtherFile(bool isRemove) async {
    if(isRemove){
      _otherFile=null;
      _file = null;
    }else{
      _otherFile = (await FilePicker.platform.pickFiles(withReadStream: true))!;
      if (_otherFile != null) {
        listOfDocuments.add(_otherFile!);
        manageFile();

      }
    }
    update();
    return true;
  }

  void manageFile(){
    documents = [];
    for(int i=0; i<listOfDocuments.length; i++){
      objFile = listOfDocuments[i].files.single;
      if(i==0){
        documents.add(MultipartDocument('file', objFile));
      }else{
        documents.add(MultipartDocument('file_${i + 1}', objFile));
      }

    }
  }


  clearFile (){
    _otherFile = null;
    _file = null;
    listOfDocuments = [];
    documents = [];
    update();
  }




  void removeFile(int index) async {
    listOfDocuments.removeAt(index);
    documents.removeAt(index);
    update();
  }


  Future<void> createNewAssignment(StudentAssignmentBody assignmentBody) async {
    isLoading = true;
    update();
    Response? response = await studentAssignmentRepository.createNewAssignment(assignmentBody, documents);
    if(response?.statusCode == 200){
      clearFile();
      isLoading = false;
      Get.back();
      showCustomSnackBar("added_successfully".tr, isError: false);
      getMyAssignmentList(1);
    }else{
      ApiChecker.checkApi(response!);
    }
    isLoading = false;
    update();

  }

}