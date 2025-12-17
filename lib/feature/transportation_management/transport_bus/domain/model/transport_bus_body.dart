class TransportBusBody {
  String? busNumber;
  String? busModel;
  int? busCapacity;
  int? driverId;
  int? routeId;
  String? status;
  String? registrationNumber;
  String? insuranceNumber;
  String? insuranceExpiry;
  String? fitnessExpiry;

  TransportBusBody({
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
  });

  TransportBusBody.fromJson(Map<String, dynamic> json) {
    busNumber = json['bus_number'];
    busModel = json['bus_model'];
    busCapacity = json['bus_capacity'];
    driverId = json['driver_id'];
    routeId = json['route_id'];
    status = json['status'];
    registrationNumber = json['registration_number'];
    insuranceNumber = json['insurance_number'];
    insuranceExpiry = json['insurance_expiry'];
    fitnessExpiry = json['fitness_expiry'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
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
    return data;
  }
}
