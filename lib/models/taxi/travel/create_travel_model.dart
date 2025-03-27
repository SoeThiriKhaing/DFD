class CreateTravelModel {
  final Travel? travel;
  final List<NearbyDriverModel?> nearbyDrivers;

  CreateTravelModel({
    this.travel,
    required this.nearbyDrivers,
  });

  factory CreateTravelModel.fromJson(Map<String, dynamic> json) {
    return CreateTravelModel(
      travel: json['travel'] != null ? Travel.fromJson(json['travel']) : null,
      nearbyDrivers: json['nearby_drivers'] != null
          ? (json['nearby_drivers'] as List)
              .map((driver) => NearbyDriverModel.fromJson(driver))
              .toList()
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'travel': travel?.toJson(),
      'nearby_drivers': nearbyDrivers.map((driver) => driver?.toJson()).toList(),
    };
  }
}

class Travel {
  final int id;
  final int userId;
  final Location? pickup;
  final Location? destination;
  final String status;
  final String createdAt;

  Travel({
    required this.id,
    required this.userId,
    required this.pickup,
    required this.destination,
    required this.status,
    required this.createdAt,
  });

  factory Travel.fromJson(Map<String, dynamic> json) {
    return Travel(
      id: json["id"] ?? 0,
      userId: json["user_id"] ?? 0,
      pickup: json["pickup"] != null ? Location.fromJson(json["pickup"]) : null,
      destination: json["destination"] != null
          ? Location.fromJson(json["destination"])
          : null,
      status: json["status"] ?? "unknown",
      createdAt: json["created_at"] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'pickup': pickup?.toJson(),
      'destination': destination?.toJson(),
      'status': status,
      'created_at': createdAt,
    };
  }
}

class Location {
  final double latitude;
  final double longitude;

  Location({required this.latitude, required this.longitude});

  factory Location.fromJson(Map<String, dynamic> json) {
    return Location(
      latitude: json["latitude"] != null ? double.tryParse(json["latitude"].toString()) ?? 0.0 : 0.0,
      longitude: json["longitude"] != null ? double.tryParse(json["longitude"].toString()) ?? 0.0 : 0.0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}

class NearbyDriverModel {
  final int id;
  final int userId;
  final double latitude;
  final double longitude;
  final bool isAvailable;
  final String createdAt;
  final String updatedAt;
  final int carYear;
  final String carMake;
  final String carModel;
  final String carColour;
  final String licensePlate;
  final String? driverLicenseNumber;
  final String? otherInfo;
  final double distance;
  final DriverUser? user;
  
  NearbyDriverModel({
    required this.id,
    required this.userId,
    required this.latitude,
    required this.longitude,
    required this.isAvailable,
    required this.createdAt,
    required this.updatedAt,
    required this.carYear,
    required this.carMake,
    required this.carModel,
    required this.carColour,
    required this.licensePlate,
    this.driverLicenseNumber,
    this.otherInfo,
    required this.distance,
    this.user,
  });

  factory NearbyDriverModel.fromJson(Map<String, dynamic> json) {
    return NearbyDriverModel(
      id: json['id'] ?? 0,
      userId: json['user_id'] ?? 0,
      latitude: (json['latitude'] ?? 0.0).toDouble(),
      longitude: (json['longitude'] ?? 0.0).toDouble(),
      isAvailable: json['is_available'] == 1,
      createdAt: json['created_at'] ?? "",
      updatedAt: json['updated_at'] ?? "",
      carYear: json['car_year'] ?? 0,
      carMake: json['car_make'] ?? "",
      carModel: json['car_model'] ?? "",
      carColour: json['car_colour'] ?? "",
      licensePlate: json['license_plate'] ?? "",
      driverLicenseNumber: json['driver_license_number'],
      otherInfo: json['other_info'],
      distance: (json['distance'] ?? 0.0).toDouble(),
      user: json["user"] != null ? DriverUser.fromJson(json['user']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'latitude': latitude,
      'longitude': longitude,
      'is_available': isAvailable ? 1 : 0,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'car_year': carYear,
      'car_make': carMake,
      'car_model': carModel,
      'car_colour': carColour,
      'license_plate': licensePlate,
      'driver_license_number': driverLicenseNumber,
      'other_info': otherInfo,
      'distance': distance,
      'user': user?.toJson(),
    };
  }
}

class DriverUser {
  final int id;
  final String name;
  final String email;
  final String? emailVerifiedAt;
  final String? phoneNo;
  final int role;
  final String? gender;
  final int? age;
  final String createdAt;
  final String updatedAt;
  final String? googleId;
  final String? facebookId;
  final String? githubId;
  final String? linkedinId;

  DriverUser({
    required this.id,
    required this.name,
    required this.email,
    this.emailVerifiedAt,
    this.phoneNo,
    required this.role,
    this.gender,
    this.age,
    required this.createdAt,
    required this.updatedAt,
    this.googleId,
    this.facebookId,
    this.githubId,
    this.linkedinId,
  });

  factory DriverUser.fromJson(Map<String, dynamic> json) {
    return DriverUser(
      id: json['id'] ?? 0,
      name: json['name'] ?? "",
      email: json['email'] ?? "",
      emailVerifiedAt: json['email_verified_at'],
      phoneNo: json['phone_no'],
      role: json['role'] ?? 5,
      gender: json['gender'],
      age: json['age'],
      createdAt: json['created_at'] ?? "",
      updatedAt: json['updated_at'] ?? "",
      googleId: json['google_id'],
      facebookId: json['facebook_id'],
      githubId: json['github_id'],
      linkedinId: json['linkedin_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'email_verified_at': emailVerifiedAt,
      'phone_no': phoneNo,
      'role': role,
      'gender': gender,
      'age': age,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'google_id': googleId,
      'facebook_id': facebookId,
      'github_id': githubId,
      'linkedin_id': linkedinId,
    };
  }
}