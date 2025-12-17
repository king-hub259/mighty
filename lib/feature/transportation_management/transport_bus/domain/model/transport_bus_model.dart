class TransportBusModel {
  bool? status;
  String? message;
  Data? data;

  TransportBusModel({this.status, this.message, this.data});

  TransportBusModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
}

class Data {
  int? currentPage;
  List<TransportBusItem>? data;
  int? total;

  Data({this.currentPage, this.data, this.total});

  Data.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    if (json['data'] != null) {
      data = <TransportBusItem>[];
      json['data'].forEach((v) {
        data!.add(TransportBusItem.fromJson(v));
      });
    }
    total = json['total'];
  }
}

class TransportBusItem {
  int? id;
  String? busNumber;
  String? busModel;
  String? busCapacity;
  String? driverId;
  String? routeId;
  String? status;
  String? registrationNumber;
  String? insuranceNumber;
  String? insuranceExpiry;
  String? fitnessExpiry;
  String? createdAt;
  String? updatedAt;
  TransportDriver? driver;
  TransportRoute? route;

  TransportBusItem({
    this.id,
    this.busNumber,
    this.busModel,
    this.busCapacity,
    this.driverId,
    this.routeId,
    this.status,
    this.registrationNumber,
    this.insuranceNumber,
    this.insuranceExpiry,
    this.fitnessExpiry,
    this.createdAt,
    this.updatedAt,
    this.driver,
    this.route,
  });

  TransportBusItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    busNumber = json['bus_number'];
    busModel = json['bus_model'];
    busCapacity = json['bus_capacity'].toString();
    driverId = json['driver_id'].toString();
    routeId = json['route_id'].toString();
    status = json['status'];
    registrationNumber = json['registration_number'];
    insuranceNumber = json['insurance_number'];
    insuranceExpiry = json['insurance_expiry'];
    fitnessExpiry = json['fitness_expiry'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    driver = json['driver'] != null ? TransportDriver.fromJson(json['driver']) : null;
    route = json['route'] != null ? TransportRoute.fromJson(json['route']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['bus_number'] = busNumber;
    data['bus_model'] = busModel;
    data['bus_capacity'] = busCapacity;
    data['driver_id'] = driverId;
    data['route_id'] = routeId;
    data['status'] = status;
    data['registration_number'] = registrationNumber;
    data['insurance_number'] = insuranceNumber;
    data['insurance_expiry'] = insuranceExpiry;
    data['fitness_expiry'] = fitnessExpiry;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (driver != null) {
      data['driver'] = driver!.toJson();
    }
    if (route != null) {
      data['route'] = route!.toJson();
    }
    return data;
  }
}

class TransportDriver {
  int? id;
  String? name;
  String? phone;
  String? licenseNumber;

  TransportDriver({this.id, this.name, this.phone, this.licenseNumber});

  TransportDriver.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    phone = json['phone'];
    licenseNumber = json['license_number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['phone'] = phone;
    data['license_number'] = licenseNumber;
    return data;
  }
}

class TransportRoute {
  int? id;
  String? routeName;
  String? routeCode;

  TransportRoute({this.id, this.routeName, this.routeCode});

  TransportRoute.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    routeName = json['route_name'];
    routeCode = json['route_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['route_name'] = routeName;
    data['route_code'] = routeCode;
    return data;
  }
}