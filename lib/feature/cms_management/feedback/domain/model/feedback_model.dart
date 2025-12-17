class FeedbackModel {
  bool? status;
  String? message;
  Data? data;

  FeedbackModel({this.status, this.message, this.data});

  FeedbackModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? currentPage;
  List<FeedbackItem>? data;
  int? total;

  Data({this.currentPage, this.data, this.total});

  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <FeedbackItem>[];
      json['data'].forEach((v) {
        data!.add(FeedbackItem.fromJson(v));
      });
    }
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['current_page'] = currentPage;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['total'] = total;
    return data;
  }
}

class FeedbackItem {
  int? id;
  int? instituteId;
  String? name;
  String? university;
  int? rank;
  String? videoUrl;
  String? thumbnailImage;
  String? description;
  int? status;
  String? createdAt;

  FeedbackItem(
      {this.id,
        this.instituteId,
        this.name,
        this.university,
        this.rank,
        this.videoUrl,
        this.thumbnailImage,
        this.description,
        this.status,
        this.createdAt});

  FeedbackItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    instituteId = json['institute_id'];
    name = json['name'];
    university = json['university'];
    rank = json['rank'];
    videoUrl = json['video_url'];
    thumbnailImage = json['thumbnail_image'];
    description = json['description'];
    status = json['status'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['institute_id'] = instituteId;
    data['name'] = name;
    data['university'] = university;
    data['rank'] = rank;
    data['video_url'] = videoUrl;
    data['thumbnail_image'] = thumbnailImage;
    data['description'] = description;
    data['status'] = status;
    data['created_at'] = createdAt;
    return data;
  }
}


