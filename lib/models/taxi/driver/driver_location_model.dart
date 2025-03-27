class DriverLocationModel {
  final int driverId;
  final double latitude;
  final double longitude;
  final bool isAvailable;

  DriverLocationModel({
    required this.driverId,
    required this.latitude,
    required this.longitude,
    required this.isAvailable,
  });

  // Convert model to JSON for API request
  Map<String, dynamic> toJson() {
    return {
      "driver_id": driverId,
      "current_location": {
        "lat": latitude,
        "long": longitude
      },
      "is_available": isAvailable
    };
  }

  // Convert JSON response to DriverLocation model
  factory DriverLocationModel.fromJson(Map<String, dynamic> json) {
    return DriverLocationModel(
      driverId: json["driver_id"] ?? 0,
      latitude: (json["current_location"]["lat"] ?? 0.0).toDouble(),
      longitude: (json["current_location"]["long"] ?? 0.0).toDouble(),
      isAvailable: json["is_available"] ?? false,
    );
  }

}
