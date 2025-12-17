
class MobileAppItem {
  int? id;
  int? instituteId;
  String? title;
  String? heading;
  String? description;
  String? image;
  String? featureOne;
  String? featureTwo;
  String? featureThree;
  String? playStoreLink;
  String? appStoreLink;
  String? createdAt;
  String? updatedAt;

  MobileAppItem(
      {this.id,
        this.instituteId,
        this.title,
        this.heading,
        this.description,
        this.image,
        this.featureOne,
        this.featureTwo,
        this.featureThree,
        this.playStoreLink,
        this.appStoreLink,
        this.createdAt,
        this.updatedAt});

  MobileAppItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    instituteId = json['institute_id'];
    title = json['title'];
    heading = json['heading'];
    description = json['description'];
    image = json['image'];
    featureOne = json['feature_one'];
    featureTwo = json['feature_two'];
    featureThree = json['feature_three'];
    playStoreLink = json['play_store_link'];
    appStoreLink = json['app_store_link'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['institute_id'] = instituteId;
    data['title'] = title;
    data['heading'] = heading;
    data['description'] = description;
    data['image'] = image;
    data['feature_one'] = featureOne;
    data['feature_two'] = featureTwo;
    data['feature_three'] = featureThree;
    data['play_store_link'] = playStoreLink;
    data['app_store_link'] = appStoreLink;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}


