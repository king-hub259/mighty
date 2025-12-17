class HostelCategoryBody {
  String? hostelId;
  String? standard;
  String? price;
  String? sMethod;

  HostelCategoryBody({
    this.hostelId,
    this.standard,
    this.price,
    this.sMethod
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['hostel_id'] = hostelId;
    data['standard'] = standard;
    data['hostel_fee'] = price;
    data['_method'] = sMethod;
    return data;
  }
}
