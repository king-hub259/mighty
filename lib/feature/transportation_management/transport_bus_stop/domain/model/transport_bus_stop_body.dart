class TransportBusStopBody {
  String? stopName;
  String? stopCode;
  String? address;
  String? latitude;
  String? longitude;
  String? landmark;
  String? status;
  String? description;

  TransportBusStopBody({
    this.stopName,
    this.stopCode,
    this.address,
    this.latitude,
    this.longitude,
    this.landmark,
    this.status,
    this.description,
  });

  TransportBusStopBody.fromJson(Map<String, dynamic> json) {
    stopName = json['stop_name'];
    stopCode = json['stop_code'];
    address = json['address'];
    latitude = json['latitude'];
    longitude = json['longitude'];
    landmark = json['landmark'];
    status = json['status'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['stop_name'] = stopName;
    data['stop_code'] = stopCode;
    data['address'] = address;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['landmark'] = landmark;
    data['status'] = status;
    data['description'] = description;
    return data;
  }
}
