class RoleBody {
  String? name;
  String? description;
  List<String>? permissions;

  RoleBody({this.name, this.description, this.permissions});

  RoleBody.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    description = json['description'];
    permissions = json['permissions'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['description'] = description;
    data['permissions'] = permissions;
    return data;
  }
}
