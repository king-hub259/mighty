import 'package:get/get_connect/http/src/response/response.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mighty_school/api_handle/api_client.dart';
import 'package:mighty_school/feature/hostel_management/hostel/domain/model/hostel_body.dart';
import 'package:mighty_school/util/app_constants.dart';

class HostelRepository {
  final ApiClient apiClient;

  HostelRepository({required this.apiClient});

  Future<Response?> getHostelList(int page) async {
    return await apiClient.getData("${AppConstants.hostels}?per_page=20&page=$page");
  }

  Future<Response?> addNewHostel(HostelBody body,) async {
    return await apiClient.postData(AppConstants.hostels, body.toJson());
  }

  Future<Response?> updateHostel(int id, HostelBody hostelBody) async {
    return await apiClient.postData("${AppConstants.hostels}/$id", hostelBody.toJson());
  }

  Future<Response?> deleteHostel(int id) async {
    return await apiClient.deleteData("${AppConstants.hostels}/$id");
  }

  Future<Response?> getHostelDetails(int id) async {
    return await apiClient.getData("${AppConstants.hostels}/$id");
  }
}
  