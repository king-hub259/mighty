import 'package:get/get_connect/http/src/response/response.dart';
import 'package:mighty_school/api_handle/api_client.dart';
import 'package:mighty_school/feature/fees_management/smart_collection/domain/model/smart_collection_body.dart';
import 'package:mighty_school/feature/fees_management/smart_collection/domain/model/sub_head_wise_collection_body.dart';
import 'package:mighty_school/util/app_constants.dart';

class SmartCollectionRepository{
  final ApiClient apiClient;
  SmartCollectionRepository({required this.apiClient});

  Future<Response?> getStudentListForSmartCollection(int classId, int sectionId, int page ) async {
    return await apiClient.getData("${AppConstants.smartCollection}?class_id=$classId&section_id=$sectionId&per_page=50&page=$page");
  }

  Future<Response?> getSmartCollectionDetails(int id ) async {
    return await apiClient.getData("${AppConstants.smartCollection}/$id");
  }

  Future<Response?> getSubHeadWiseCalculation(SubHeadWiseCollectionBody subHeadWiseBody ) async {
      return await apiClient.postData(AppConstants.subHeadWiseCalculation, subHeadWiseBody.toJson());
    }

  Future<Response?> getAttendanceFine(int id) async {
    return await apiClient.getData("${AppConstants.attendanceFine}$id");
  }

  Future<Response?> labFine(int id) async {
    return await apiClient.getData("${AppConstants.labFine}$id");
  }
  Future<Response?> quizFile(int id) async {
    return await apiClient.getData("${AppConstants.quizFine}$id");
  }
  Future<Response?> tcAmount() async {
    return await apiClient.getData(AppConstants.tcAmount);
  }

  Future<Response?> collectSmartCollection(SmartCollectionBody smartCollectionBody ) async {
    return await apiClient.postData(AppConstants.smartCollection, smartCollectionBody.toJson());
  }


}