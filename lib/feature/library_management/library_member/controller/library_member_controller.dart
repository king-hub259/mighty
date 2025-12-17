
import 'package:get/get.dart';
import 'package:mighty_school/api_handle/api_checker.dart';
import 'package:mighty_school/feature/library_management/library_member/domain/model/library_member_model.dart';
import 'package:mighty_school/feature/library_management/library_member/domain/repository/library_member_repository.dart';

class LibraryMemberController extends GetxController implements GetxService{
  final LibraryMemberRepository libraryMemberRepository;
  LibraryMemberController({required this.libraryMemberRepository});

  LibraryMemberModel? libraryMemberModel;
  Future<void> getMemberList(int page) async {
    Response? response = await libraryMemberRepository.getMemberList(page);
    if(response?.statusCode == 200){
      if(page == 1){
        libraryMemberModel = LibraryMemberModel.fromJson(response?.body);
      }else{
        libraryMemberModel?.data?.data?.addAll(LibraryMemberModel.fromJson(response?.body).data!.data!);
        libraryMemberModel?.data?.currentPage = LibraryMemberModel.fromJson(response?.body).data?.currentPage;
        libraryMemberModel?.data?.total = LibraryMemberModel.fromJson(response?.body).data?.total;

      }

    }else{
      ApiChecker.checkApi(response!);
    }
    update();

  }

  LibraryMemberItem? selectedMemberItem;
  void selectMember(LibraryMemberItem memberItem){
    selectedMemberItem = memberItem;
    update();
  }

  void clearMember(){
    selectedMemberItem = null;
    update();
  }

}