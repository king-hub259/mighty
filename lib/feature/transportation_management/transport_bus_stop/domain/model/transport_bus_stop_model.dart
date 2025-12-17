class TransportBusStopModel {
  bool? status;
  String? message;
  Data? data;

  TransportBusStopModel({this.status, this.message, this.data});

  TransportBusStopModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
}

class Data {
  int? currentPage;
  List<TransportBusStopItem>? data;
  int? total;

  Data({this.currentPage, this.data, this.total});

  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <TransportBusStopItem>[];
      json['data'].forEach((v) {
        data!.add(TransportBusStopItem.fromJson(v));
      });
    }
    total = json['total'];
  }
}

class TransportBusStopItem {
  int? id;
  String? stopName;
  String? stopCode;
  String? address;
  String? latitude;
  String? longitude;
  String? landmark;
  String? status;
  String? description;
  String? createdAt;
  String? updatedAt;
  List<RouteStop>? routeStops;

  TransportBusStopItem({
    this.id,
    this.stopName,
    this.stopCode,
    this.address,
    this.latitude,
    this.longitude,
    this.landmark,
    this.status,
    this.description,
    this.createdAt,
    this.updatedAt,
    this.routeStops,
  });

  TransportBusStopItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    stopName = json['stop_name'];
    stopCode = json['stop_code'];
    address = json['address'];
    latitude = json['latitude'].toString();
    longitude = json['longitude'].toString();
    landmark = json['landmark'];
    status = json['status'];
    description = json['description'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['route_stops'] != null) {
      routeStops = <RouteStop>[];
      json['route_stops'].forEach((v) {
        routeStops!.add(RouteStop.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['stop_name'] = stopName;
    data['stop_code'] = stopCode;
    data['address'] = address;
    data['latitude'] = latitude;
    data['longitude'] = longitude;
    data['landmark'] = landmark;
    data['status'] = status;
    data['description'] = description;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (routeStops != null) {
      data['route_stops'] = routeStops!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class RouteStop {
  int? id;
  String? routeName;
  String? arrivalTime;

  RouteStop({this.id, this.routeName, this.arrivalTime});

  RouteStop.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    routeName = json['route_name'];
    arrivalTime = json['arrival_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['route_name'] = routeName;
    data['arrival_time'] = arrivalTime;
    return data;
  }
}