class SubHeadWiseCollectionBody {
  String? studentId;
  List<FeeHeadId>? feeHeadId;

  SubHeadWiseCollectionBody({this.studentId, this.feeHeadId});

  SubHeadWiseCollectionBody.fromJson(Map<String, dynamic> json) {
    studentId = json['student_id'];
    if (json['fee_head_id'] != null) {
      feeHeadId = <FeeHeadId>[];
      json['fee_head_id'].forEach((v) {
        feeHeadId!.add(FeeHeadId.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['student_id'] = studentId;
    if (feeHeadId != null) {
      data['fee_head_id'] = feeHeadId!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FeeHeadId {
  int? id;
  List<int>? feeSubHeadIds;

  FeeHeadId({this.id, this.feeSubHeadIds});

  FeeHeadId.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    feeSubHeadIds = json['fee_sub_head_ids'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['fee_sub_head_ids'] = feeSubHeadIds;
    return data;
  }
}
