import 'dart:ui';

class PanelModel {
  String? title;
  String? subtitle;
  Color? cardColor;

  PanelModel({this.title, this.subtitle, this.cardColor});

  PanelModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    subtitle = json['subtitle'];
    cardColor = json['cardColor'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['subtitle'] = subtitle;
    data['cardColor'] = cardColor;
    return data;
  }
}
