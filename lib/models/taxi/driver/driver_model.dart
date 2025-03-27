import 'package:dailyfairdeal/models/user/user_model.dart';

class DriverModel {
  final int? id;
  final int? userId;
  final double latitude;
  final double longitude;
  final bool isAvailable;
  final int carYear;
  final String carMake;
  final String carModel;
  final String carColour;
  final String licensePlate;
  final String? driverLicenseNo;
  final String otherInfo;
  final UserModel? user;

  DriverModel({
    this.id,
    this.userId,
    required this.latitude,
    required this.longitude,
    required this.isAvailable,
    required this.carYear,
    required this.carMake,
    required this.carModel,
    required this.carColour,
    required this.licensePlate,
    this.driverLicenseNo,
    required this.otherInfo,
    this.user,
  });

  static DriverModel fromJson(Map<String, dynamic> json) {
    return DriverModel(
      id: json['id'] ?? 0,
      userId: json['rider_id'] ?? 0, // Extract only user ID
      latitude: json['latitude'],
      longitude: json['longitude'],
      isAvailable: json['is_available'] == 1,
      carYear: json['car_year'] ?? 0,
      carMake: json['car_make'] ?? '',
      carModel: json['car_model'] ?? '',
      carColour: json['car_colour'] ?? '',
      licensePlate: json['license_plate'] ?? '',
      driverLicenseNo: json['driver_license_number'] ?? '',
      otherInfo: json['other_info'] ?? '',
      user: json['user'] != null ? UserModel.fromJson(json["user"]): null,
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
      "driver_license_number": driverLicenseNo,
      "other_info": otherInfo,
    };
  }
}