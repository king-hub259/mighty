class MobileAppBody {
  String? title;
  String? heading;
  String? description;
  String? featureOne;
  String? featureTwo;
  String? featureThree;
  String? playStoreLink;
  String? appStoreLink;
  String? sMethod;

  MobileAppBody(
      {this.title,
        this.heading,
        this.description,
        this.featureOne,
        this.featureTwo,
        this.featureThree,
        this.playStoreLink,
        this.appStoreLink,
        this.sMethod});

  MobileAppBody.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    heading = json['heading'];
    description = json['description'];
    featureOne = json['feature_one'];
    featureTwo = json['feature_two'];
    featureThree = json['feature_three'];
    playStoreLink = json['play_store_link'];
    appStoreLink = json['app_store_link'];
    sMethod = json['_method'];
  }

  Map<String, String> toJson() {
    final Map<String, String> data = <String, String>{};
    data['title'] = title ?? '';
    data['heading'] = heading ?? '';
    data['description'] = description ?? '';
    data['feature_one'] = featureOne ?? '';
    data['feature_two'] = featureTwo ?? '';
    data['feature_three'] = featureThree ?? '';
    data['play_store_link'] = playStoreLink ?? '';
    data['app_store_link'] = appStoreLink ?? '';
    data['_method'] = sMethod ?? 'POST';
    return data;
  }

}
