class PeriodModel {
  bool? status;
  String? message;
  Data? data;


  PeriodModel({this.status, this.message, this.data});

  PeriodModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

}

class Data {
  int? currentPage;
  List<PeriodItem>? data;
  int? total;

  Data(
      {this.currentPage,
        this.data,
        this.total});

  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <PeriodItem>[];
      json['data'].forEach((v) {
        data!.add(PeriodItem.fromJson(v));
      });
    }
    total = json['total'];
  }

}

class PeriodItem {
  int? id;
  String? period;
  String? serialNo;

  PeriodItem({this.id, this.period, this.serialNo});

  PeriodItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    period = json['period'];
    serialNo = json['serial_no'].toString();
  }

}

