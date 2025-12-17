
import 'package:get/get.dart';
import 'package:mighty_school/api_handle/api_checker.dart';
import 'package:mighty_school/feature/parent_module/parent_assignment/domain/models/parent_assignment_model.dart';
import 'package:mighty_school/feature/parent_module/parent_assignment/domain/models/submited_assignment_model.dart';
import 'package:mighty_school/feature/parent_module/parent_assignment/domain/repository/parent_assignment_repository.dart';


class ParentAssignmentController extends GetxController implements GetxService{
  final ParentAssignmentRepository attachmentRepository;
  ParentAssignmentController({required this.attachmentRepository});

  bool isLoading = false;
  ParentAssignmentModel? assignmentModel;
  Future<void> getMyAssignmentList(int offset) async {
    Response? response = await attachmentRepository.getChildrenAssignment(offset);
    if (response?.statusCode == 200) {
      if(offset == 1){
        assignmentModel = ParentAssignmentModel.fromJson(response?.body);
      }else{
        assignmentModel?.data?.data?.addAll(ParentAssignmentModel.fromJson(response?.body).data!.data!);
        assignmentModel?.data?.currentPage = ParentAssignmentModel.fromJson(response?.body).data?.currentPage;
        assignmentModel?.data?.total = ParentAssignmentModel.fromJson(response?.body).data?.total;
      }
      isLoading = false;
    }else{
      isLoading = false;
      ApiChecker.checkApi(response!);
    }
    update();
  }

  SubmittedAssignmentModel? submittedAssignmentModel;
  Future<void> getSubmittedAssignmentList(int page) async {
    Response? response = await attachmentRepository.getSubmittedAssignmentList(page);
    if (response?.statusCode == 200) {
      if(page == 1){
        submittedAssignmentModel = SubmittedAssignmentModel.fromJson(response?.body);
      }else{
        submittedAssignmentModel?.data?.data?.addAll(SubmittedAssignmentModel.fromJson(response?.body).data!.data!);
        submittedAssignmentModel?.data?.currentPage = SubmittedAssignmentModel.fromJson(response?.body).data?.currentPage;
        submittedAssignmentModel?.data?.total = SubmittedAssignmentModel.fromJson(response?.body).data?.total;
      }
      isLoading = false;
    }else{
      ApiChecker.checkApi(response!);
    }
    update();
  }

  int selectedAssignmentTypeIndex = 0;
  void setSelectedAssignmentTypeIndex(int index) {
    selectedAssignmentTypeIndex = index;
    update();
  }

}