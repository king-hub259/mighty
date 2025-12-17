
import 'package:mighty_school/helper/price_converter.dart';

class HostelCategoryItem {
  int? id;
  int? instituteId;
  int? branchId;
  int? hostelId;
  String? standard;
  double? hostelFee;
  String? note;
  String? createdAt;
  String? updatedAt;
  String? hostelName;
  String? type;
  String? address;

  HostelCategoryItem(
      {this.id,
        this.instituteId,
        this.branchId,
        this.hostelId,
        this.standard,
        this.hostelFee,
        this.note,
        this.createdAt,
        this.updatedAt,
        this.hostelName,
        this.type,
        this.address});

  HostelCategoryItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    instituteId = json['institute_id'];
    branchId = json['branch_id'];
    hostelId = json['hostel_id'];
    standard = json['standard'];
    hostelFee = PriceConverter.parseAmount(json['hostel_fee']);
    note = json['note'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    hostelName = json['hostel_name'];
    type = json['type'];
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['institute_id'] = instituteId;
    data['branch_id'] = branchId;
    data['hostel_id'] = hostelId;
    data['standard'] = standard;
    data['hostel_fee'] = hostelFee;
    data['note'] = note;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['hostel_name'] = hostelName;
    data['type'] = type;
    data['address'] = address;
    return data;
  }
}
