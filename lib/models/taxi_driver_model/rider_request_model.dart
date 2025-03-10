class RideRequest {
  final int travelId;
  final Location pickupLocation;
  final Location destinationLocation;
  final User user;

  RideRequest({
    required this.travelId,
    required this.pickupLocation,
    required this.destinationLocation,
    required this.user,
  });

  factory RideRequest.fromJson(Map<String, dynamic> json) {
    return RideRequest(
      travelId: json["travel_id"],
      pickupLocation: Location.fromJson(json["pickup_location"]),
      destinationLocation: Location.fromJson(json["destination_location"]),
      user: User.fromJson(json["user"]),
    );
  }
}

class Location {
  final double latitude;
  final double longitude;

  Location({required this.latitude, required this.longitude});

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      latitude: json["latitude"].toDouble(),
      longitude: json["longitude"].toDouble(),
    );
  }
}

class User {
  final String name;
  final String phoneNo;

  User({required this.name, required this.phoneNo});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      name: json["name"],
      phoneNo: json["phone_no"],
    );
  }
}
