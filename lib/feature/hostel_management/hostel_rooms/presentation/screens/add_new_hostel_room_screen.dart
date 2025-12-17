import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mighty_school/common/widget/custom_app_bar.dart';
import 'package:mighty_school/common/widget/custom_button.dart';
import 'package:mighty_school/common/widget/custom_snackbar.dart';
import 'package:mighty_school/common/widget/custom_text_field.dart';
import 'package:mighty_school/feature/hostel_management/hostel_categories/domain/model/hostel_category_model.dart';
import 'package:mighty_school/feature/hostel_management/hostel_categories/logic/hostel_categories_controller.dart';
import 'package:mighty_school/feature/hostel_management/hostel_categories/presentation/widgets/select_hostel_category_widget.dart';
import 'package:mighty_school/feature/hostel_management/hostel_rooms/domain/model/hostel_room_body.dart';
import 'package:mighty_school/feature/hostel_management/hostel_rooms/domain/model/hostel_room_model.dart';
import 'package:mighty_school/feature/hostel_management/hostel_rooms/logic/hostel_rooms_controller.dart';
import 'package:mighty_school/util/app_constants.dart';
import 'package:mighty_school/util/dimensions.dart';

class AddNewHostelRoomScreen extends StatefulWidget {
  final HostelRoomItem? roomItem;

  const AddNewHostelRoomScreen({super.key, this.roomItem});

  @override
  State<AddNewHostelRoomScreen> createState() => _AddNewHostelRoomScreenState();
}

class _AddNewHostelRoomScreenState extends State<AddNewHostelRoomScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController roomNumberController = TextEditingController();
  final TextEditingController capacityController = TextEditingController();

  @override
  void initState() {
    roomNumberController.text = widget.roomItem?.roomNumber??'';
    capacityController.text = widget.roomItem?.capacity?.toString()??'';
    // Get.find<HostelCategoriesController>().setSelectedHostelCategory(HostelCategoryItem(
    //   id: widget.roomItem?.hostelCategoryId,
    //   standard: widget.roomItem.
    // ));

    super.initState();

  }


  @override
  Widget build(BuildContext context) {
    return Dialog(insetPadding: const EdgeInsets.all(Dimensions.paddingSizeDefault,),
      child: GetBuilder<HostelRoomsController>(
        builder: (roomsController) {

          return Padding(
            padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
            child: Form(key: formKey,
              child: Column(mainAxisSize: MainAxisSize.min, spacing: Dimensions.paddingSizeDefault,
                crossAxisAlignment: CrossAxisAlignment.start, children: [

                  const SelectHostelCategoryWidget(),

                  CustomTextField(controller: roomNumberController,
                      title: "room_number".tr,
                      hintText: "enter_room_number".tr),

                  CustomTextField(
                    controller: capacityController,
                    title: "capacity".tr,
                    hintText: "enter_capacity".tr,
                    inputType: TextInputType.number,
                    inputFormatters: [AppConstants.numberFormat],
                  ),
                  const SizedBox(height: Dimensions.paddingSizeDefault),


                  GetBuilder<HostelRoomsController>(
                      builder: (hostelRoomController) {
                        return hostelRoomController.isLoading?const Center(child: CircularProgressIndicator(),):
                        CustomButton(onTap: (){
                          String? hostelCategoryId = Get.find<HostelCategoriesController>().selectedCategoryItem?.id.toString();
                          String? roomNumber = roomNumberController.text.trim();
                          String? capacity = capacityController.text.trim();

                          if(hostelCategoryId == null){
                            showCustomSnackBar("select_hostel_category".tr);
                          }else if(roomNumber.isEmpty){
                            showCustomSnackBar("room_number_is_empty".tr);
                          }else if(capacity.isEmpty){
                            showCustomSnackBar("capacity_is_empty".tr);
                          }else{
                            HostelRoomBody body = HostelRoomBody(
                              categoryId: hostelCategoryId,
                              roomNumber: roomNumber,
                              capacity: capacity,

                            );
                            if(widget.roomItem != null){
                              hostelRoomController.updateHostelRoom(widget.roomItem!.id!, body);
                            }else{
                              hostelRoomController.addNewHostelRoom(body);
                            }}

                        }, text: widget.roomItem != null? "update".tr : "save".tr);
                      }
                  )


                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
