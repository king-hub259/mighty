class ConfigModel {
  bool? success;
  int? statusCode;
  String? message;
  Config? data;


  ConfigModel(
      {this.success, this.statusCode, this.message, this.data});

  ConfigModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    statusCode = json['status_code'];
    message = json['message'];
    data = json['data'] != null ? Config.fromJson(json['data']) : null;

  }
}

class Config {
  String? balance;
  String? currency;

  Config({this.balance, this.currency});

  Config.fromJson(Map<String, dynamic> json) {
    balance = json['balance'].toString();
    currency = json['currency'];
  }

}
