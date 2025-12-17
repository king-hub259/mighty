class TransportBusRouteModel {
  bool? status;
  String? message;
  Data? data;

  TransportBusRouteModel({this.status, this.message, this.data});

  TransportBusRouteModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
}

class Data {
  int? currentPage;
  List<TransportBusRouteItem>? data;
  int? total;

  Data({this.currentPage, this.data, this.total});

  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <TransportBusRouteItem>[];
      json['data'].forEach((v) {
        data!.add(TransportBusRouteItem.fromJson(v));
      });
    }
    total = json['total'];
  }
}

class TransportBusRouteItem {
  int? id;
  String? routeName;
  String? routeCode;
  String? startLocation;
  String? endLocation;
  String? distance;
  String? duration;
  String? fare;
  String? status;
  String? description;
  String? createdAt;
  String? updatedAt;
  List<BusStop>? busStops;

  TransportBusRouteItem({
    this.id,
    this.routeName,
    this.routeCode,
    this.startLocation,
    this.endLocation,
    this.distance,
    this.duration,
    this.fare,
    this.status,
    this.description,
    this.createdAt,
    this.updatedAt,
    this.busStops,
  });

  TransportBusRouteItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    routeName = json['route_name'];
    routeCode = json['route_code'];
    startLocation = json['start_location'];
    endLocation = json['end_location'];
    distance = json['distance'].toString();
    duration = json['duration'].toString();
    fare = json['fare'].toString();
    status = json['status'];
    description = json['description'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    if (json['bus_stops'] != null) {
      busStops = <BusStop>[];
      json['bus_stops'].forEach((v) {
        busStops!.add(BusStop.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['route_name'] = routeName;
    data['route_code'] = routeCode;
    data['start_location'] = startLocation;
    data['end_location'] = endLocation;
    data['distance'] = distance;
    data['duration'] = duration;
    data['fare'] = fare;
    data['status'] = status;
    data['description'] = description;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (busStops != null) {
      data['bus_stops'] = busStops!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BusStop {
  int? id;
  String? stopName;
  String? stopCode;
  String? arrivalTime;

  BusStop({this.id, this.stopName, this.stopCode, this.arrivalTime});

  BusStop.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    stopName = json['stop_name'];
    stopCode = json['stop_code'];
    arrivalTime = json['arrival_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['stop_name'] = stopName;
    data['stop_code'] = stopCode;
    data['arrival_time'] = arrivalTime;
    return data;
  }
}