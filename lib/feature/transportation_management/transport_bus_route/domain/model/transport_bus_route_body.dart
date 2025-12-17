class TransportBusRouteBody {
  String? routeName;
  String? routeCode;
  String? startLocation;
  String? endLocation;
  String? distance;
  String? duration;
  String? fare;
  String? status;
  String? description;

  TransportBusRouteBody({
    this.routeName,
    this.routeCode,
    this.startLocation,
    this.endLocation,
    this.distance,
    this.duration,
    this.fare,
    this.status,
    this.description,
  });

  TransportBusRouteBody.fromJson(Map<String, dynamic> json) {
    routeName = json['route_name'];
    routeCode = json['route_code'];
    startLocation = json['start_location'];
    endLocation = json['end_location'];
    distance = json['distance'];
    duration = json['duration'];
    fare = json['fare'];
    status = json['status'];
    description = json['description'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['route_name'] = routeName;
    data['route_code'] = routeCode;
    data['start_location'] = startLocation;
    data['end_location'] = endLocation;
    data['distance'] = distance;
    data['duration'] = duration;
    data['fare'] = fare;
    data['status'] = status;
    data['description'] = description;
    return data;
  }
}
