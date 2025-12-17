class MigrationBody {
  List<int>? classId;
  int? sectionId;
  String? type;
  List<int>? users;
  List<int>? prevRoll;
  List<int>? registerNo;
  List<int>? newRoll;
  List<int>? sessionTableId;
  int? academicYear;
  int? migrateClassId;
  int? groupId;
  int? migrateSectionId;

  MigrationBody(
      {this.classId,
        this.sectionId,
        this.type,
        this.users,
        this.prevRoll,
        this.registerNo,
        this.newRoll,
        this.sessionTableId,
        this.academicYear,
        this.migrateClassId,
        this.groupId,
        this.migrateSectionId});

  MigrationBody.fromJson(Map<String, dynamic> json) {
    classId = json['class_id'].cast<int>();
    sectionId = json['section_id'];
    type = json['type'];
    users = json['users'].cast<int>();
    prevRoll = json['prev_roll'].cast<int>();
    registerNo = json['register_no'].cast<int>();
    newRoll = json['new_roll'].cast<int>();
    sessionTableId = json['session_table_id'].cast<int>();
    academicYear = json['academic_year'];
    migrateClassId = json['migrate_class_id'];
    groupId = json['group_id'];
    migrateSectionId = json['migrate_section_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['class_id'] = classId;
    data['section_id'] = sectionId;
    data['type'] = type;
    data['users'] = users;
    data['prev_roll'] = prevRoll;
    data['register_no'] = registerNo;
    data['new_roll'] = newRoll;
    data['session_table_id'] = sessionTableId;
    data['academic_year'] = academicYear;
    data['migrate_class_id'] = migrateClassId;
    data['group_id'] = groupId;
    data['migrate_section_id'] = migrateSectionId;
    return data;
  }
}
