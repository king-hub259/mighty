class SmartCollectionDetailsModel {
  bool? status;
  String? message;
  SmartItem? data;
  

  SmartCollectionDetailsModel({this.status, this.message, this.data});

  SmartCollectionDetailsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? SmartItem.fromJson(json['data']) : null;

  }

 
}

class SmartItem {
  StudentSession? studentSession;
  List<FeeHeads>? feeHeads;
  String? totalFee;
  String? totalFine;
  List<CashLedgers>? cashLedgers;

  SmartItem({this.studentSession,
        this.feeHeads,
        this.totalFee,
        this.totalFine,
        this.cashLedgers});

  SmartItem.fromJson(Map<String, dynamic> json) {
    studentSession = json['studentSession'] != null ? StudentSession.fromJson(json['studentSession']) : null;
    if (json['feeHeads'] != null) {
      feeHeads = <FeeHeads>[];
      json['feeHeads'].forEach((v) {
        feeHeads!.add(FeeHeads.fromJson(v));
      });
    }
    totalFee = json['total_fee'];
    totalFine = json['total_fine'];
    if (json['cashLedgers'] != null) {
      cashLedgers = <CashLedgers>[];
      json['cashLedgers'].forEach((v) {
        cashLedgers!.add(CashLedgers.fromJson(v));
      });
    }
  }

  
}

class StudentSession {
  int? id;
  String? sessionId;
  String? studentId;
  String? classId;
  String? sectionId;
  String? roll;
  Student? student;

  StudentSession(
      {this.id,
        this.sessionId,
        this.studentId,
        this.classId,
        this.sectionId,
        this.roll,
        this.student});

  StudentSession.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    sessionId = json['session_id'].toString();
    studentId = json['student_id'].toString();
    classId = json['class_id'].toString();
    sectionId = json['section_id'].toString();
    roll = json['roll'];
    student = json['student'] != null ? Student.fromJson(json['student']) : null;
  }
  
}

class Student {
  int? id;
  String? userId;
  String? group;
  String? studentCategoryId;
  String? firstName;
  String? lastName;
  String? phone;
  String? registerNo;
  String? rollNo;
  String? fatherName;
  String? motherName;
  StudentGroup? studentGroup;
  StudentCategory? studentCategory;



  Student(
      {this.id,
        this.userId,
        this.group,
        this.studentCategoryId,
        this.firstName,
        this.lastName,
        this.phone,
        this.registerNo,
        this.rollNo,
        this.fatherName,
        this.motherName,
        this.studentGroup,
        this.studentCategory
      });

  Student.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'].toString();
    group = json['group'];
    studentCategoryId = json['student_category_id'].toString();
    firstName = json['first_name'];
    lastName = json['last_name'];
    phone = json['phone'];
    registerNo = json['register_no'].toString();
    rollNo = json['roll_no'].toString();
    fatherName = json['father_name'];
    motherName = json['mother_name'];
    studentGroup = json['student_group'] != null
        ? StudentGroup.fromJson(json['student_group'])
        : null;
    studentCategory = json['student_category'] != null
        ? StudentCategory.fromJson(json['student_category'])
        : null;
  }

  //toJson
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'group': group,
     'student_category_id': studentCategoryId,
      'first_name': firstName,
      'last_name': lastName,
      'phone': phone,
     'register_no': registerNo,
      'roll_no': rollNo,
      'father_name': fatherName,
     'mother_name': motherName,
     'student_group': studentGroup?.toJson(),
     'student_category': studentCategory?.toJson()
    };
  }

}

class StudentGroup {
  int? id;
  String? groupName;

  StudentGroup({this.id, this.groupName});

  StudentGroup.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    groupName = json['group_name'];

  }

  //toJson
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'group_name': groupName,
    };
  }

}

class StudentCategory {
  int? id;
  String? name;


  StudentCategory({this.id, this.name});

  StudentCategory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  //toJson
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }

}


class FeeHeads {
  int? id;
  String? name;
  List<FeeSubHeads>? feeSubHeads;


  FeeHeads({this.id, this.name, this.feeSubHeads});

  FeeHeads.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    if (json['feeSubHeads'] != null) {
      feeSubHeads = <FeeSubHeads>[];
      json['feeSubHeads'].forEach((v) {
        feeSubHeads!.add(FeeSubHeads.fromJson(v));
      });
    }
    if (json['fee_sub_heads'] != null) {
      feeSubHeads = <FeeSubHeads>[];
      json['fee_sub_heads'].forEach((v) {
        feeSubHeads!.add(FeeSubHeads.fromJson(v));
      });
    }
  }
  
}

class FeeSubHeads {
  int? id;
  String? name;
  String? serial;
  bool? selected;


  FeeSubHeads({this.id, this.name, this.serial,this.selected});

  FeeSubHeads.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    serial = json['serial'].toString();
    selected = false;
  }
  
}


class CashLedgers {
  int? id;
  String? ledgerName;
  String? accountingCategoryId;
  String? accountingGroupId;
  String? balance;
  String? type;


  CashLedgers(
      {this.id,
        this.ledgerName,
        this.accountingCategoryId,
        this.accountingGroupId,
        this.balance,
        this.type});

  CashLedgers.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    ledgerName = json['ledger_name'];
    accountingCategoryId = json['accounting_category_id'].toString();
    accountingGroupId = json['accounting_group_id'].toString();
    balance = json['balance'];
    type = json['type'];

  }

}
