import 'package:geolocator/geolocator.dart';

class DriverModel {
  final int? id;
  final String name;
  final double price;
  final int userId; // Store only user ID instead of UserModel
  final double latitude;
  final double longitude;
  final bool isAvailable;
  final int carYear;
  final String carMake;
  final String carModel;
  final String carColour;
  final String licensePlate;
  final String otherInfo;
 // final String role;

  DriverModel({
    this.id,
    required this.name, 
    required this.price, 
    required this.userId, // Only user ID
    required this.latitude,
    required this.longitude,
    required this.isAvailable,
    required this.carYear,
    required this.carMake,
    required this.carModel,
    required this.carColour,
    required this.licensePlate,
    required this.otherInfo,
   // required this.role,
  });

  // Fetch current location asynchronously
  static Future<DriverModel> fromJson(Map<String, dynamic> json) async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    return DriverModel(
      id: json['taxi_driver_id'] ?? 0,
      name: json['name'],
      price: json['price'],
      userId: json['rider_id'] ?? 0, // Extract only user ID
      latitude: position.latitude,
      longitude: position.longitude,
      isAvailable: json['is_available'] ?? false,
      carYear: json['car_year'] ?? 0,
      carMake: json['car_make'] ?? '',
      carModel: json['car_model'] ?? '',
      carColour: json['car_colour'] ?? '',
      licensePlate: json['license_plate'] ?? '',
      otherInfo: json['other_info'] ?? '',
     // role: json['user_role']?['name'] ?? 'user',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "latitude": latitude,
      "longitude": longitude,
      "is_available": isAvailable ? 1 : 0,
      "car_year": carYear,
      "car_make": carMake,
      "car_model": carModel,
      "car_colour": carColour,
      "license_plate": licensePlate,
      "other_info": otherInfo,
      //
    };
  }
}