class MobileAppModel {
  bool? status;
  String? message;
  List<MobileItem>? data;

  MobileAppModel({this.status, this.message, this.data});

  MobileAppModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['data'] != null) {
      data = <MobileItem>[];
      json['data'].forEach((v) {
        data!.add(MobileItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class MobileItem {
  int? id;
  int? instituteId;
  int? branchId;
  String? title;
  String? heading;
  String? description;
  String? image;
  String? featureOne;
  String? featureTwo;
  String? featureThree;
  String? playStoreLink;
  String? appStoreLink;

  MobileItem(
      {this.id,
        this.instituteId,
        this.branchId,
        this.title,
        this.heading,
        this.description,
        this.image,
        this.featureOne,
        this.featureTwo,
        this.featureThree,
        this.playStoreLink,
        this.appStoreLink});

  MobileItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    instituteId = json['institute_id'];
    branchId = json['branch_id'];
    title = json['title'];
    heading = json['heading'];
    description = json['description'];
    image = json['image'];
    featureOne = json['feature_one'];
    featureTwo = json['feature_two'];
    featureThree = json['feature_three'];
    playStoreLink = json['play_store_link'];
    appStoreLink = json['app_store_link'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['institute_id'] = instituteId;
    data['branch_id'] = branchId;
    data['title'] = title;
    data['heading'] = heading;
    data['description'] = description;
    data['image'] = image;
    data['feature_one'] = featureOne;
    data['feature_two'] = featureTwo;
    data['feature_three'] = featureThree;
    data['play_store_link'] = playStoreLink;
    data['app_store_link'] = appStoreLink;
    return data;
  }
}
